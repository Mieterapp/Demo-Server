from django.contrib.auth.models import Group
from django.db import models
from django.utils.translation import gettext as _


class FAQ(models.Model):
    class Meta:
        verbose_name = _("FAQ")
        verbose_name_plural = _("FAQ")

    def __str__(self):
        return f"{self.id} {self.group} {self.title}"

    title = models.CharField(max_length=150, verbose_name=_("Titel"))
    text = models.TextField(verbose_name=_("Text"))
    visible_role = models.ForeignKey(
        Group, on_delete=models.SET_NULL, null=True, blank=True
    )
    visible_object = models.CharField(
        max_length=1024,
        verbose_name=_("Sichtbar für Objekt (Trennen mit ';')"),
        blank=True,
        null=True,
    )
    href = models.CharField(
        max_length=256, verbose_name=_("URL"), blank=True, null=True
    )

    group = models.CharField(
        max_length=150, verbose_name=_("Gruppe"), blank=True, null=True
    )
    sorting = models.IntegerField(_("Sortierung?"), default=10)
