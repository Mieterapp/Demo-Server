from django.contrib import admin
from import_export.admin import ExportMixin, ImportMixin
from django.contrib.admin.decorators import register

from .model import Property


@register(Property)
class PropertyAdmin(ImportMixin, ExportMixin, admin.ModelAdmin):
    list_display = ("id", "entity", "object", "street", "number", "zip", "center")
