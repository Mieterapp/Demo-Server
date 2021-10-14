from django.conf.urls import include, url
from src.components.dit_push_notifications.views import send_push_notification, PingView
from push_notifications.api.rest_framework import APNSDeviceAuthorizedViewSet, GCMDeviceAuthorizedViewSet

from django.urls import path
from rest_framework.routers import DefaultRouter


from . import NS

app_name = NS

router = DefaultRouter()

router.register('push-notifications/register-device/apns', APNSDeviceAuthorizedViewSet, basename="register-device-apns")
router.register('push-notifications/register-device/gcm', GCMDeviceAuthorizedViewSet, basename="register-device-gcm")
router.register('pingtest', PingView, basename="pingtest")


urlpatterns = [
    url(r'', include(router.urls)),
    url(r"^push-notifications/send-message/?$", send_push_notification),
]
