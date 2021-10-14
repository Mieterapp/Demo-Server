from django.contrib import admin
from django.contrib.admin.decorators import register
from django.utils.translation import gettext as _
from import_export import resources
from import_export.admin import ExportMixin
from import_export.formats import base_formats

from .models import FAQ


@register(FAQ)
class FAQAdmin(ExportMixin, admin.ModelAdmin):
    list_display = ("title", "text")
    fieldsets = (
        (
            _("FAQ"),
            {
                "fields": (
                    "title",
                    "text",
                    "visible_role",
                    # "visible_object",
                    "href",
                    #"group",
                    "sorting",
                )
            },
        ),
    )
