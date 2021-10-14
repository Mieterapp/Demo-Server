import swapper
from django.conf import settings
from django.contrib.auth import get_user_model
from django.db import models
from django.utils.translation import gettext as _
from easy_thumbnails.exceptions import InvalidImageFormatError
from easy_thumbnails.files import get_thumbnailer
from imagekit.models import ProcessedImageField
from imagekit.processors import ResizeToFit

from src.components.real_estate.contract.model import Contract
from src.shared.utils.get_prefixed_path import get_prefixed_path

from ..settings import dit_defect_settings

User = get_user_model()

STATUS_CHOICES = dit_defect_settings.STATUS_CHOICES
STATUS_DEFAULT = STATUS_CHOICES.get_value(dit_defect_settings.STATUS_DEFAULT)


class AbstractReportedDefect(models.Model):
    class Meta:
        abstract = True
        verbose_name = _("Reported defect")
        verbose_name_plural = _("Reported defects")
        ordering = ["-created_at"]

    reported_by = models.ForeignKey(
        User,
        verbose_name=_("User"),
        on_delete=models.CASCADE,
        null=True,
        related_name="%(app_label)s_%(class)s_related",
        related_query_name="%(app_label)s_%(class)ss",
    )

    contract = models.ForeignKey(
        swapper.get_model_name("real_estate", "Contract"),
        verbose_name=Contract._meta.verbose_name,
        null=True,
        blank=True,
        on_delete=models.CASCADE,
        related_name="%(app_label)s_%(class)s_related",
        related_query_name="%(app_label)s_%(class)ss",
    )

    created_at = models.DateTimeField(
        _("Created at"),
        auto_now_add=True,
    )

    updated_at = models.DateTimeField(
        _("Updated at"),
        auto_now=True,
    )

    status = models.CharField(
        _("Status"),
        max_length=50,
        choices=STATUS_CHOICES.choices,
        default=STATUS_DEFAULT,
    )

    description = models.TextField(
        _("Description"),
    )

    defect = models.ForeignKey(
        swapper.get_model_name("defect", "Defect"),
        verbose_name=_("Defect"),
        on_delete=models.SET_NULL,
        null=True,
        related_name="%(app_label)s_%(class)s_related",
        related_query_name="%(app_label)s_%(class)ss",
    )

    image_1 = ProcessedImageField(
        verbose_name=_("Image 1"),
        upload_to=get_prefixed_path,
        blank=True,
        null=True,
        processors=[ResizeToFit(800, 600)],
        format="JPEG",
        options={"quality": 80},
    )

    image_2 = ProcessedImageField(
        verbose_name=_("Image 2"),
        upload_to=get_prefixed_path,
        blank=True,
        null=True,
        processors=[ResizeToFit(800, 600)],
        format="JPEG",
        options={"quality": 80},
    )

    def __str__(self) -> str:
        return self.reported_by.__str__()

    @property
    def image_1_thumbnail(self):
        if not self.image_1:
            return None
        try:
            return get_thumbnailer(self.image_1).get_thumbnail(settings.THUMBNAIL_ALIASES[""]["default"])
        except InvalidImageFormatError:
            return None

    @property
    def image_2_thumbnail(self):
        if not self.image_2:
            return None
        try:
            return get_thumbnailer(self.image_2).get_thumbnail(settings.THUMBNAIL_ALIASES[""]["default"])
        except InvalidImageFormatError:
            return None


class ReportedDefect(AbstractReportedDefect):
    class Meta(AbstractReportedDefect.Meta):
        swappable = swapper.swappable_setting("defect", "ReportedDefect")
