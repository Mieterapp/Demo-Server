from django.utils import timezone
from django.contrib.auth.base_user import AbstractBaseUser, BaseUserManager
from django.contrib.auth.models import PermissionsMixin
from django.core.mail import send_mail
from django.db import models
from django.utils.translation import gettext_lazy as _


class AuthenticationLocalManager(BaseUserManager):
    def _create_user(self, email, password, **extra_fields):
        """
        Create and save a user with the given email, and password.
        """
        now = timezone.now()

        if not email:
            raise ValueError("Users must have an email address")

        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", False)
        extra_fields.setdefault("is_superuser", False)
        extra_fields.setdefault("is_verified", False)
        return self._create_user(email, password, **extra_fields)

    def create_superuser(self, email=None, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)

        if extra_fields.get("is_staff") is not True:
            raise ValueError("Superuser must have is_staff=True.")
        if extra_fields.get("is_superuser") is not True:
            raise ValueError("Superuser must have is_superuser=True.")

        return self._create_user(email, password, **extra_fields)


class AuthenticationLocalAbstractUser(AbstractBaseUser, PermissionsMixin):
    """
    Abstract base class implementing a fully featured User model with
    admin-compliant permissions.

    Email and password are required. Other fields are optional.
    """

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []

    class Meta:
        verbose_name = _("User")
        verbose_name_plural = _("Users")
        abstract = True

    email = models.EmailField(_("email address"), max_length=255, unique=True)
    email_contract = models.EmailField(_("email address change contract"), max_length=255, blank=True, null=True)
    is_staff = models.BooleanField(
        _("staff status"),
        default=False,
        help_text=_("Designates if this user can log into the django admin site"),
    )
    is_active = models.BooleanField(
        _("active"),
        default=True,
        help_text=_("Designates if this user should be able to login."),
    )
    date_joined = models.DateTimeField(_("date joined"), default=timezone.now)

    is_verified = models.BooleanField(
        _("verified"),
        default=False,
        help_text=_("Designates whether this user has verified his email address"),
    )

    principal_id = models.CharField(
        max_length=100,
        verbose_name=_("Persönliche Haupt-Identifikationsnummer"),
        blank=True,
        null=True,
    )
    first_name = models.CharField(
        max_length=100, verbose_name=_("Vorname"), blank=True, null=True
    )
    last_name = models.CharField(
        max_length=100, verbose_name=_("Nachname"), blank=True, null=True
    )
    birthdate = models.DateField(verbose_name=_("Geburtstag"), blank=True, null=True)
    phone = models.CharField(
        max_length=100, verbose_name=_("Telefonnummer"), blank=True, null=True
    )
    mobile = models.CharField(
        max_length=100, verbose_name=_("Mobil Telefonnummer"), blank=True, null=True
    )
    street = models.CharField(
        max_length=100, verbose_name=_("Straße"), blank=True, null=True
    )
    street_number = models.CharField(
        max_length=10, verbose_name=_("Hausnummer"), blank=True, null=True
    )
    zip_code = models.CharField(
        max_length=5, verbose_name=_("Postleitzahl"), blank=True, null=True
    )
    city = models.CharField(
        max_length=50, verbose_name=_("Wohnort"), blank=True, null=True
    )
    is_data_accepted = models.BooleanField(
        _("data accepted"),
        default=False,
        help_text=_("Designates whether this user has accepted the data privacy"),
    )
    code = models.CharField(
        max_length=200, verbose_name=_("Code"), blank=True, null=True
    )

    def email_user(self, subject, message, from_email=None, **kwargs):
        """
        Sends an email to this User.
        """
        send_mail(subject, message, from_email, [self.email], **kwargs)

    def __str__(self):
        return self.email
