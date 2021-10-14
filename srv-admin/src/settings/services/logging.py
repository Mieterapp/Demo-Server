import environ

env = environ.Env()

ADMINS = [
    ("Litzenberger Engineering", "crash-reports@litzenberger.engineering"),
]

LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "console": {
            "format": "[{asctime}] {levelname} {module} {message}",
            "style": "{",
        },
    },
    "handlers": {
        "console": {"class": "logging.StreamHandler", "formatter": "console"},
        "mail_admins": {
            "level": "ERROR",
            "class": "django.utils.log.AdminEmailHandler",
        },
    },
    "root": {
        "handlers": ["console"],
        "level": env.str("LOG_LEVEL_ROOT", "INFO"),
    },
    "loggers": {
        "django": {
            "handlers": ["console"],
            "level": env.str("DJANGO_LOG_LEVEL", "INFO"),
            "propagate": False,
        },
        "src.components.docu_web.utils": {
            "handlers": ["console"],
            "level": env.str("LOG_LEVEL_DOCU_WEB_UTILS", "INFO"),
            "propagate": False,
        },
    },
}