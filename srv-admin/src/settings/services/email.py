import environ

env = environ.Env()

#EMAIL_BACKEND = env.str(
#    "EMAIL_BACKEND", "django.core.mail.backends.console.EmailBackend"
#)


EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_HOST_USER = 'testdiimt@gmail.com'
EMAIL_HOST_PASSWORD = 'testol123!?'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
EMAIL_FROM_ADDRESS = 'testdiimt@gmail.com'

#EMAIL_HOST = env.str("EMAIL_HOST")
#EMAIL_HOST_USER = env.str("EMAIL_HOST_USER")
#EMAIL_HOST_PASSWORD = env.str("EMAIL_HOST_PASSWORD")
#EMAIL_PORT = env.int("EMAIL_PORT", 587)
#EMAIL_USE_TLS = env.bool("EMAIL_USE_TLS", True)

#EMAIL_FROM_ADDRESS = env.str("EMAIL_FROM_ADDRESS", EMAIL_HOST_USER)
