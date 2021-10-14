import pytest

from src.components.docu_web.helper.init_chat import init_chat
from src.components.docu_web.mock_utils import MockResponse
from src.components.docu_web.webservices.__mocks__.tickets_post_add_ticket_note import (
    POST_ADD_TICKET_NOTE_NORMALIZED,
)
from src.components.docu_web.webservices.__mocks__.tickets_post_create_ticket import (
    POST_CREATE_CHAT_TICKET_NORMALIZED,
)
from src.components.real_estate.contract.model import Contract


@pytest.mark.django_db
def test_init_chat_succeeds(mocker, django_user_model):
    m_create_chat_ticket = mocker.patch(
        "src.components.docu_web.helper.init_chat.create_chat_ticket",
        return_value=POST_CREATE_CHAT_TICKET_NORMALIZED(),
    )

    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(
        id=1, email=username, password=password
    )

    contract = Contract.objects.create(code="123")
    data = {"message": "This ist the message", "contract": contract}

    response = init_chat(user, data)

    assert response["success"] == True

    m_create_chat_ticket.assert_called()
