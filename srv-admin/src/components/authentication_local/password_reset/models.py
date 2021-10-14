from datetime import date

from django.db import models

from ..constants import TOKEN_EXPIRATION_DELTA_DAYS
from ..utils import _generate_token
from ..verification_token.models import AbstractBaseVerificationToken


class PasswordResetTokenManager(models.Manager):
    def create_password_reset_token(self, user, created_at=date.today()):
        print("before create token")
        token = _generate_token()
        print("after create token")
        return self.create(user=user, token=token, created_at=created_at)

    def get_expiration_delta(self):
        return TOKEN_EXPIRATION_DELTA_DAYS


class PasswordResetToken(AbstractBaseVerificationToken):
    objects = PasswordResetTokenManager()

    def send_password_reset_email(self):
        prefix = "password_reset_email"
        self.send_email(prefix)
