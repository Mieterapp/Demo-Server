from django.contrib.auth import get_user_model
from django.db import models
from django.utils.translation import gettext as _

UserModel = get_user_model()


class Contract(models.Model):
    class Meta:
        verbose_name = _("Vertrag")
        verbose_name_plural = _("Verträge")

    partners = models.ManyToManyField(UserModel, related_name="contracts")

    code = models.CharField(max_length=20, blank=True, null=True)
    number = models.CharField(max_length=200, blank=True, null=True)
    company_code = models.CharField(max_length=200, blank=True, null=True)
    economic_unit = models.CharField(max_length=200, blank=True, null=True)
    building = models.CharField(max_length=200, blank=True, null=True)
    rental_unit = models.CharField(max_length=200, blank=True, null=True)
    type = models.CharField(max_length=200, blank=True, null=True)
    type_name = models.CharField(max_length=200, blank=True, null=True)
    description = models.CharField(max_length=200, blank=True, null=True)
    city = models.CharField(max_length=200, blank=True, null=True)
    city_district = models.CharField(max_length=200, blank=True, null=True)
    date_from = models.DateField(blank=True, null=True)
    date_to = models.DateField(blank=True, null=True)
    is_active = models.BooleanField(blank=True, null=True)
    rental_contract = models.CharField(max_length=200, blank=True, null=True)
    rental_unit = models.CharField(max_length=200, blank=True, null=True)
    street = models.CharField(max_length=200, blank=True, null=True)
    street_number = models.CharField(max_length=200, blank=True, null=True)
    zip_code = models.CharField(max_length=200, blank=True, null=True)
