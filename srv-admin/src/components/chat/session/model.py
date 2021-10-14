from django.contrib.auth import get_user_model
from django.db import models
from django.utils.translation import gettext as _

UserModel = get_user_model()


class Session(models.Model):
    class Meta:
        verbose_name = _("Chat Session")
        verbose_name_plural = _("Chat Sessions")

    is_customer_session = models.BooleanField(default=True)
    code = models.CharField(
        max_length=150, verbose_name=_("Eindeutige Session ID im externen System")
    )
    user = models.ForeignKey(
        UserModel, on_delete=models.CASCADE, blank=False, null=False
    )
