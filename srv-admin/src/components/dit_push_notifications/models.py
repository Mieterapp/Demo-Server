from django.db import models
from django.utils.translation import gettext as _
# Create your models here.

class PushNotifications(models.Model):
    title = models.TextField(verbose_name=_("Title"))
    message = models.TextField(verbose_name=_("Nachricht"))
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)

    class Meta:
        verbose_name = _("Push-Nachricht")
        verbose_name_plural = _("Push-Nachrichten")
