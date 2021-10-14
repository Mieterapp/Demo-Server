from django.utils.translation import gettext_lazy as _
from django.core.validators import EmailValidator, ValidationError
from rest_framework import serializers, status, viewsets, mixins
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView
from inspect import currentframe, getframeinfo
from django.contrib.auth import get_user_model

from src.shared.utils.token_operation import extract_keys_from_token
from src.components.authentication_local.invitation.models import InvitationToken
import logging

User = get_user_model()

logger = logging.getLogger(__name__)

class InviteSerializer(serializers.Serializer):
    email = serializers.EmailField(max_length=255)
    username = serializers.EmailField(max_length=255)
    code = serializers.CharField(max_length=25)

class InviteByEmail(APIView):
    # comment
    # permission_classes = (IsAuthenticated,)
    permission_classes = (AllowAny,)
    serializer_class = InviteSerializer

    # todo endpoint with principal_id and contract_id

    def post(self, request):  # format=None #pk
        #jwt_token = request.META.get('HTTP_AUTHORIZATION')
        #logger.debug(f"sent invitation token {jwt_token}")
        #logger.debug(f"sent invitation token {request.META}")
        logger.debug(f"sent invitation token {request.data}")
        user_name = request.data.get("username")
        logger.debug(f"sent invitation token {user_name}")
        #user_name = extract_keys_from_token(jwt_token, ["username"]).get("username")
        # comment
        user = User.objects.get(email=user_name)
        if user==None:
            content = {"message": _("could not find user")}
            return Response(content, status=status.HTTP_400_BAD_REQUEST)
        print("user.values")
        print(user.__dict__)
        principal_id = user.principal_id
        #contract_id = user.code
        contract_id = request.data.get("code")
        #contract_id = "123003213"
        logger.debug(f"sent invitation token {contract_id}")
        email = request.data.get("email")
        serializer = self.serializer_class(data={"email": email, "username": user_name, "code": contract_id})
        if serializer.is_valid():
            email = serializer.data["email"]
            try:
                invitation_token = (
                    InvitationToken.objects.create_invitation_token(
                        user, email, principal_id, contract_id
                    )
                )
                invitation_token.send_invitation_email()
                logger.debug(f"sent invitation to {email}")
                content = {"message": f"sent invitation to {email}"}

                return Response(content, status=status.HTTP_200_OK)

            except ValidationError:
                content = {"message": _("could not create invitation email")}
                return Response(content, status=status.HTTP_400_BAD_REQUEST)

        return Response(status=status.HTTP_400_BAD_REQUEST)


class InvitationData(APIView):
    permission_classes = (AllowAny,)

    def get(self, request, token):
        invitation_data = InvitationToken.objects.filter(token=token).first()
        content = {
            "principal_id": invitation_data.principal_id,
            "contract_id": invitation_data.contract_id,
            "email": invitation_data.target_email,
        }
        invitation_data.delete()

        return Response(content, status=200)
