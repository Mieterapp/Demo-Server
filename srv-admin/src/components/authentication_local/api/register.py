from django.conf import settings
from django.contrib.auth import get_user_model
from django.core.exceptions import ImproperlyConfigured
from django.utils.translation import gettext as _
from rest_framework import serializers, status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView

from ..models import VerificationToken
from ..settings import al_settings
from ..utils import send_multi_format_email

import logging
logger = logging.getLogger(__name__)

User = get_user_model()

handle_register_user = al_settings.HANDLE_REGISTER_USER

if not handle_register_user:
    raise ImproperlyConfigured("HANDLE_REGISTER_USER is required")


class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ("email", "password", "contract", "birthdate", "principal_id", "is_data_accepted")
        required_fields = ("email", "password", "contract", "principal_id", "is_data_accepted")
        extra_kwargs = {"password": {"write_only": True}}

    # FIXME: move this to integrations module
    contract = serializers.CharField(allow_null=False, required=True)
    #birthdate = serializers.CharField(allow_null=False, required=True)
    principal_id = serializers.CharField(allow_null=False, required=True)
    is_data_accepted = serializers.BooleanField(allow_null=False, required=True)


class RegisterAPIView(APIView):
    authentication_classes = []
    permission_classes = (AllowAny,)
    serializer_class = RegisterSerializer

    def post(self, request, format=None):
        serializer = self.serializer_class(data=request.data)

        # TODO: fix serializer is not valid when email already exists!
        #       But we need to customize the verification and also check
        #       if the email is_verified
        if serializer.is_valid():
            logger.debug(f" RegisterAPIView REGISTRATION 2  {str(serializer)}")
            email = serializer.data["email"]
            password = serializer.validated_data.get("password")

            try:
                user = User.objects.get(email=email)

                if user.is_verified:
                    data = {
                        "message": _("User with this Email address already exists.")
                    }
                    return Response(data, status=status.HTTP_400_BAD_REQUEST)

                try:
                    signup_code = VerificationToken.objects.get(user=user)
                    signup_code.delete()
                except VerificationToken.DoesNotExist:
                    pass

            except User.DoesNotExist:
                try:
                    # TODO: check how ignore pylance warnings
                    '''
                    isdataaccepted = serializer.data["is_data_accepted"]
                    if not is_data_accepted:
                        data = {"message": _("The data security must be accepted.")}
                        return Response(data, status=status.HTTP_400_BAD_REQUEST)
                    '''

                    registration_data = handle_register_user(
                        email, password, serializer.data
                    )
                    if not registration_data["success"]:
                        data = {"message": _(registration_data["error"])}
                        return Response(data, status=status.HTTP_400_BAD_REQUEST)

                    user = registration_data["user"]
                except ValueError as e:
                    data = {"message": e.__str__()}
                    return Response(data, status=status.HTTP_400_BAD_REQUEST)

            user.set_password(password)

            must_validate_email = getattr(settings, "AUTH_EMAIL_VERIFICATION", True)
            if not must_validate_email:
                user.is_verified = True
                send_multi_format_email(
                    "welcome_email",
                    {
                        "email": user.email,
                    },
                    target_email=user.email,
                )
            user.save()

            if must_validate_email:
                signup_code = VerificationToken.objects.create_registration_token(user)
                signup_code.send_registration_email()

            message = {
                "message": "successfully registered user. Verify your email to login."
            }
            return Response(message, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
