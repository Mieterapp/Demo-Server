from django.contrib import admin
from django.contrib.admin.decorators import register
from django.utils.translation import gettext as _

from .model import Page


@register(Page)
class MarketplaceAdmin(admin.ModelAdmin):
    list_display = ("slug", "html")
