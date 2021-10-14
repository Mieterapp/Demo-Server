import pytest
from django.contrib.auth import get_user_model
from rest_framework_jwt.utils import jwt_encode_handler, jwt_payload_handler
from rest_framework.test import APIClient
from rest_framework.status import HTTP_200_OK

from ..issue.models import Issue


@pytest.mark.django_db
def test_get_issues_by_location_authorized_returns_ok(mocker):
    forms = [
        {"id": 1, "location": 1},  # issues
        {"id": 2, "location": 2},  # documents
    ]

    client = APIClient()
    user = get_user_model().objects.create(email="a@b.cd")
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)
    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")

    for form in forms:
        Issue.objects.create(display_location=form["location"])

    response_issues = client.get(
        f"/api/v1/issues/?display-location={forms[0]['location']}"
    )
    assert response_issues.status_code == HTTP_200_OK
    assert response_issues.data[None][0]["display_location"] == 1
    assert len(response_issues.data[None]) == 1

    response_documents = client.get(
        f"/api/v1/issues/?display-location={forms[1]['location']}"
    )
    assert response_documents.status_code == HTTP_200_OK
    assert response_documents.data[None][0]["display_location"] == 2
    assert len(response_documents.data[None]) == 1
