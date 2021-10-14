import pytest
from django.test.client import Client
from rest_framework.status import HTTP_200_OK

from .models import FAQ


@pytest.mark.django_db
def test_faqs_anonymous_succeeds(client: Client):
    FAQ.objects.create(
        title="FAQ 1",
        text="Text FAQ 1",
        href="https://www.dit-digital.de/some/faq-ressource",
        group="Group",
        sorting=1,
    )

    public_faqs = client.get("/api/v1/faqs/")

    assert public_faqs.status_code == HTTP_200_OK
    assert len(public_faqs.data) == 1

    public_faqs = client.get("/api/v1/faqs/1/")

    assert public_faqs.status_code == HTTP_200_OK