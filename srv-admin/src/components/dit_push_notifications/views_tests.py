import pytest
from django.test.client import Client
from push_notifications.models import APNSDevice, GCMDevice
from rest_framework.status import (
    HTTP_200_OK,
    HTTP_403_FORBIDDEN,
    HTTP_404_NOT_FOUND,
)


def test_send_push_notifications_anonymous_fails(client: Client):

    get_response = client.get("/api/v1/push-notifications/send-message/")
    post_response = client.post("/api/v1/push-notifications/send-message/", {})

    assert get_response.status_code == HTTP_403_FORBIDDEN
    assert post_response.status_code == HTTP_403_FORBIDDEN


@pytest.mark.django_db
def test_send_push_notifications_with_valid_hash_and_user_succeeds(
    mocker, client: Client, django_user_model
):

    username = "a@b.cd"
    password = "123"
    principal_id = "1346-0-001-002"
    user = django_user_model.objects.create_user(
        email=username, password=password, principal_id=principal_id
    )

    APNSDevice.objects.create(user=user)

    post_response = client.post(
        "/api/v1/push-notifications/send-message/",
        {
            "principal_id": principal_id,
            "type": "Document",
            "object_id": "1",
            "message": "Das Tierhaltung Dokument steht zum Abruf bereit",
            "title": "Anliegen Tierhaltung",
            "hash": "04dbb6713f5381a9adec7bc51529df79e05dcd70cd477a716fa46dae2932b552",
            "timestamp": 1610028775,
        },
    )

    assert post_response.status_code == HTTP_200_OK


@pytest.mark.django_db
def test_send_push_notifications_without_valid_principal_id_fails(
    mocker, client: Client, django_user_model
):

    username = "a@b.cd"
    password = "123"
    principal_id = "002"
    django_user_model.objects.create_user(
        email=username, password=password, principal_id=principal_id
    )

    m_send_message = mocker.patch.object(APNSDevice, "send_message")

    post_response = client.post(
        "/api/v1/push-notifications/send-message/",
        {
            "principal_id": "1346-0-001-002",
            "type": "Document",
            "object_id": "1",
            "message": "Das Tierhaltung Dokument steht zum Abruf bereit",
            "title": "Anliegen Tierhaltung",
            "hash": "04dbb6713f5381a9adec7bc51529df79e05dcd70cd477a716fa46dae2932b552",
            "timestamp": 1610028775,
        },
    )

    assert post_response.status_code == HTTP_404_NOT_FOUND
    m_send_message.assert_called()