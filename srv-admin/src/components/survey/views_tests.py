import pytest
from django.test.client import Client
from rest_framework.status import HTTP_200_OK, HTTP_404_NOT_FOUND
from rest_framework.test import APIClient
from rest_framework_jwt.utils import jwt_encode_handler, jwt_payload_handler

from src.components.real_estate.contract.model import Contract

from .models import Survey


@pytest.mark.django_db
def test_survey_anonymous_succeeds(client: Client):
    Survey.objects.create(
        title="Survey 1",
        dialog="Nachricht",
    )

    public_faqs = client.get("/api/v1/survey/")

    assert public_faqs.status_code == HTTP_200_OK
    assert len(public_faqs.data) == 0

    public_faqs = client.get("/api/v1/survey/1/")

    assert public_faqs.status_code == HTTP_404_NOT_FOUND


@pytest.mark.django_db
def test_survey_authenticated_user_succeeds(django_user_model, client: Client):
    Survey.objects.create(
        title="Survey 1",
        dialog="Nachricht",
        visible_object="2050.10847; 2050.10848",
        is_active=True,
    )

    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(email=username, password=password)
    contract = Contract.objects.create(number="2050.10847.0135.02")
    contract.partners.add(user)

    client = APIClient()
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)
    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")

    surveys = client.get("/api/v1/survey/")

    assert surveys.status_code == HTTP_200_OK
    assert len(surveys.data) == 1

    surveys = client.get("/api/v1/survey/1/")

    assert surveys.status_code == HTTP_404_NOT_FOUND