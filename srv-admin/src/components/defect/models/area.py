import swapper
from django.contrib.auth.models import Group
from django.db import models
from django.utils.translation import gettext as _


class AbstractArea(models.Model):
    class Meta:
        abstract = True
        verbose_name = _("Raum")
        verbose_name_plural = _("Räume")
        ordering = ["name"]

    name = models.CharField(
        _("Name"),
        max_length=100,
    )

    sorting = models.PositiveSmallIntegerField(
        _("Sorting"),
        default=0,
    )

    visible_groups = models.ManyToManyField(
        Group,
        verbose_name=_("Visible groups"),
        blank=True,
        related_name="%(app_label)s_%(class)s_related",
        related_query_name="%(app_label)s_%(class)ss",
    )

    def __str__(self) -> str:
        return self.name


class Area(AbstractArea):
    class Meta(AbstractArea.Meta):
        swappable = swapper.swappable_setting("defect", "Area")
