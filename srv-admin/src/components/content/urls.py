from src.components.content.pages.views import PagesViewSet
from src.components.content.offers.views import OfferViewSet
from src.components.content.faqs.views import FAQViewSet
from django.urls import path
from rest_framework.routers import DefaultRouter


from . import NS
from .news.views import NewsViewSet

app_name = "dit_content"

router = DefaultRouter()
router.register("news", NewsViewSet, basename="news")
router.register("faqs", FAQViewSet, basename="faqs")
router.register("offers", OfferViewSet, basename="offers")
router.register("pages", PagesViewSet, basename="pages")

urlpatterns = router.urls
