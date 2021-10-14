from src.shared.settings_factory import SettingsFactory

SETTINGS_NAMESPACE = "DIT_DEFECT"

DEFAULTS = {
    "STATUS_CHOICES": "src.components.defect.enums.DefectStatus",
    "STATUS_DEFAULT": "CREATED",
    "IS_IMAGE_REQUIRED_DEFAULT": False,
    "SHOW_EMERGENCY_ALERT": False,
    "SERIALIZER_CLASSES": {
        "AREA": "src.components.defect.serializers.AreaSerializer",
        "DEFECT_TYPE": "src.components.defect.serializers.DefectTypeSerializer",
        "DEFECT": "src.components.defect.serializers.DefectSerializer",
        "REPORTED_DEFECT": "src.components.defect.serializers.ReportedDefectSerializer",
        "DEFECT_RESOLUTION_RATING": "src.components.defect.serializers.DefectResolutionRatingSerializer",
    },
    "FILTER_BACKENDS": {
        "REPORTED_DEFECT": "src.shared.filter_backends.IsReportedByOwner",
    },
}

IMPORT_STRINGS = [
    "STATUS_CHOICES",
]

REMOVED_SETTINGS = []

dit_defect_settings = SettingsFactory(SETTINGS_NAMESPACE, DEFAULTS, IMPORT_STRINGS, REMOVED_SETTINGS, None)
