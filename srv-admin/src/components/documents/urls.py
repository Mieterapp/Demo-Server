from rest_framework.routers import DefaultRouter

from src.components.documents.views import DocumentViewSet, DocumentwithContractViewSet

from . import NS

app_name = "dit_content"

router = DefaultRouter()
router.register("documents", DocumentViewSet, basename="documents")
router.register("contract_documents", DocumentwithContractViewSet, basename="contract_documents")

urlpatterns = router.urls
