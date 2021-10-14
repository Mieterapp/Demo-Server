from django.contrib import admin
from django.contrib.admin.decorators import register
from django.utils.translation import gettext as _

from .models import VerificationToken


@register(VerificationToken)
class VerificationTokenAdmin(admin.ModelAdmin):
    list_display = ("user", "token", "created_at")
