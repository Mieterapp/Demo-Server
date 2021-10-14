import os
from uuid import uuid4

from django.contrib.auth.models import Group
from django.db import models
from django.utils.translation import gettext as _
from imagekit.models import ProcessedImageField
from pilkit.processors import ResizeToFill


def marketplace_photo_dir(instance, filename):
    """
    Return photo directory

    :param instance: thumbnail
    :param filename: origin filename
    :return: new filename
    """
    filename = uuid4().hex + os.path.splitext(filename)[1]
    nw = "marketplace/%s" % filename.lower()
    return nw


class Offer(models.Model):
    title = models.CharField(max_length=150, verbose_name=_("Titel"))
    text = models.TextField(verbose_name=_("Text"))
    icon = ProcessedImageField(
        upload_to=marketplace_photo_dir,
        blank=True,
        null=True,
        processors=[ResizeToFill(640, 480)],
        format="PNG",
        options={"quality": 100},
    )
    website = models.CharField(max_length=250, verbose_name=_("Webseite"))
    hidden = models.BooleanField(_("Ausblenden"), default=False)
    only_login = models.BooleanField(_("Sichtbar für registrierte User"), default=True)
    only_guest = models.BooleanField(
        _("Sichtbar für nicht-registrierte User"), default=True
    )
    visible_role = models.ForeignKey(
        Group, on_delete=models.SET_NULL, null=True, blank=True
    )
    report_clickes = models.IntegerField(default=0)
    sorting = models.IntegerField(default=0)
    date_from = models.DateField(verbose_name=_(u"Ab Datum"), blank=True, null=True)
    date_to = models.DateField(verbose_name=_(u"Bis Datum"), blank=True, null=True)
    icons = models.CharField(max_length=350, verbose_name=_("Icon_URL_App"), blank=True, null=True)

    class Meta:
        verbose_name_plural = _("Angebote")
        verbose_name = _("Angebot")
