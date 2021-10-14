import environ

env = environ.Env()

DATABASES = {
    "default": {
        "ENGINE": env.str("DATABASE_ENGINE", "django.db.backends.postgresql_psycopg2"),
        "NAME": env.str("DATABASE_NAME", "postgres"),
        "USER": env.str("DATABASE_USER", "postgres"),
        "PASSWORD": env.str("DATABASE_PASSWORD", "postgres"),
        "HOST": env.str("DATABASE_HOST", "srv-db"),
        "PORT": env.int("DATABASE_PORT", 5432),
    }
}