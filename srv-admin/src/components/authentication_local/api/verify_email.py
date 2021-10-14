from django.utils.translation import gettext_lazy as _
from rest_framework import serializers, status, viewsets, mixins
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView

from src.components.authentication_local.models import VerificationToken
import logging

logger = logging.getLogger(__name__)


class VerificationTokenSerializer(serializers.ModelSerializer):
    token = serializers.CharField()

    class Meta:
        model = VerificationToken
        fields = ("token",)


class VerifyEmailByToken(APIView):
    permission_classes = (AllowAny,)
    serializer_class = VerificationTokenSerializer

    def post(self, request, format=None):  # format=None #pk
        serializer = self.serializer_class(data=request.data)
        if serializer.is_valid():
            # logger.debug(f" post(self, request, format=None) REGISTRATION 2  {str(pk)}")
            logger.debug(f" post(self, request, format=None) REGISTRATION 2  {str(serializer)}")
            token = serializer.data["token"]
            verified = VerificationToken.objects.set_user_is_verified(token)

            if verified:
                try:
                    verification_token = VerificationToken.objects.get(token=token)
                    verification_token.delete()
                except VerificationToken.DoesNotExist:
                    pass
                content = {"message": _("User verified")}
                return Response(content, status=status.HTTP_200_OK)
            else:
                content = {"message": _("Unable to verify user")}
                return Response(content, status=status.HTTP_400_BAD_REQUEST)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

