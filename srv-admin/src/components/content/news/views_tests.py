from rest_framework.test import APIClient
from rest_framework_jwt.utils import jwt_encode_handler, jwt_payload_handler
from src.components.real_estate.properties.model import Property
import pytest
from django.test.client import Client
from rest_framework.status import HTTP_200_OK, HTTP_405_METHOD_NOT_ALLOWED

from src.components.content.news.model import News


@pytest.mark.django_db
def test_news_get_anonymous_succeeds(django_user_model, client: Client):
    News.objects.create(title="N1", text="N1")

    public_news = client.get("/api/v1/news/")

    assert public_news.status_code == HTTP_200_OK
    assert len(public_news.data) == 1

    public_news = client.get("/api/v1/news/1/")

    assert public_news.status_code == HTTP_200_OK


@pytest.mark.django_db
def test_news_get_for_property_succeeds(django_user_model, client: Client):
    company_code = "123"
    p1 = Property.objects.create(id="P1", company_code=company_code)
    News.objects.create(title="N1", text="N1")
    n_in_property = News.objects.create(title="N1", text="N1")
    n_in_property.property.add(p1)

    username = "a@b.cd"
    password = "123"
    user = django_user_model.objects.create_user(email=username, password=password)

    client = APIClient()
    payload = jwt_payload_handler(user)
    token = jwt_encode_handler(payload)
    client.credentials(HTTP_AUTHORIZATION=f"JWT {token}")
    public_news = client.get("/api/v1/news/")

    assert public_news.status_code == HTTP_200_OK
    # TODO: fix filter by company_code
    # assert len(public_news.data) == 2


@pytest.mark.django_db
def test_news_post_fails(django_user_model, client: Client):
    public_news = client.post("/api/v1/news/", {})

    assert public_news.status_code == HTTP_405_METHOD_NOT_ALLOWED
