import swapper
from django.db import models
from django.utils.translation import gettext as _


class AbstractDefectResolutionRating(models.Model):
    class Meta:
        abstract = True
        verbose_name = _("Defect resolution rating")
        verbose_name_plural = _("Defect resolution ratings")

    reported_defect = models.ForeignKey(
        swapper.get_model_name("defect", "ReportedDefect"),
        related_name="%(app_label)s_%(class)s_related",
        related_query_name="%(app_label)s_%(class)ss",
        verbose_name=_("Reported defect"),
        on_delete=models.CASCADE,
        null=True,
    )

    created_at = models.DateTimeField(
        _("Created at"),
        auto_now_add=True,
    )

    is_defect_resolved = models.BooleanField(
        _("Is defect resolved?"),
    )


class DefectResolutionRating(AbstractDefectResolutionRating):
    class Meta(AbstractDefectResolutionRating.Meta):
        swappable = swapper.swappable_setting("defect", "DefectResolutionRating")

    craftsman_rating = models.PositiveIntegerField(
        _("Craftsman rating"),
    )
