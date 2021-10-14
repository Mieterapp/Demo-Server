from datetime import datetime

from django.conf import settings
from django.db import models
from django.core.mail import EmailMessage
from django.utils.translation import gettext_lazy as _

from ..utils import _generate_token, send_multi_format_email
import logging

logger = logging.getLogger(__name__)


class VerificationTokenManager(models.Manager):
    def create_registration_token(self, user):
        token = _generate_token()
        verification_code = self.create(user=user, token=token)

        return verification_code

    def set_user_is_verified(self, token):
        try:
            token = VerificationToken.objects.get(token=token)
            token.user.is_verified = True
            token.user.save()
            return True
        except VerificationToken.DoesNotExist:
            pass

        return False


class AbstractBaseVerificationToken(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    token = models.CharField(_("code"), max_length=60, primary_key=True)
    created_at = models.DateTimeField(default=datetime.now)

    class Meta:
        abstract = True

    def send_email(self, prefix):
        if self.target_email:
            target_email = self.target_email
        else:
            target_email = self.user.email
        content_text = {
            "email": target_email,
            "token": self.token,
        }
        logger.debug(f" send_email REGISTRATION 1  {content_text}")
        logger.debug(f" prefix {prefix}")
        logger.debug(f" content_text {content_text}")
        logger.debug(f" target_email {target_email}")
        send_multi_format_email(prefix, content_text, target_email=target_email)

    def send_inv_email(self):
        target_email = self.target_email
        # todo get SERVER - URL
        msg = EmailMessage('Einladung zur Mieterapp',
                           f'Hey, du wurdest zur GWG app eingeladen\n'
                           f'/register/token/{self.token}',
                           from_email=settings.EMAIL_FROM_ADDRESS,
                           to=[target_email])
        msg.send()


def __str__(self):
    return self.token


class VerificationToken(AbstractBaseVerificationToken):
    objects = VerificationTokenManager()

    def send_registration_email(self):
        prefix = "registration_email"
        self.send_email(prefix)


