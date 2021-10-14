from django.contrib import admin
from django.utils.html import format_html
from django.utils.translation import gettext as _
from modeltranslation.admin import TranslationAdmin

from .models import Area, Defect, DefectResolutionRating, DefectType, ReportedDefect


@admin.register(Area)
class AreaAdmin(TranslationAdmin):
    list_display = [
        "name",
        "visible_groups_names",
        "sorting",
    ]

    list_editable = [
        "sorting",
    ]

    list_filter = [
        "visible_groups",
    ]

    search_fields = [
        "name",
    ]

    filter_horizontal = [
        "visible_groups",
    ]

    group_fieldsets = True

    def visible_groups_names(self, obj) -> str:
        if not obj.visible_groups.all():
            return _("All")
        return ", ".join(obj.visible_groups.values_list("name", flat=True))

    visible_groups_names.short_description = _("Visible groups")


@admin.register(Defect)
class DefectAdmin(TranslationAdmin):
    list_display = [
        "name",
        "defect_type",
        "area",
        "show_emergency_alert",
        "is_image_required",
        "visible_groups_names",
    ]

    search_fields = [
        "name",
    ]

    list_filter = [
        "defect_type",
        "area",
        "show_emergency_alert",
        "is_image_required",
        "visible_groups",
    ]

    filter_horizontal = [
        "visible_groups",
    ]

    group_fieldsets = True

    def visible_groups_names(self, obj) -> str:
        if not obj.visible_groups.all():
            return _("All")
        return ", ".join(obj.visible_groups.values_list("name", flat=True))

    visible_groups_names.short_description = _("Visible groups")


@admin.register(DefectResolutionRating)
class DefectResolutionRatingAdmin(admin.ModelAdmin):
    pass


@admin.register(DefectType)
class DefectTypeAdmin(TranslationAdmin):
    list_display = [
        "name",
        "area_names",
        "visible_groups_names",
        "sorting",
    ]

    list_editable = [
        "sorting",
    ]

    list_filter = [
        "areas",
        "visible_groups",
    ]

    filter_horizontal = [
        "areas",
        "visible_groups",
    ]

    group_fieldsets = True

    def visible_groups_names(self, obj) -> str:
        if not obj.visible_groups.all():
            return _("All")
        return ", ".join(obj.visible_groups.values_list("name", flat=True))

    visible_groups_names.short_description = _("Visible groups")

    def area_names(self, obj) -> str:
        if not obj.areas.all():
            return _("All")
        return ", ".join(obj.areas.values_list("name", flat=True))

    area_names.short_description = _("Areas")


@admin.register(ReportedDefect)
class ReportedDefectAdmin(admin.ModelAdmin):
    list_display = [
        "reported_by",
        "status",
        "created_at",
        "updated_at",
        "defect",
        "image_1_preview",
        "image_2_preview",
    ]

    list_filter = [
        "status",
        "defect",
    ]

    def image_1_preview(self, obj):
        if not obj.image_1:
            return None
        try:
            return format_html(
                f'<a href="{obj.image_1.url}" target="_blank"><img src="{obj.image_1_thumbnail.url}" height="50" width="50"></a>'
            )
        except AttributeError:
            return None

    image_1_preview.short_description = _("Image 1")

    def image_2_preview(self, obj):
        if not obj.image_2:
            return None
        try:
            return format_html(
                f'<a href="{obj.image_2.url}" target="_blank"><img src="{obj.image_2_thumbnail.url}" height="50" width="50"></a>'
            )
        except AttributeError:
            return None

    image_2_preview.short_description = _("Image 2")
