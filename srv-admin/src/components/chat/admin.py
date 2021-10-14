from django.contrib import admin

from src.components.chat.session.model import Session


@admin.register(Session)
class SessionAdmin(admin.ModelAdmin):
    list_display = (
        "user",
        "code",
    )
