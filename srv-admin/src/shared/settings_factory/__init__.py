from django.conf import settings
from django.test.signals import setting_changed
from django.utils.module_loading import import_string


def perform_import(val, setting_name):
    """
    If the given setting is a string import notation,
    then perform the necessary import or imports.
    """
    if val is None:
        return None
    elif isinstance(val, str):
        return import_from_string(val, setting_name)
    elif isinstance(val, (list, tuple)):
        return [import_from_string(item, setting_name) for item in val]
    return val


def import_from_string(val, setting_name):
    """
    Attempt to import a class from a string representation.
    """
    try:
        return import_string(val)
    except ImportError as e:
        msg = "Could not import '%s' for auth_local setting '%s'. %s: %s." % (
            val, setting_name, e.__class__.__name__, e)
        raise ImportError(msg)


class SettingsFactory:
    """
    A settings object that allows auth_local module settings to be accessed as
    properties. For example:

        from auth_local.settings import al_settings
        print(al_settings.SOME_SETTING)

    Any setting with string import paths will be automatically resolved
    and return the class, rather than the string literal.

    Note:
    This is an internal class that is only compatible with settings namespaced
    under the AUTH_LOCAL name. It is not intended to be used by 3rd-party
    apps, and test helpers like `override_settings` may not work as expected.
    """

    def __init__(self, settings_namespace, defaults, import_strings, removed_settings=dict, user_settings=None):
        if user_settings:
            self._user_settings = self.__check_user_settings(user_settings)

        self.defaults = defaults
        self.import_strings = import_strings
        self.settings_namespace = settings_namespace
        self.removed_settings = removed_settings
        self._cached_attrs = set()

        def reload_settings(*args, **kwargs):
            setting = kwargs['setting']
            if setting == self.settings_namespace:
                self.reload()

        setting_changed.connect(reload_settings)

    @property
    def user_settings(self):
        if not hasattr(self, '_user_settings'):
            self._user_settings = getattr(
                settings, self.settings_namespace, {})
        return self._user_settings

    def __getattr__(self, attr):
        if attr not in self.defaults:
            raise AttributeError("Invalid API setting: '%s'" % attr)

        try:
            # Check if present in user settings
            val = self.user_settings[attr]
        except KeyError:
            # Fall back to defaults
            val = self.defaults[attr]

        # Coerce import strings into classes
        if attr in self.import_strings:
            val = perform_import(val, attr)

        # Cache the result
        self._cached_attrs.add(attr)
        setattr(self, attr, val)
        return val

    def __check_user_settings(self, user_settings):
        for setting in self.removed_settings:
            if setting in user_settings:
                raise RuntimeError(f"The {setting} setting has been removed.")
        return user_settings

    def reload(self):
        for attr in self._cached_attrs:
            delattr(self, attr)
        self._cached_attrs.clear()
        if hasattr(self, '_user_settings'):
            delattr(self, '_user_settings')
