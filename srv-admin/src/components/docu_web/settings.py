from src.shared.settings_factory import SettingsFactory

SETTINGS_NAMESPACE = "DOKU_WEB"

DEFAULTS = {
    "PROTOCOL": "https",
    # "HOST_NAME": "dokuweb.datasec.de",
    "HOST_NAME": "dokuweintegration.datasec.de",
    "AUTH_TOKEN": None
}

IMPORT_STRINGS = []

REMOVED_SETTINGS = []

dw_settings = SettingsFactory(
    SETTINGS_NAMESPACE, DEFAULTS, IMPORT_STRINGS, REMOVED_SETTINGS, None
)
