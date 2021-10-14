from src.components.issues.issue_answer.models import IssueAnswer
from src.components.issues.issue.models import Issue
from src.components.docu_web.webservices.__mocks__.tickets_get_ticket_process_fields_first_step import (
    GET_TICKET_PROCESS_FIELDS_FIRST_STEP_TEST_INFO_TICKET,
    GET_TICKET_PROCESS_FIELDS_FIRST_STEP_TEST_INFO_TICKET_NORMALIZED,
)
from src.components.docu_web.webservices.__mocks__.tickets_post_add_ticket_note import (
    POST_ADD_TICKET_NOTE,
    POST_ADD_TICKET_NOTE_NORMALIZED,
)
import pytest

from src.components.docu_web.mock_utils import (
    MockResponse,
    get_xml_wrapped_json,
    get_xml_wrapped_string,
)
from src.components.docu_web.webservices.__mocks__.tickets_get_keywords import (
    GET_KEYWORDS,
    GET_KEYWORD_NORMALIZED,
)
from src.components.docu_web.webservices.__mocks__.tickets_get_ticket_notes import (
    GET_TICKET_NOTES,
    GET_TICKET_NOTES_NORMALIZED,
)
from src.components.docu_web.webservices.__mocks__.tickets_post_create_ticket import (
    POST_CREATE_TICKET,
    POST_CREATE_CHAT_TICKET_NORMALIZED,
    POST_CREATE_TICKET_NORMALIZED,
)
from src.components.docu_web.webservices.tickets import (
    build_create_chat_ticket_query,
    build_create_ticket_query,
    build_field_values,
    build_get_ticket_process_fields_first_step_query,
    create_chat_ticket,
    create_ticket,
    create_ticket_message,
    get_chat_ticket_messages,
    get_keywords,
    get_ticket_process_fields_first_step,
)
from src.components.real_estate.contract.model import Contract


def test_get_keywords(mocker):
    m_api_get = mocker.patch(
        "src.components.docu_web.webservices.tickets.api_get",
        return_value=MockResponse(get_xml_wrapped_json(GET_KEYWORDS)),
    )

    response = get_keywords()

    m_api_get.assert_called()
    assert response == GET_KEYWORD_NORMALIZED()


@pytest.mark.django_db
def test_get_ticket_process_fields_first_step(mocker):
    m_api_get = mocker.patch(
        "src.components.docu_web.webservices.tickets.api_get",
        return_value=MockResponse(
            get_xml_wrapped_json(GET_TICKET_PROCESS_FIELDS_FIRST_STEP_TEST_INFO_TICKET)
        ),
    )

    issue = Issue.objects.create(code="123")
    response = get_ticket_process_fields_first_step(
        build_get_ticket_process_fields_first_step_query(issue)
    )

    m_api_get.assert_called()
    assert (
        response == GET_TICKET_PROCESS_FIELDS_FIRST_STEP_TEST_INFO_TICKET_NORMALIZED()
    )


@pytest.mark.django_db
def test_create_ticket(mocker, django_user_model):
    m_api_post = mocker.patch(
        "src.components.docu_web.webservices.tickets.api_post",
        return_value=MockResponse(get_xml_wrapped_string(POST_CREATE_TICKET)),
    )

    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(email=username, password=password)

    contract = Contract.objects.create(id=1, code="123")
    contract.partners.add(user)

    issue = Issue.objects.create(id=1, code="123")

    query = build_create_ticket_query({"contract": contract, "issue": issue})

    response = create_ticket(query=query)

    m_api_post.assert_called_with(
        path="/api/webservices/Tickets.cfc",
        query=query,
    )

    assert response == POST_CREATE_TICKET_NORMALIZED()


# TODO: Add test with failing response
@pytest.mark.django_db
def test_create_chat_ticket(mocker, django_user_model):
    m_api_post = mocker.patch(
        "src.components.docu_web.webservices.tickets.api_post",
        return_value=MockResponse(get_xml_wrapped_string(POST_CREATE_TICKET)),
    )

    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(email=username, password=password)

    contract = Contract.objects.create(code="123")
    contract.partners.add(user)

    query = build_create_chat_ticket_query(
        {"contract": contract, "message": "initial message"}
    )

    response = create_chat_ticket(query=query)

    m_api_post.assert_called_with(
        path="/api/webservices/Tickets.cfc",
        query=query,
    )

    assert response == POST_CREATE_CHAT_TICKET_NORMALIZED()


# TODO: Add test with failing response
def test_create_ticket_message(mocker):
    m_api_post = mocker.patch(
        "src.components.docu_web.webservices.tickets.api_post",
        return_value=MockResponse(get_xml_wrapped_json(POST_ADD_TICKET_NOTE)),
    )

    query = {
        "method": "addTicketNote",
        "sTicketnr": "64-201216-Q0005",
        "sNote": "This is the message",
    }

    response = create_ticket_message(query=query)

    m_api_post.assert_called_with(
        path="/api/webservices/Tickets.cfc",
        query=query,
    )

    assert response == POST_ADD_TICKET_NOTE_NORMALIZED()


def test_get_chat_ticket_messages(mocker):
    m_api_get = mocker.patch(
        "src.components.docu_web.webservices.tickets.api_get",
        return_value=MockResponse(get_xml_wrapped_json(GET_TICKET_NOTES)),
    )

    query = {"method": "getTicketNotes", "sTicketnr": "123"}

    response = get_chat_ticket_messages(query=query)

    m_api_get.assert_called_with(
        path="/api/webservices/Tickets.cfc",
        query=query,
    )

    assert response == GET_TICKET_NOTES_NORMALIZED()


@pytest.mark.django_db
def test_build_field_values():
    IssueAnswer.objects.create(id=1, code="123")

    response = build_field_values('{"1": "this is a test"}')

    assert response == {"sFieldvalues": {"123": "this is a test"}}
