from rest_framework.routers import DefaultRouter

from src.components.real_estate.customer_center.views import CustomerCenterViewSet
from src.components.real_estate.contract.views import ContractViewSet

from . import NS

app_name = "dit_real_estate"

router = DefaultRouter()
router.register(r"customer-center", CustomerCenterViewSet, basename="customer-center")
router.register(r"contracts", ContractViewSet, basename="contracts")

urlpatterns = router.urls
