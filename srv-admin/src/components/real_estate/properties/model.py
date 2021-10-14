from django.db import models
from django.utils.translation import gettext as _


class Property(models.Model):
    class Meta:
        verbose_name = _("Objekt")
        verbose_name_plural = _("Objekte")

    def __str__(self):
        return f"{self.id} {self.company_code} {self.entity} {self.object}"

    id = models.CharField(primary_key=True, max_length=20)
    company_code = models.IntegerField(default=0, verbose_name=_("Buchungskreis"))

    # TODO: refactor to economic_unit?
    entity = models.IntegerField(default=0, verbose_name=_("Wirtschaftseinheit"))

    # TODO: refactor to building?
    object = models.IntegerField(default=0, verbose_name=_("Gebäude"))
    street = models.CharField(
        max_length=128, verbose_name=_("Straße"), blank=True, null=True
    )
    number = models.CharField(
        max_length=128, verbose_name=_("Hausnummer"), blank=True, null=True
    )
    zip = models.CharField(max_length=128, verbose_name=_("PLZ"), blank=True, null=True)
    city = models.CharField(
        max_length=128, verbose_name=_("Ort"), default="Mannheim", blank=True, null=True
    )
    # TODO: refactor into customer_center
    center = models.CharField(
        max_length=128, verbose_name=_("KSC"), blank=True, null=True
    )
