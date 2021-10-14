import logging
from hashlib import sha256
import time

from django.contrib.auth import get_user_model
from push_notifications.models import APNSDevice, GCMDevice
from rest_framework import permissions, serializers
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.status import HTTP_400_BAD_REQUEST, HTTP_404_NOT_FOUND
from rest_framework import viewsets
from rest_framework.permissions import AllowAny

from src.components.dit_push_notifications.settings import (
    dit_push_notifications_settings,
)

logger = logging.getLogger(__name__)

UserModel = get_user_model()
PUSH_NOTIFICATION_SECRET = dit_push_notifications_settings.PUSH_NOTIFICATION_SECRET


class PingView(viewsets.ReadOnlyModelViewSet):
    permission_classes = (AllowAny,)
    print("--------------BEFORE-------")
    # create settings to mock APNSDevice if local
    # queryset = APNSDevice.objects.all().first()
    print("--------------AFTER-------")

    def list(self, request):
        logger.debug("Ping Test")
        logger.debug(f"PingView")
        return Response([{"status": "OK"}])


class PushNotificationSecretSerializer(serializers.Serializer):
    hash = serializers.CharField(allow_null=False, required=True)
    principal_id = serializers.CharField(allow_null=False, required=True)
    timestamp = serializers.IntegerField(allow_null=False, required=True)


class PushNotificationPostSerializer(serializers.Serializer):
    hash = serializers.CharField(allow_null=False, required=True)
    message = serializers.CharField(allow_null=False, required=True)
    object_id = serializers.CharField(allow_null=False, required=True)
    principal_id = serializers.CharField(allow_null=False, required=True)
    timestamp = serializers.IntegerField(allow_null=False, required=True)
    title = serializers.CharField(allow_null=False, required=True)
    type = serializers.CharField(allow_null=False, required=True)


class PushNotificationPermission(permissions.BasePermission):
    """
    Check request for secret hash
    """

    def has_permission(self, request, view):
        serializer = PushNotificationSecretSerializer(data=request.data)
        if not serializer.is_valid():
            logger.debug("WRONG DATA")
            return False
        ts = int(time.time())
        TIMESTAMP_DIF_SAP = 3600 * 2
        testtime = ts + TIMESTAMP_DIF_SAP
        logger.debug(f"has_permission A {testtime}")
        logger.debug(f"has_permission INFOS {serializer}")
        try:
            principal_id = serializer.data["principal_id"]
            timestamp = serializer.data["timestamp"]
            check_string = f"{PUSH_NOTIFICATION_SECRET}{principal_id}{timestamp}"

            if (ts + TIMESTAMP_DIF_SAP) >= timestamp and (ts - TIMESTAMP_DIF_SAP) <= timestamp:
                hash_check = sha256(check_string.encode()).hexdigest()
                logger.debug(f"has_permission A {hash_check}")
                hashtest = serializer.data["hash"].lower()
                logger.debug(f"has_permission B {hashtest}")
                if hash_check == hashtest:
                    hash_in = serializer.data["hash"].lower()
                    logger.debug(f"has_permission C {hashtest}")
                    return hash_check == hash_in
                else:
                    logger.debug("WRONG HASH")
                    return False
            else:
                logger.debug("WRONG TIMESTAMP")
                return False
        except:
            logger.debug("WRONG DATA")
            return False


@api_view(["POST"])
@permission_classes((PushNotificationPermission,))
def send_push_notification(request):
    serializer = PushNotificationPostSerializer(data=request.data)
    if serializer.is_valid():
        principal_id = serializer.data["principal_id"]
        message = serializer.data["message"]
        title = serializer.data["title"]

        try:
            user = UserModel.objects.get(principal_id=principal_id)
            devicesAPNS = APNSDevice.objects.all().filter(active=True, user=user)
            if len(devicesAPNS) == 0:
                logger.debug(
                    f"user with principal_id: {user.principal_id} does not have devices registered"
                )
            logger.debug(f"APNSDevice INFORMATION C {serializer.data}")
            typeofpush = serializer.data["type"]
            docidextra = serializer.data["doc_id"]
            if len(devicesAPNS) != 0:
                for device in devicesAPNS:
                    logger.debug(f"APNSDevice INFORMATION C {device}")
                    device.send_message(message, extra={"title": title, "type": typeofpush, "doc_id": docidextra},
                                        badge=1)

            userGCM = UserModel.objects.get(principal_id=principal_id)
            devicesGCM = GCMDevice.objects.all().filter(active=True, user=userGCM)
            if len(devicesGCM) == 0:
                logger.debug(
                    f"user with principal_id: {userGCM.principal_id} does not have devices registered"
                )
            logger.debug(f"GCMDevice INFORMATION C {serializer.data}")
            if len(devicesGCM) != 0:
                for device in devicesGCM:
                    logger.debug(f"GCMDevice INFORMATION C {device}")
                    device.send_message(message, extra={"title": title, "type": typeofpush, "doc_id": docidextra},
                                        badge=1)

            return Response({"message": "send"})

        except UserModel.DoesNotExist:
            return Response(
                {"message": "could not find user with this id"},
                status=HTTP_404_NOT_FOUND,
            )

    return Response(serializer.errors, status=HTTP_400_BAD_REQUEST)
