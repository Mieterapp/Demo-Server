from django.contrib import admin
from django.contrib.admin.decorators import register
from import_export.admin import ExportMixin
from rest_framework.response import Response
from rest_framework.status import HTTP_400_BAD_REQUEST, HTTP_404_NOT_FOUND

from .models import (Survey, SurveyQuestion, SurveyAnswersText, SurveyMembers)
from push_notifications.models import APNSDevice, GCMDevice
import logging

logger = logging.getLogger(__name__)


def send_pushnotification(modeladmin, request, queryset):
    print("send pushnotification")
    message = "some message"
    title = "some title"

    devicesAPNS = APNSDevice.objects.all().filter(active=True)
    typeofpush = "some type"
    docidextra = "some extra"
    if len(devicesAPNS) != 0:
        for device in devicesAPNS:
            logger.debug(f"APNSDevice INFORMATION C {device}")
            device.send_message(message, extra={"title": title, "type": typeofpush, "doc_id": docidextra},
                                badge=1)

    devicesGCM = GCMDevice.objects.all().filter(active=True)
    if len(devicesGCM) != 0:
        for device in devicesGCM:
            logger.debug(f"GCMDevice INFORMATION C {device}")
            device.send_message(message, extra={"title": title, "type": typeofpush, "doc_id": docidextra},
                                badge=1)


@register(SurveyQuestion)
class SurveyQuestionAdmin(ExportMixin, admin.ModelAdmin):
    actions = [send_pushnotification, ]
    list_display = (
        "id",
        "question",
        "survey",
        "multi",
        "sorting",
        "count1",
        "count2",
        "count3",
        "count4",
        "count5",
        "count6",
    )


@register(SurveyAnswersText)
class SurveyAnswersTextAdmin(ExportMixin, admin.ModelAdmin):
    list_display = ("id", "question", "user")


@register(SurveyMembers)
class SurveyMembersAdmin(ExportMixin, admin.ModelAdmin):
    list_display = ("id", "survey", "user")


@register(Survey)
class SurveyAdmin(ExportMixin, admin.ModelAdmin):
    list_display = (
        "id",
        "title",
        "text",
        "visible_object",
        "date_from",
        "date_to",
        "member",
        "is_active",
        "dialog",
    )
