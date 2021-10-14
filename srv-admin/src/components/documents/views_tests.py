from src.components.real_estate.contract.model import Contract
import pytest

from django.test.client import Client
from rest_framework.status import HTTP_200_OK, HTTP_403_FORBIDDEN
from rest_framework.test import APIClient
from rest_framework_jwt.utils import jwt_encode_handler, jwt_payload_handler

from src.integrations.gwg_tenant.user.models import Tenant


def test_get_documents_anonymous_returns_forbidden(django_user_model, client: Client):
    documents = client.get("/api/v1/documents/")

    assert documents.status_code == HTTP_403_FORBIDDEN


parsed_xml_response = {
    "documents": {
        "@start": "1",
        "@total": "3",
        "@max": "3",
        "document": [
            {
                "@collectid": "91E584B24C1D11E79950005056BF43",
                "page": {
                    "@no": "1",
                    "index": [
                        {"@name": "BETREFF", "#text": "Zustimmung MEH"},
                    ],
                },
            }
        ],
    }
}


def test_get_documents_authenticated_returns_ok(
    mocker, django_user_model, client: Client
):
    m_get_indexes = mocker.patch(
        "src.components.documents.views.get_indexes", return_value=parsed_xml_response
    )
    contract_data = {
        "code": "2000.10021.0020.05",
        "company_code": "2000",
        "rental_contract": "10021.0020.05",
    }

    contract = Contract.objects.create(**contract_data)

    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(email=username, password=password)
    contract.partners.add(user)

    client = APIClient()
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)
    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")

    documents = client.get("/api/v1/documents/")

    assert documents.status_code == HTTP_200_OK
    m_get_indexes.assert_called_with(
        "MIETVERTRAG",
        {
            "f2": "BUKRS",
            "f2_op": "=",
            "f2_val": "2000",
            "f2_con": "AND",
            "f3": "RECNNR",
            "f3_op": "=",
            "f3_val": "10021.0020.05",
        },
    )
