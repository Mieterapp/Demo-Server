from django.contrib import admin
from django.contrib.admin.decorators import register
from django.utils.translation import gettext as _

from src.components.content.offers.models import Offer


@register(Offer)
class MarketplaceAdmin(admin.ModelAdmin):
    list_display = (
        "title",
        "text",
        "icon",
        "website",
        "only_login",
        "only_guest",
        "report_clickes",
        "visible_role",
        "sorting",
        "date_from",
        "date_to",
    )
    # fieldsets = ('title','text','icon','website','only_login','only_guest','visible_role','sorting','date_from','date_to')
    fieldsets = (
        (
            _("Angebote"),
            {
                "fields": (
                    "title",
                    "text",
                    "icon",
                    "website",
                    "only_login",
                    "only_guest",
                    "visible_role",
                    "sorting",
                    "date_from",
                    "date_to",
                )
            },
        ),
    )

    def has_add_permission(self, request):
        return True

    def has_change_permission(self, request, obj=None):
        return True

    def has_module_permission(self, request):
        return True
