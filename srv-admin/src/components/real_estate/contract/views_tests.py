from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_ext_masterdata import (
    GET_PARTNER_EXT_MASTERDATA_NORMALIZED,
)
from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_conditions import (
    GET_PARTNER_CONDITIONS_NORMALIZED,
)
from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_masterdata import (
    GET_PARTNER_MASTERDATA_NORMALIZED,
)
from src.components.real_estate.contract.model import Contract
from rest_framework.test import APIClient
from rest_framework_jwt.utils import jwt_encode_handler, jwt_payload_handler
from src.components.real_estate.properties.model import Property
import pytest
from django.test.client import Client
from rest_framework.status import (
    HTTP_200_OK,
    HTTP_403_FORBIDDEN,
    HTTP_404_NOT_FOUND,
)

from src.components.content.news.model import News


@pytest.mark.django_db
def test_contracts_get_anonymous_fails(django_user_model, client: Client):

    public_news = client.get("/api/v1/contracts/")

    assert public_news.status_code == HTTP_403_FORBIDDEN


@pytest.mark.django_db
def test_contracts_get_authenticated_succeeds(django_user_model, client: Client):

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
    response = client.get("/api/v1/contracts/")

    assert response.status_code == HTTP_200_OK
    assert len(response.data) == 1


@pytest.mark.django_db
def test_contracts_get_detail_authenticated_succeeds(
    django_user_model, client: Client, mocker
):
    m_get_partner_conditions = mocker.patch(
        "src.components.real_estate.contract.views.get_partner_conditions",
        return_value=GET_PARTNER_CONDITIONS_NORMALIZED(),
    )
    m_get_partner_ext_masterdata = mocker.patch(
        "src.components.real_estate.contract.views.get_partner_ext_masterdata",
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

    response = client.get("/api/v1/contracts/1/")

    m_get_partner_conditions.assert_called()
    m_get_partner_ext_masterdata.assert_called()
    assert response.status_code == HTTP_200_OK

    response = client.get("/api/v1/contracts/1000/")

    m_get_partner_conditions.assert_called_once()
    assert response.status_code == HTTP_404_NOT_FOUND
