from django.contrib import admin
from src.integrations.gwg_tenant.models import Tenant, User


# @admin.register(Tenant)
class TenantAdmin(admin.ModelAdmin):
    list_display = (
        "partnerid",
        "name_first",
        "name_last",
    )
    # pass


@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = (
        "email",
        "first_name",
        "last_name",
        "principal_id",
    )
    search_fields = ('first_name', 'last_name')
    exclude = ('password',)
