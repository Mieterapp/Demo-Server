import pytest

from django.contrib.auth import get_user_model
from django.test.testcases import TestCase
from django.urls import reverse
from rest_framework import status

from src.components.authentication_local import NS
from src.components.authentication_local.models import VerificationToken
from src.components.authentication_local.utils import _generate_token
from src.integrations.gwg_tenant.models import Tenant

UserModel = get_user_model()

NS = "gwg_api:authentication_local"


@pytest.mark.django_db
def test_verify_valid_token(client):
    user = "user@service.domain"
    password = "password"
    user = UserModel.objects.create_user(
        user,
        password,
        is_verified=False,
    )
    token = VerificationToken.objects.create(user=user, token=_generate_token())

    response = client.post(
        reverse(f"{NS}:verify-email"),
        {"token": token.token},
    )

    assert response.status_code == status.HTTP_200_OK
    assert response.data["message"] == "User verified"
