from rest_framework.routers import DefaultRouter

from . import NS
from .issue.views import IssuesViewSet, IssueStatusViewSet

from .issue_requested.views import IssuesRequestedViewSet

app_name = "dit_issue"

router = DefaultRouter()
router.register("issues", IssuesViewSet, basename="issues")
router.register("issues_requested", IssuesRequestedViewSet, basename="issues_requested")
router.register("issues_status", IssueStatusViewSet, basename="issues_status")

urlpatterns = router.urls
