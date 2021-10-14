from src.shared.settings_factory import SettingsFactory

SETTINGS_NAMESPACE = "DIT_CONTENT"

DEFAULTS = {
    "CUSTOMER_WEBSITE_DOMAIN": "www.example.com",
    "NEWS_TITLE_MAX_LENGTH": 45,
    "NEWS_BODY_MAX_LENGTH": 250,
}

IMPORT_STRINGS = []

REMOVED_SETTINGS = []

dit_content_settings = SettingsFactory(
    SETTINGS_NAMESPACE, DEFAULTS, IMPORT_STRINGS, REMOVED_SETTINGS, None
)
