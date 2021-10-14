import pytest
from django.test.client import Client
from rest_framework.status import HTTP_200_OK, HTTP_403_FORBIDDEN
from rest_framework.test import APIClient
from rest_framework_jwt.utils import jwt_encode_handler, jwt_payload_handler

from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_ext_masterdata import (
    GET_PARTNER_EXT_MASTERDATA_NORMALIZED,
)
from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_masterdata import (
    GET_PARTNER_MASTERDATA_NORMALIZED,
)
from src.components.real_estate.contract.model import Contract


@pytest.mark.django_db
def test_get_customer_center_anonymous_fails(django_user_model, client: Client):

    public_news = client.get("/api/v1/customer-center/")

    assert public_news.status_code == HTTP_403_FORBIDDEN


@pytest.mark.django_db
def test_get_customer_center_authenticated_succeeds(
    mocker, django_user_model, client: Client
):
    m_get_partner_ext_masterdata = mocker.patch(
        "src.components.docu_web.helper.customer_center.get_partner_ext_masterdata",
        return_value=GET_PARTNER_EXT_MASTERDATA_NORMALIZED(),
    )
    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(email=username, password=password)

    contract = Contract.objects.create(
        id=1, **GET_PARTNER_MASTERDATA_NORMALIZED()["data"]["contract"]
    )
    contract.partners.add(user)
    # Foreign contract
    Contract.objects.create(
        id=2, **GET_PARTNER_MASTERDATA_NORMALIZED()["data"]["contract"]
    )

    client = APIClient()
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)
    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")

    response = client.get("/api/v1/customer-center/")

    m_get_partner_ext_masterdata.assert_called_once()
    assert response.status_code == HTTP_200_OK
    assert len(response.data) == 1
