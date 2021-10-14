from django.contrib.auth import get_user_model
from django.test.testcases import TestCase
from django.urls import reverse
from rest_framework import status

from src.integrations.gwg_tenant.models import User

UserModel = get_user_model()

NS = "gwg_api:authentication_local"


class LoginTestCase(TestCase):
    _password = "123"

    def test_login_email_is_verified(self):
        verified_user = User.objects.create(email="1@b.cd", is_verified=True)
        verified_user.set_password(self._password)
        verified_user.save()

        response = self.client.post(
            reverse(f"{NS}:authenticate"),
            {"email": "1@b.cd", "password": self._password},
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIsNotNone(response.data.get("token"))

    def test_login_fails_if_email_not_verified(self):
        unverified_user = User.objects.create(email="2@b.cd")
        unverified_user.set_password(self._password)
        unverified_user.save()
        response = self.client.post(
            reverse(f"{NS}:authenticate"),
            {"email": "2@b.cd", "password": self._password},
        )

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
        self.assertEqual(response.data["message"], "User account not verified.")
