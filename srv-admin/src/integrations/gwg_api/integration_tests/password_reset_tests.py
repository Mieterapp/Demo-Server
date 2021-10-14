from datetime import date, timedelta

import pytest
from django.test.client import Client
from rest_framework.status import (
    HTTP_200_OK,
    HTTP_201_CREATED,
    HTTP_400_BAD_REQUEST,
    HTTP_405_METHOD_NOT_ALLOWED,
    HTTP_410_GONE,
)

from src.components.authentication_local.constants import TOKEN_EXPIRATION_DELTA_DAYS
from src.components.authentication_local.password_reset.models import PasswordResetToken


@pytest.mark.django_db
def test_password_reset_get_fails(client: Client):
    response = client.get("/api/v1/password/reset/")

    assert response.status_code == HTTP_405_METHOD_NOT_ALLOWED


@pytest.mark.django_db
def test_password_reset_post_for_verified_user_succeeds(
    client: Client, django_user_model, mailoutbox
):
    django_user_model.objects.create_user(
        email="a@b.cd", password="123", is_verified=True
    )

    response = client.post("/api/v1/password/reset/", {"email": "a@b.cd"})

    assert response.status_code == HTTP_201_CREATED
    assert len(mailoutbox) == 1

    m = mailoutbox[0]
    assert m.subject == "Reset Your Password"
    assert m.body.find("Reset your password by clicking on this link") == 0
    assert list(m.to) == ["a@b.cd"]


@pytest.mark.django_db
def test_password_reset_post_for_unverified_user_fails(
    client: Client, django_user_model, mailoutbox
):
    django_user_model.objects.create_user(
        email="a@b.cd", password="123", is_verified=False
    )

    response = client.post("/api/v1/password/reset/", {"email": "a@b.cd"})

    assert response.status_code == HTTP_400_BAD_REQUEST
    assert len(mailoutbox) == 0


@pytest.mark.django_db
def test_password_change_post_for_valid_token_succeeds(
    client: Client, django_user_model, mailoutbox
):
    user = django_user_model.objects.create_user(
        email="a@b.cd", password="123", is_verified=False
    )
    pw_reset = PasswordResetToken.objects.create_password_reset_token(user)

    response = client.post(
        "/api/v1/password/change/", {"password": "123", "token": pw_reset.token}
    )

    assert response.status_code == HTTP_200_OK


@pytest.mark.django_db
def test_password_change_post_for_stale_token_fails(
    client: Client, django_user_model, mailoutbox
):
    user = django_user_model.objects.create_user(
        email="a@b.cd", password="123", is_verified=False
    )
    created_at = date.today() - timedelta(days=TOKEN_EXPIRATION_DELTA_DAYS + 1)
    pw_reset = PasswordResetToken.objects.create_password_reset_token(
        user, created_at=created_at
    )

    response = client.post(
        "/api/v1/password/change/", {"password": "123", "token": pw_reset.token}
    )

    assert response.status_code == HTTP_410_GONE
