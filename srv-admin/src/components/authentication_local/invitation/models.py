from datetime import date

from django.db import models
from django.utils.translation import gettext as _

from ..constants import TOKEN_EXPIRATION_DELTA_DAYS
from ..utils import _generate_token
from ..verification_token.models import AbstractBaseVerificationToken


class InvitationTokenManager(models.Manager):
    def create_invitation_token(self, user, target_email, principal_id, contract_id):
        token = _generate_token()
        return self.create(
            user=user, token=token, target_email=target_email, principal_id=principal_id, contract_id=contract_id)

    def get_expiration_delta(self):
        return TOKEN_EXPIRATION_DELTA_DAYS


class InvitationToken(AbstractBaseVerificationToken):
    objects = InvitationTokenManager()
    contract_id = models.CharField(max_length=256, blank=False, null=False)
    principal_id = models.CharField(max_length=256, blank=False, null=False)
    target_email = models.EmailField(blank=True, null=True, default=None)

    def send_invitation_email(self):
        # prefix = "invitation_email"
        self.send_inv_email()

