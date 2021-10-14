from datetime import date

from django.contrib.auth import get_user_model
from django.utils.translation import gettext_lazy as _
from rest_framework import serializers
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.status import (
    HTTP_200_OK,
    HTTP_201_CREATED,
    HTTP_400_BAD_REQUEST,
    HTTP_410_GONE,
)
from rest_framework.views import APIView

from .models import PasswordResetToken


class PasswordResetSerializer(serializers.Serializer):
    email = serializers.EmailField(max_length=255)


class PasswordReset(APIView):
    authentication_classes = []
    permission_classes = (AllowAny,)
    serializer_class = PasswordResetSerializer

    def post(self, request, format=None):
        serializer = self.serializer_class(data=request.data)

        if serializer.is_valid():
            email = serializer.data["email"]

            try:
                user = get_user_model().objects.get(email=email)

                # Delete all unused password reset codes
                PasswordResetToken.objects.filter(user=user).delete()

                if user.is_verified and user.is_active:
                    print("before password reset")
                    password_reset_token = (
                        PasswordResetToken.objects.create_password_reset_token(user)
                    )
                    print("after password reset")
                    password_reset_token.send_password_reset_email()
                    content = {"email": email}
                    return Response(content, status=HTTP_201_CREATED)

            except get_user_model().DoesNotExist:
                pass

            # Since this is AllowAny, don't give away error.
            content = {"message": _("Password reset not allowed.")}
            return Response(content, status=HTTP_400_BAD_REQUEST)

        else:
            return Response(serializer.errors, status=HTTP_400_BAD_REQUEST)


class PasswordChangeSerializer(serializers.Serializer):
    token = serializers.CharField(max_length=40)
    password = serializers.CharField(max_length=128)


class PasswordChange(APIView):
    authentication_classes = []
    permission_classes = (AllowAny,)
    serializer_class = PasswordChangeSerializer

    def post(self, request, format=None):
        serializer = self.serializer_class(data=request.data)
        print("POST")
        print("request.data")
        print(request.data)
        if serializer.is_valid():
            token = serializer.data["token"]
            password = serializer.data["password"]
            print("try")
            print("serializer.data")
            print(serializer.data)
            try:
                pw_reset_token = PasswordResetToken.objects.get(token=token)
            except:
                print
                content = {"message": _("Reset token not found.")}
                return Response(content, status=HTTP_400_BAD_REQUEST)

            delta = date.today() - pw_reset_token.created_at.date()
            user = pw_reset_token.user
            pw_reset_token.delete()
            if delta.days > PasswordResetToken.objects.get_expiration_delta():
                content = {"message": _("Reset token expired.")}
                return Response(content, status=HTTP_410_GONE)

            user.set_password(password)
            user.save()

            content = {"message": _("Password reset.")}
            return Response(content, status=HTTP_200_OK)

        else:
            print("serializer.errors")
            print(serializer.errors)
            return Response(serializer.errors, status=HTTP_400_BAD_REQUEST)
