from django.contrib import admin
from django.contrib.admin import register
from django.utils.translation import gettext as _
from import_export.formats import base_formats

from .model import News


@register(News)
class NewsAdmin(admin.ModelAdmin):
    filter_horizontal = ("property",)
    list_display = (
        "title",
        "text",
        "document",
        "show_in_header",
        "date_from",
        "date_to",
        # "visible_object",
        # "visible_role",
        "order",
    )
    formats = (base_formats.CSV,)

    fieldsets = (
        (
            _("Formular"),
            {
                "fields": (
                    "title",
                    "text",
                    "document",
                    "href",
                    #"kind",
                    # "visible_role",
                    # "visible_object",
                    "show_in_header",
                    "property",
                    "date_from",
                    "date_to",
                    "order",
                )
            },
        ),
    )
