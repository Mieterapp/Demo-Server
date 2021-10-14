from src.components.real_estate.contract.model import Contract
from src.components.docu_web.webservices.__mocks__.tickets_post_create_ticket import (
    POST_CREATE_TICKET,
)
from src.components.docu_web.mock_utils import MockResponse, get_xml_wrapped_string
from django.test.client import RequestFactory
from src.components.docu_web.helper.issue_requested_create_handler import (
    issue_requested_create_handler,
)
from django.contrib.auth import get_user_model
from src.components.issues.issue_requested.views import IssueRequestedSerializer
import pytest

from src.components.issues.issue.models import Issue


@pytest.mark.django_db
def test_issue_requested_create_handler(mocker):
    m_api_post = mocker.patch(
        "src.components.docu_web.webservices.tickets.api_post",
        return_value=MockResponse(get_xml_wrapped_string(POST_CREATE_TICKET)),
    )

    issue = Issue.objects.create(id=1, code="test")
    user = get_user_model().objects.create(email="a@b.cd")
    contract = Contract.objects.create(id=1, code="123")
    contract.partners.add(user)

    serializer = IssueRequestedSerializer(
        data={"issue": issue.id, "user": user.id, "answers": '{"1": "testing"}'}
    )
    serializer.is_valid()
    serializer.save(user=user)
    request = RequestFactory()

    response = issue_requested_create_handler(serializer, request)

    m_api_post.assert_called()
    assert response["success"] == True
    assert serializer.instance.code == "64-201217-Q0001"
