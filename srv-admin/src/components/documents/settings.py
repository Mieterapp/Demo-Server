from src.shared.settings_factory import SettingsFactory

SETTINGS_NAMESPACE = "DIT_DOCUMENTS"

DEFAULTS = {}

IMPORT_STRINGS = []

REMOVED_SETTINGS = []

dit_content_settings = SettingsFactory(
    SETTINGS_NAMESPACE, DEFAULTS, IMPORT_STRINGS, REMOVED_SETTINGS, None
)
