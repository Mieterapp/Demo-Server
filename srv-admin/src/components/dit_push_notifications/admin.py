from django.contrib import admin
from import_export.admin import ExportMixin
from django.utils.translation import gettext as _
from .models import PushNotifications
# Register your models here.

class PushNotificationAdmin(ExportMixin, admin.ModelAdmin):
    list_display = ("id", "message", "created_at")
    fieldsets = ((_("Nachricht"), {"fields": ("message",)}),)
    exclude = ("title", "id")
    # formats = (base_formats.CSV,)
