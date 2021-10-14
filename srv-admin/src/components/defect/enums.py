from django.db import models
from django.utils.translation import gettext as _

from src.components.common.enums import StatusMixin


class DefectStatus(StatusMixin, models.TextChoices):
    CREATED = "1", _("Created")
    ACCEPTED = "2", _("Accepted")
    IN_PROGRESS = "3", _("In progress")
    CRAFTSMEN_ON_THE_WAY = "4", _("Craftsmen on the way")
    COMPLETED = "5", _("Completed")
