import swapper
from django.contrib.auth.models import Group
from django.db import models
from django.utils.translation import gettext as _


class AbstractDefectType(models.Model):
    class Meta:
        abstract = True
        verbose_name = _("Defect type")
        verbose_name_plural = _("Defect types")
        ordering = ["name"]

    name = models.CharField(
        _("Name"),
        max_length=100,
    )

    description = models.CharField(
        _("Description"),
        max_length=100,
        blank=True,
        null=True,
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

    areas = models.ManyToManyField(
        swapper.get_model_name("defect", "Area"),
        verbose_name=_("Areas"),
        blank=True,
        related_name="%(app_label)s_%(class)s_related",
        related_query_name="%(app_label)s_%(class)ss",
    )

    def __str__(self) -> str:
        return self.name


class DefectType(AbstractDefectType):
    class Meta(AbstractDefectType.Meta):
        swappable = swapper.swappable_setting("defect", "DefectType")
