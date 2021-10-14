from django.contrib.auth import get_user_model
from django.db import models
from django.utils.translation import gettext as _

UserModel = get_user_model()

SURVEY_TYPE = (
    ("1", _("Ankreuzen")),
    ("2", _("Text")),
    ("3", _("Zahl")),
    ("4", _("Range")),
    # ('4', _('Datum')),
    # ('5', _('Zeit')),
)


class Survey(models.Model):
    title = models.CharField(
        max_length=512, verbose_name=_("Umfrage"), blank=False, null=False
    )
    text = models.TextField(verbose_name=_("Beschreibung"), blank=True, null=True)
    text2 = models.TextField(verbose_name=_("Schlusswort"), blank=True, null=True)
    dialog = models.CharField(
        max_length=512, verbose_name=_("Nachricht in Dialog"), blank=False, null=False
    )
    visible_object = models.CharField(
        max_length=1024,
        verbose_name=_("Sichtbar für Objekt (Trennen mit ';')"),
        blank=True,
        null=True,
    )
    date_from = models.DateField(verbose_name=_(u"Ab Datum"), blank=True, null=True)
    date_to = models.DateField(verbose_name=_(u"Bis Datum"), blank=True, null=True)
    is_active = models.BooleanField(_("Aktiv"), default=False)
    member = models.IntegerField(verbose_name=_(u"Teilnehmer insgesamt"), default=0)

    def __unicode__(self):
        return self.title

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = _("Umfrage")
        verbose_name_plural = _("Umfragen")


class SurveyQuestion(models.Model):

    question = models.TextField(verbose_name=_("Frage"), blank=True, null=True)
    survey = models.ForeignKey(Survey, models.SET_NULL, blank=False, null=True)
    multi = models.BooleanField(
        _("Mehrfachauswahl bei Multiple Choice Fragen moeglich"), default=False
    )

    sorting = models.IntegerField(default=0, verbose_name=_("Position"))

    answer1 = models.CharField(
        max_length=512, verbose_name=_("Antwort 1."), blank=True, null=True
    )
    type1 = models.CharField(
        max_length=2,
        choices=SURVEY_TYPE,
        db_index=True,
        blank=False,
        null=False,
        verbose_name=_("Typ Frage 1."),
    )
    count1 = models.IntegerField(default=0, verbose_name=_("Antwort 1. gewählt"))

    answer2 = models.CharField(
        max_length=512, verbose_name=_("Antwort 2."), blank=True, null=True
    )
    type2 = models.CharField(
        max_length=2,
        choices=SURVEY_TYPE,
        db_index=True,
        blank=True,
        null=True,
        verbose_name=_("Typ Frage 2."),
    )
    count2 = models.IntegerField(default=0, verbose_name=_("Antwort 2. gewählt"))

    answer3 = models.CharField(
        max_length=512, verbose_name=_("Antwort 3."), blank=True, null=True
    )
    type3 = models.CharField(
        max_length=2,
        choices=SURVEY_TYPE,
        db_index=True,
        blank=True,
        null=True,
        verbose_name=_("Typ Frage 3."),
    )
    count3 = models.IntegerField(default=0, verbose_name=_("Antwort 3. gewählt"))

    answer4 = models.CharField(
        max_length=512, verbose_name=_("Antwort 4."), blank=True, null=True
    )
    type4 = models.CharField(
        max_length=2,
        choices=SURVEY_TYPE,
        db_index=True,
        blank=True,
        null=True,
        verbose_name=_("Typ Frage 4."),
    )
    count4 = models.IntegerField(default=0, verbose_name=_("Antwort 4. gewählt"))

    answer5 = models.CharField(
        max_length=512, verbose_name=_("Antwort 5."), blank=True, null=True
    )
    type5 = models.CharField(
        max_length=2,
        choices=SURVEY_TYPE,
        db_index=True,
        blank=True,
        null=True,
        verbose_name=_("Typ Frage 5."),
    )
    count5 = models.IntegerField(default=0, verbose_name=_("Antwort 5. gewählt"))

    answer6 = models.CharField(
        max_length=512, verbose_name=_("Antwort 6."), blank=True, null=True
    )
    type6 = models.CharField(
        max_length=2,
        choices=SURVEY_TYPE,
        db_index=True,
        blank=True,
        null=True,
        verbose_name=_("Typ Frage 6."),
    )
    count6 = models.IntegerField(default=0, verbose_name=_("Antwort 6. gewählt"))

    def __unicode__(self):
        return self.question

    class Meta:
        verbose_name = _("Umfrage Frage")
        verbose_name_plural = _("Umfrage Fragen")


class SurveyAnswersText(models.Model):
    question = models.ForeignKey(
        SurveyQuestion, models.SET_NULL, blank=False, null=True
    )
    user = models.ForeignKey(UserModel, models.SET_NULL, blank=True, null=True)
    answer1 = models.TextField(verbose_name=_("zu Antwort 1."), blank=True, null=True)
    answer2 = models.TextField(verbose_name=_("zu Antwort 2."), blank=True, null=True)
    answer3 = models.TextField(verbose_name=_("zu Antwort 3."), blank=True, null=True)
    answer4 = models.TextField(verbose_name=_("zu Antwort 4."), blank=True, null=True)
    answer5 = models.TextField(verbose_name=_("zu Antwort 5."), blank=True, null=True)
    answer6 = models.TextField(verbose_name=_("zu Antwort 6."), blank=True, null=True)

    class Meta:
        verbose_name = _("Umfrage Textantwort der Mieter")


class SurveyMembers(models.Model):
    survey = models.ForeignKey(Survey, models.SET_NULL, blank=False, null=True)
    user = models.ForeignKey(UserModel, models.SET_NULL, blank=False, null=True)

    class Meta:
        verbose_name = _("Umfragen Teilnehmer")
