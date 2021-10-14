from src.components.issues.issue.models import Issue
from django.contrib.auth import get_user_model

from django.db import models
from django.utils.translation import gettext as _

UserModel = get_user_model()


class IssueRequested(models.Model):
    class Meta:
        verbose_name = _("Angefordertes Formular")
        verbose_name_plural = _("Angeforderte Formulare")

    user = models.ForeignKey(UserModel, models.SET_NULL, null=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True, db_index=True)
    issue = models.ForeignKey(
        Issue,
        models.SET_NULL,
        null=True,
        verbose_name=_("Anliegen"),
    )
    answers = models.TextField(blank=True, null=True)
    status = models.CharField(
        max_length=64, verbose_name=_("Status"), blank=True, null=True
    )
    code = models.CharField(
        max_length=100,
        verbose_name=_("Identifier of external system"),
        blank=True,
        null=True,
    )
