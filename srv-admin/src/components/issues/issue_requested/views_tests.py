import json
from src.components.real_estate.contract.model import Contract
import pytest
from .models import IssueRequested

from django.contrib.auth import get_user_model
from rest_framework.status import HTTP_200_OK, HTTP_201_CREATED, HTTP_403_FORBIDDEN
from rest_framework.test import APIClient
from rest_framework_jwt.utils import jwt_encode_handler, jwt_payload_handler

from ..constants import AT_TEXT, SIGNING_CHOICE_DIGITAL
from ..issue.models import Issue
from ..issue_answer.models import IssueAnswer


def test_issues_requested_unauthorized_returns_forbidden(client):
    response = client.post("/api/v1/issues_requested/", {})
    assert response.status_code == HTTP_403_FORBIDDEN


@pytest.mark.django_db
def test_get_issues_requested_authorized_returns_ok(mocker):
    issues_requested_data = [
        {"id": 1, "code": "200372772"},
        {"id": 2, "code": "200372773"},
        {"id": 3, "code": "200372774"},
    ]
    for i in issues_requested_data:
        Issue.objects.create(code=i["code"])

    # results = [{"id": issue["code"]} for issue in issues]

    # request_sap_params_cloud_get = mocker.patch(
    #     "components.issues.formular_requested.views.request_sap_params_cloud_get",
    #     return_value={"d": {"results": results}},
    # )

    client = APIClient()
    user = get_user_model().objects.create(email="a@b.cd")
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)
    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")

    for issue in issues_requested_data:
        issue_template = Issue.objects.get(code=issue["code"])
        IssueRequested.objects.create(id=issue["id"], issue=issue_template, user=user)

    response = client.get("/api/v1/issues_requested/")

    # request_sap_params_cloud_get.assert_called_with(
    #     {},
    #     path=f"/tenant('{user.username}')/notifications",
    # )

    response_ids = [issue["id"] for issue in response.data]
    expected_ids = [issue["id"] for issue in issues_requested_data][::-1]

    assert response.status_code == HTTP_200_OK
    assert response_ids == expected_ids


@pytest.mark.django_db
def test_post_issues_requested_authorized_and_not_requires_printing_returns_ok(
    settings,
):
    settings.DIT_ISSUE = {"ISSUE_REQUESTED_CREATE_HANDLER": None}

    client = APIClient()
    # cp = ContactPerson.objects.create(role_sqp="ZCL206")
    user = get_user_model().objects.create(email="a@b.cd")
    # user.contact_persons.add(cp)
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)

    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")
    html_form = "<html>{{text_marker}}</html>"
    form = Issue.objects.create(id=1, html=html_form)

    text_marker = "text_marker"
    IssueAnswer.objects.create(
        id=1,
        issue=form,
        type=AT_TEXT[0],
        question="What are you doing?",
        marker=text_marker,
    )
    answers = {"1": "testing"}

    response = client.post(
        "/api/v1/issues_requested/",
        {"issue": form.id, "user": user.id, "answers": json.dumps(answers)},
    )

    # request_sap_params_cloud_post.assert_called_with(
    #     {
    #         "userId": "P001406",
    #         "typeId": "IV",
    #         "codeGroupId": None,
    #         "codeId": None,
    #         "propertyId": None,
    #         "description": "What are you doing?: testing\n",
    #     },
    #     path="/notifications",
    #     auth="Bearer 123",
    # )

    assert response.status_code == HTTP_201_CREATED
    assert response.data["issue"] == 1


# FIXME: update integration and reenable test
# @pytest.mark.django_db
# def test_post_issues_requested_authorized_and_requires_printing_returns_ok(mocker):
#     from_string = mocker.patch(
#         "components.issues.utils.pdfkit.from_string", return_value=b""
#     )
#     refresh_user_data = mocker.patch(
#         "components.issues.formular_requested.views.refresh_user_data"
#     )

#     client = APIClient()
#     # cp = ContactPerson.objects.create(role_sqp="ZCL206")
#     user = get_user_model().objects.create(username="tester", email="a@b.cd")
#     # user.contact_persons.add(cp)
#     payload = jwt_payload_handler(user)
#     token = jwt_encode_handler(payload)
#     client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")
#     html_form = "<html>{{text_marker}}</html>"
#     form = Issue.objects.create(
#         title="MyForm", html=html_form, signing_type=SIGNING_CHOICE_DIGITAL[0]
#     )

#     text_marker = "text_marker"
#     IssueAnswer.objects.create(id=1, formular=form, type=AT_TEXT[0], marker=text_marker)
#     answers = {"1": "test"}

#     response = client.post(
#         "/api/v1/issues_requested/",
#         {"formular": form.id, "tenant": user.id, "answers": json.dumps(answers)},
#     )

#     assert response.status_code == HTTP_201_CREATED
#     assert response["content-type"] == "application/json"
#     assert response.data["title"] == "MyForm"

#     refresh_user_data.assert_called()
#     from_string.assert_called_with(
#         html_form.replace("{{text_marker}}", answers["1"]),
#         False,
#         options={
#             "encoding": "UTF-8",
#             "page-size": "A4",
#             "margin-top": "0mm",
#             "margin-bottom": "0mm",
#             "margin-left": "0mm",
#             "margin-right": "0mm",
#             "dpi": 800,
#         },
#     )
