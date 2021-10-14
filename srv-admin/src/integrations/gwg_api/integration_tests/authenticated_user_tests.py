from src.components.real_estate.contract.model import Contract
from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_masterdata import (
    GET_PARTNER_MASTERDATA_NORMALIZED,
)
import pytest
from django.test.client import Client
from rest_framework.test import APIClient
from rest_framework.status import HTTP_200_OK, HTTP_403_FORBIDDEN
from rest_framework_jwt.utils import jwt_encode_handler, jwt_payload_handler

from src.integrations.gwg_tenant.user.models import Tenant


@pytest.mark.django_db
def test_get_authenticated_user_without_credentials_fails(client: Client):
    response = client.get("/api/v1/authenticated-user")

    assert response.status_code == HTTP_403_FORBIDDEN


@pytest.mark.django_db
def test_get_authenticated_user_with_credentials_succeeds(
    django_user_model, client: Client
):
    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(email=username, password=password)

    contract = Contract.objects.create(
        id=1, **GET_PARTNER_MASTERDATA_NORMALIZED()["data"]["contract"]
    )
    contract.partners.add(user)

    client = APIClient()
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)
    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")

    response = client.get("/api/v1/authenticated-user")
    response.data.pop("id")

    assert response.status_code == HTTP_200_OK
    assert response.data == {
        "email": "a@b.cd",
        "contracts": [1],
        "principal_id": None,
        "first_name": None,
        "last_name": None,
        "birthdate": None,
        "phone": None,
        "mobile": None,
        "street": None,
        "street_number": None,
        "zip_code": None,
        "city": None,
    }


@pytest.mark.django_db
def test_patch_authenticated_user_with_credentials_succeeds(
    django_user_model, client: Client
):
    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(email=username, password=password)

    client = APIClient()
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)
    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")

    response = client.patch(
        "/api/v1/authenticated-user",
        {"phone": "01721234567"},
        "json",
    )

    assert response.status_code == HTTP_200_OK
    assert response.data["phone"] == "01721234567"
