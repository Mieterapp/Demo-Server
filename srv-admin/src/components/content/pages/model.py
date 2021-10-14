from django.db import models
from django.utils.translation import gettext as _


class Page(models.Model):
    slug = models.CharField(max_length=150, verbose_name=_("slug"))
    html = models.TextField(
        blank=False,
        null=False,
        verbose_name=_("HTML content"),
        default="<html><body><h1>Please Change Me</h1></body></html>",
    )