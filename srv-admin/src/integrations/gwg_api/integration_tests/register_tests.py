import json

import pytest
from django.contrib.auth import get_user_model
from django.core import mail
from django.urls import reverse
from rest_framework import status

from src.components.authentication_local import NS

UserModel = get_user_model()

NS = "gwg_api:authentication_local"


@pytest.mark.django_db
def test_register_endpoint_exists(client):
    response = client.get(
        reverse(f"{NS}:register"),
    )
    assert response.status_code == status.HTTP_405_METHOD_NOT_ALLOWED


@pytest.mark.django_db
def test_register_user_without_tenant_fails(mocker, client):
    handle_register_user = mocker.patch(
        "src.components.authentication_local.api.register.handle_register_user",
    )

    response = client.post(
        reverse(f"{NS}:register"),
        {"email": "a@b.cd", "password": "123"},
    )

    handle_register_user.assert_not_called()
    assert response.status_code == status.HTTP_400_BAD_REQUEST
    assert len(mail.outbox) == 0
    assert (
        json.dumps(response.data)
        == '{"contract": ["This field is required."], "birthdate": ["This field is required."]}'
    )


@pytest.mark.django_db
def test_register_valid_user(mocker, django_user_model, client):
    email = "a@b.cd"

    handle_register_user = mocker.patch(
        "src.components.authentication_local.api.register.handle_register_user",
        return_value={
            "user": django_user_model(email=email),
            "error": None,
            "success": True,
        },
    )

    response = client.post(
        reverse(f"{NS}:register"),
        {
            "email": email,
            "password": "123",
            "contract": "123",
            "birthdate": "1958-04-19",
        },
    )

    handle_register_user.assert_called()

    assert response.status_code == status.HTTP_201_CREATED
    assert len(mail.outbox) == 1
    # FIXME: test if email contains token
    assert response.data == {
        "message": "successfully registered user. Verify your email to login."
    }


@pytest.mark.django_db
def test_register_user_without_tenant_fails(mocker, client):
    m_get_user_data = mocker.patch(
        "src.components.authentication_local.api.register.handle_register_user",
        return_value={"error": "could not identify user", "success": False},
    )
    response = client.post(
        reverse(f"{NS}:register"),
        {
            "email": "a@b.cd",
            "password": "123",
            "contract": "123",
            "birthdate": "1958-04-19",
        },
    )

    m_get_user_data.assert_called()
    assert response.status_code == status.HTTP_400_BAD_REQUEST
    assert len(mail.outbox) == 0
    assert json.dumps(response.data) == '{"message": "could not identify user"}'


@pytest.mark.django_db
def test_register_user_with_existing_mail_fails(mocker, django_user_model, client):
    m_get_user_data = mocker.patch(
        "src.components.authentication_local.api.register.handle_register_user",
    )
    email = "user@service.domain"
    password = "123"
    user = UserModel.objects.create_user(email=email, password=password)
    user.save()

    response = client.post(
        reverse(f"{NS}:register"),
        {
            "email": email,
            "password": password,
            "contract": "123",
            "birthdate": "1958-04-19",
        },
    )

    m_get_user_data.assert_not_called()
    assert response.status_code == status.HTTP_400_BAD_REQUEST
    assert len(mail.outbox) == 0
    assert (
        json.dumps(response.data)
        == '{"email": ["User with this email address already exists."]}'
    )
