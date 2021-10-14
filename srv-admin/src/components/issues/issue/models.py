import os
from datetime import datetime
from uuid import uuid4

from django.contrib.auth.models import Group
from django.db import models
from django.utils.text import slugify
from django.utils.translation import gettext as _
from imagekit.models.fields import ProcessedImageField
from pilkit.processors import ResizeToFill

from ..constants import SIGNING_CHOICE_ORIGINAL, SIGNING_CHOICES


def formular_background_dir(instance, filename):
    """
    Return photo directory

    :param instance: thumbnail
    :param filename: origin filename
    :return: new filename
    """
    filename = uuid4().hex + os.path.splitext(filename)[1]
    nw = "formular_background/%s" % filename.lower()
    return nw


def formular_document_dir(instance, filename):
    """
    Return photo directory

    :param instance: thumbnail
    :param filename: origin filename
    :return: new filename
    """
    now = datetime.now().strftime("%Y%m%d")
    filename = (
        slugify(os.path.splitext(filename)[0].lower())
        + "_"
        + now
        + os.path.splitext(filename)[1]
    )
    nw = "formular/%s" % filename.lower()
    return nw


FORMULAR_DISPLAY_LOCATION = ((1, _("Anliegen")), (2, _("Dokumente")))


class Issue(models.Model):
    group = models.CharField(
        max_length=100, verbose_name=_("Gruppe"), db_index=True, blank=True, null=True
    )
    display_location = models.IntegerField(
        choices=FORMULAR_DISPLAY_LOCATION, default=FORMULAR_DISPLAY_LOCATION[0][0]
    )
    title = models.CharField(max_length=200, verbose_name=_("Title"), db_index=True)
    html = models.TextField(
        blank=False,
        null=False,
        verbose_name=_("HTML, erstellt mit: www.pdftohtml.net"),
        default="<html></html>",
    )
    background = ProcessedImageField(
        upload_to=formular_background_dir,
        blank=True,
        null=True,
        processors=[ResizeToFill(761, 1075)],
        format="JPEG",
        options={"quality": 90},
    )
    background2 = ProcessedImageField(
        upload_to=formular_background_dir,
        blank=True,
        null=True,
        processors=[ResizeToFill(761, 1075)],
        format="JPEG",
        options={"quality": 90},
    )
    attachment = models.FileField(
        upload_to=formular_document_dir, blank=True, null=True, verbose_name=_("Anhang")
    )

    visible_role = models.ForeignKey(
        Group, on_delete=models.SET_NULL, null=True, blank=True
    )
    version = models.CharField(
        max_length=100, verbose_name=_("Version"), db_index=True, default="1.0"
    )
    signing_type = models.CharField(
        max_length=4, choices=SIGNING_CHOICES, blank=True, null=True
    )
    description = models.TextField(
        blank=True, null=True, verbose_name=_("Beschreibung")
    )
    sorting = models.IntegerField(default=1, verbose_name=_("Position"))
    codegrp = models.CharField(
        max_length=200,
        verbose_name=_("Codegruppe"),
        db_index=True,
        blank=True,
        null=True,
    )
    code = models.CharField(
        max_length=200, verbose_name=_("Code"), db_index=True, blank=True, null=True
    )
    type = models.CharField(
        max_length=200,
        verbose_name=_("Meldungsart"),
        db_index=True,
        blank=True,
        null=True,
        default="IV",
    )
    description_postman=models.TextField(
        blank=True,
        null=True,
        verbose_name=_("Postman Beschreibung"),
    )
    category = models.CharField(
        max_length=200, verbose_name=_("Kategorie"), blank=True, null=True
    )

    @property
    def requires_printing(self):
        return self.signing_type == SIGNING_CHOICE_ORIGINAL[0]

    @property
    def requires_signature(self):
        return self.signing_type is not None

    def __str__(self):
        return self.title

    def __unicode__(self):
        return self.title

    class Meta:
        verbose_name = _("Formular PDF")
        verbose_name_plural = _("Formulare PDF")
