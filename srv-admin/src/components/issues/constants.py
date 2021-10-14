
from django.utils.translation import gettext as _


AT_TEXT = ("1", _("Text"))
AT_DATE = ("2", _("Datum"))
AT_TIME = ("3", _("Zeit"))
AT_YESNO = ("4", _("Ja/Nein"))
AT_MULTCHOICE = ("5", _("Multiple Choice"))
AT_MULTCHOICE_MULT = ("6", _("Multiple Choice Mehrfachauswahl"))
AT_PHONE_NUMBER = ("7", _("Telefonnummer"))
AT_NUMBER = ("8", _("Zahl"))
AT_CONTRACT_PARTNER = ("9", _("Welcher Vertragspartner"))

ANSWER_TYPE = (
    AT_TEXT,
    AT_DATE,
    AT_TIME,
    AT_YESNO,
    AT_MULTCHOICE,
    AT_MULTCHOICE_MULT,
    AT_PHONE_NUMBER,
    AT_NUMBER,
    AT_CONTRACT_PARTNER,
)

SIGNING_CHOICE_DIGITAL = ('digi', 'digital')
SIGNING_CHOICE_ORIGINAL = ('orig', 'original')
SIGNING_CHOICES = (
    (SIGNING_CHOICE_DIGITAL), (SIGNING_CHOICE_ORIGINAL)
)