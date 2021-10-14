from django.contrib.auth import authenticate
from django.utils.translation import gettext as _
from rest_framework import serializers, status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_jwt.utils import jwt_encode_handler, jwt_payload_handler


class AuthenticateSerializer(serializers.Serializer):
    email = serializers.EmailField(max_length=255)
    password = serializers.CharField(max_length=128)


class Authenticate(APIView):
    authentication_classes = []
    permission_classes = (AllowAny,)
    serializer_class = AuthenticateSerializer

    def post(self, request, format=None):
        serializer = self.serializer_class(data=request.data)

        if serializer.is_valid():
            email = serializer.data["email"]
            password = serializer.data["password"]
            user = authenticate(email=email, password=password)
            if user:
                if user.is_verified:
                    if user.is_active:
                        payload = jwt_payload_handler(user)
                        token = jwt_encode_handler(payload)
                        return Response({"token": token}, status=status.HTTP_200_OK)
                    else:
                        content = {"message": _("User account not active.")}
                        return Response(content, status=status.HTTP_401_UNAUTHORIZED)
                else:
                    content = {"message": _("User account not verified.")}
                    return Response(content, status=status.HTTP_401_UNAUTHORIZED)
            else:
                content = {"message": _("Unable to login with provided credentials.")}
                return Response(content, status=status.HTTP_401_UNAUTHORIZED)

        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
