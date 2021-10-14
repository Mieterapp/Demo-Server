from src.components.real_estate.contract.model import Contract
from src.components.docu_web.webservices.__mocks__.tickets_post_create_ticket import (
    POST_CREATE_CHAT_TICKET_NORMALIZED,
)
from src.components.docu_web.webservices.__mocks__.tickets_post_add_ticket_note import (
    POST_ADD_TICKET_NOTE_NORMALIZED,
)
import pytest
from django.test.client import Client
from rest_framework.status import (
    HTTP_200_OK,
    HTTP_201_CREATED,
    HTTP_400_BAD_REQUEST,
    HTTP_403_FORBIDDEN,
)
from rest_framework.test import APIClient
from rest_framework_jwt.utils import jwt_encode_handler, jwt_payload_handler

from src.components.docu_web.webservices.__mocks__.tickets_get_ticket_notes import (
    GET_TICKET_NOTES_NORMALIZED,
)

from .model import Session


@pytest.mark.django_db
def test_sessions_anonymous_fails(client: Client):

    public_faqs = client.get("/api/v1/customer-chat/")

    assert public_faqs.status_code == HTTP_403_FORBIDDEN


@pytest.mark.django_db
def test_get_sessions_authenticated_prestine_succeeds(
    django_user_model, client: Client
):
    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(email=username, password=password)

    client = APIClient()
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)
    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")

    session = client.get("/api/v1/customer-chat/")
    assert session.status_code == HTTP_200_OK
    assert len(session.data["messages"]) == 1


@pytest.mark.django_db
def test_get_sessions_authenticated_returns_existing_chat(
    mocker, django_user_model, client: Client
):
    m_get_chat_ticket_messages = mocker.patch(
        "src.components.chat.session.views.get_chat_ticket_messages",
        return_value=GET_TICKET_NOTES_NORMALIZED(),
    )

    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(email=username, password=password)

    user_session = Session.objects.create(code="123", user=user)

    client = APIClient()
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)
    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")

    session = client.get("/api/v1/customer-chat/")

    m_get_chat_ticket_messages.assert_called()
    assert session.status_code == HTTP_200_OK
    assert session.data["code"] == "123"
    assert len(session.data["messages"]) == 5


@pytest.mark.django_db
def test_post_message_in_prestine_session_authenticated_succeeds(
    mocker, django_user_model, client: Client
):
    m_create_chat_ticket = mocker.patch(
        "src.components.docu_web.helper.init_chat.create_chat_ticket",
        return_value=POST_CREATE_CHAT_TICKET_NORMALIZED(),
    )
    m_create_ticket_message = mocker.patch(
        "src.components.docu_web.helper.init_chat.create_ticket_message",
        return_value=POST_ADD_TICKET_NOTE_NORMALIZED(),
    )

    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(email=username, password=password)

    client = APIClient()
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)
    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")

    response = client.post("/api/v1/customer-chat/", {"message": "Hi"})

    assert response.status_code == HTTP_400_BAD_REQUEST
    assert response.data["message"] == "no contract found"

    contract = Contract.objects.create(code="123")
    contract.partners.add(user)

    response = client.post("/api/v1/customer-chat/", {"message": "Hi"})

    assert response.status_code == HTTP_200_OK
    assert response.data["message"] == "message send"
    assert len(Session.objects.filter(user=user)) == 1

    m_create_chat_ticket.assert_called()
    m_create_ticket_message.assert_not_called()


@pytest.mark.django_db
def test_post_message_in_existing_session_authenticated_succeeds(
    mocker, django_user_model, client: Client
):
    m_create_ticket_message = mocker.patch(
        "src.components.chat.session.views.create_ticket_message",
        return_value=POST_ADD_TICKET_NOTE_NORMALIZED(),
    )
    m_get_chat_ticket_messages = mocker.patch(
        "src.components.chat.session.views.get_chat_ticket_messages",
        return_value=GET_TICKET_NOTES_NORMALIZED(),
    )

    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(
        id=1, email=username, password=password
    )

    client = APIClient()
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)
    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")

    Session.objects.create(id=1, user=user, code="123")

    response = client.post("/api/v1/customer-chat/", {"message": "Hi"})

    assert response.status_code == HTTP_201_CREATED
    assert response.data == {
        "id": 1,
        "messages": GET_TICKET_NOTES_NORMALIZED()["data"]["session"]["messages"],
        "is_customer_session": True,
        "code": "123",
        "user": 1,
    }

    m_create_ticket_message.assert_called()
    m_get_chat_ticket_messages.assert_called()