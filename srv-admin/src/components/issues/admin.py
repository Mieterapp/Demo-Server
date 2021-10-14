from django.contrib import admin
from django.contrib.admin.decorators import register
from django.utils.translation import gettext as _
from import_export.admin import ExportMixin

from .models import Issue, IssueRequested, IssueAnswer


@register(Issue)
class IssueAdmin(ExportMixin, admin.ModelAdmin):
    list_display = (
        "id",
        "group",
        "category",
        "visible_role",
        "version",
        "signing_type",
        "requires_printing",
        "requires_signature",
        "sorting",
        "attachment",
        "code",
    )


@register(IssueAnswer)
class IssueAnswerAdmin(ExportMixin, admin.ModelAdmin):
    list_display = (
        "id",
        "issue",
        "question",
        "required",
        "sorting",
        "type",
        "marker",
        "multi",
        "code",
    )
    fieldsets = (
        (
            _("Frage"),
            {
                "fields": (
                    "issue",
                    "question",
                    "required",
                    "sorting",
                    "type",
                    "marker",
                    "answers",
                    "code",
                )
            },
        ),
    )


@register(IssueRequested)
class IssueRequestedAdmin(ExportMixin, admin.ModelAdmin):
    list_display = ("user", "issue", "created_at", "status", "code")
