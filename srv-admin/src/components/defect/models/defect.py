import swapper
from django.contrib.auth.models import Group
from django.db import models
from django.utils.translation import gettext as _

from ..settings import dit_defect_settings


class AbstractDefect(models.Model):
    class Meta:
        abstract = True
        verbose_name = _("Defect")
        verbose_name_plural = _("Defects")
        ordering = ["name"]

    name = models.CharField(
        _("Name"),
        max_length=100,
    )

    visible_groups = models.ManyToManyField(
        Group,
        verbose_name=_("Visible groups"),
        blank=True,
        related_name="%(app_label)s_%(class)s_related",
        related_query_name="%(app_label)s_%(class)ss",
    )

    defect_type = models.ForeignKey(
        swapper.get_model_name("defect", "DefectType"),
        verbose_name=_("Defect type"),
        on_delete=models.SET_NULL,
        blank=True,
        null=True,
        related_name="%(app_label)s_%(class)s_related",
        related_query_name="%(app_label)s_%(class)ss",
    )

    area = models.ForeignKey(
        swapper.get_model_name("defect", "Area"),
        verbose_name=_("Area"),
        on_delete=models.SET_NULL,
        blank=True,
        null=True,
        related_name="%(app_label)s_%(class)s_related",
        related_query_name="%(app_label)s_%(class)ss",
    )

    show_emergency_alert = models.BooleanField(
        _("Show emergency alert?"),
        default=dit_defect_settings.SHOW_EMERGENCY_ALERT,
    )

    is_image_required = models.BooleanField(
        _("Is image required?"),
        default=dit_defect_settings.IS_IMAGE_REQUIRED_DEFAULT,
    )

    def __str__(self) -> str:
        return self.name


class Defect(AbstractDefect):
    class Meta(AbstractDefect.Meta):
        swappable = swapper.swappable_setting("defect", "Defect")
