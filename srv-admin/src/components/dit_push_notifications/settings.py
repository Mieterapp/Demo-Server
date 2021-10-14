from src.shared.settings_factory import SettingsFactory

SETTINGS_NAMESPACE = "DIT_PUSH_NOTIFICATIONS"

DEFAULTS = {
    "PUSH_NOTIFICATION_SECRET": None,
}

IMPORT_STRINGS = []

REMOVED_SETTINGS = []

dit_push_notifications_settings = SettingsFactory(
    SETTINGS_NAMESPACE, DEFAULTS, IMPORT_STRINGS, REMOVED_SETTINGS, None
)
