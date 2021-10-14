from django.contrib import admin
from import_export.admin import ExportMixin, ImportMixin
from django.contrib.admin.decorators import register

from .model import Contract


@register(Contract)
class ContractAdmin(admin.ModelAdmin):
    list_display = (
        "code",
        "number",
        "company_code",
        "economic_unit",
        "building",
        "rental_unit",
        "type",
        "type_name",
        "description",
        "city",
        "city_district",
        "date_from",
        "date_to",
        "is_active",
        "rental_contract",
        "rental_unit",
        "street",
        "street_number",
        "zip_code",
    )


