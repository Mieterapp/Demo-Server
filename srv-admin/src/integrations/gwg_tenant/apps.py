from django.apps import AppConfig
from django.utils.translation import gettext_lazy as _


class GwgTenantConfig(AppConfig):
    name = "src.integrations.gwg_tenant"
    verbose_name = _("Demo Tenant Module")
