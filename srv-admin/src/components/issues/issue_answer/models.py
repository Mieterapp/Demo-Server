from ..models import Issue
from django.db import models
from django.utils.translation import gettext as _


from ..constants import ANSWER_TYPE


class IssueAnswer(models.Model):
    question = models.CharField(
        blank=False, null=False, max_length=150, verbose_name=_("Frage"), db_index=True
    )
    issue = models.ForeignKey(
        Issue, models.CASCADE, blank=True, null=True, related_name="questions"
    )
    type = models.CharField(
        max_length=2,
        choices=ANSWER_TYPE,
        default="1",
        db_index=True,
        verbose_name=_("Typ"),
    )
    multi = models.BooleanField(
        _("Mehrfachauswahl bei Multiple Choice Fragen moeglich"), default=False
    )
    marker = models.CharField(
        blank=False,
        null=False,
        max_length=100,
        db_index=True,
        verbose_name=_("Markierung in der HTML Vorlage"),
    )
    answers = models.CharField(
        blank=True,
        null=True,
        max_length=1024,
        verbose_name=_(
            "Auswahlmoeglichkeiten fuer MultipleChoice Fragen. Bitte Antworten mit ';' trennen."
        ),
        db_index=True,
    )
    sorting = models.IntegerField(default=1, verbose_name=_("Position"))
    required = models.BooleanField(_("Antwort erforderlich"), default=False)
    code = models.CharField(
        blank=True,
        null=True,
        max_length=100,
        db_index=True,
        verbose_name=_("Identifier im remote system"),
    )

    class Meta:
        verbose_name = _("Formular Antworten")
        verbose_name_plural = _("Formulare Antworten")
