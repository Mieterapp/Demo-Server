from src.shared.settings_factory import SettingsFactory

SETTINGS_NAMESPACE = "DIT_REAL_ESTATE"

DEFAULTS = {
}

IMPORT_STRINGS = []

REMOVED_SETTINGS = []

dit_real_estate_settings = SettingsFactory(
    SETTINGS_NAMESPACE, DEFAULTS, IMPORT_STRINGS, REMOVED_SETTINGS, None
)
