import os
from datetime import datetime
from src.components.real_estate.properties.model import Property

from django.core.exceptions import ValidationError
from django.db import models
from django.utils.text import slugify
from django.utils.translation import gettext as _

from src.components.content.settings import dit_content_settings

NEWS_TYPES = (
    ("1", _("Information")),
    ("2", _("Angebot")),
)
import logging
logger = logging.getLogger(__name__)


def news_document_dir(instance, filename):
    """
    Return news directory

    :param instance: thumbnail
    :param filename: origin filename
    :return: new filename
    """
    now = datetime.now().strftime("%Y%m%d")
    #testvalue = slugify(os.path.splitext(filename)[0].lower())
    #logger.debug(f"news_document_dir(instance, filename) FEEDBACK A {testvalue}")
    filename = (
        slugify(os.path.splitext(filename)[0].lower())
        + "_"
        + now
        + os.path.splitext(filename)[1]
    )
    #logger.debug(f"news_document_dir(instance, filename) FEEDBACK B {instance}")
    #logger.debug(f"news_document_dir(instance, filename) FEEDBACK C {filename}")
    nw = "news-documents/%s" % filename.lower()
    #logger.debug(f"news_document_dir(instance, filename) FEEDBACK D {nw}")
    return nw


class News(models.Model):
    class Meta:
        verbose_name_plural = _("Neuigkeiten")
        verbose_name = _("Neuigkeit")
        ordering = ["order"]

    title = models.CharField(max_length=150, verbose_name=_("Titel"))
    text = models.TextField(verbose_name=_("Text"))
    document = models.FileField(
        upload_to=news_document_dir, blank=True, null=True, verbose_name=_("Dokument"),max_length=350)
    href = models.CharField(
        max_length=1024, blank=True, null=True, verbose_name=_("Link")
    )
    kind = models.CharField(
        max_length=2,
        choices=NEWS_TYPES,
        default="1",
        db_index=True,
        verbose_name=_("Art"),
    )
    show_in_header = models.BooleanField(
        default=True, verbose_name=_("Im Header anzeigen"))
    date_from = models.DateField(
        verbose_name=_("Ab Datum"), blank=True, null=True)
    date_to = models.DateField(verbose_name=_(
        "Bis Datum"), blank=True, null=True)
    order = models.PositiveIntegerField(default=0)
    property = models.ManyToManyField(
        Property, verbose_name=_("Sichbar für Properties"), null=True, blank=True
    )
    documents = models.CharField(max_length=350, verbose_name=_("Document_URL_App"), blank=True, null=True)

    def __str__(self):
        return f"{self.title}"

    def clean(self):
        # FIXME: type checks
        body_max_length = dit_content_settings.NEWS_BODY_MAX_LENGTH
        title_max_length = dit_content_settings.NEWS_TITLE_MAX_LENGTH

        if self.show_in_header and body_max_length < len(self.text):
            raise ValidationError(
                f"Bitte geben Sie nicht mehr als {body_max_length} Zeichen ein für eine News die im Header angezeigt werden soll!"
            )
        if self.show_in_header and title_max_length < len(self.title):
            raise ValidationError(
                f"Bitte geben Sie nicht mehr als {title_max_length} Zeichen ein für den Title einer News die im Header angezeigt werden soll!"
            )
