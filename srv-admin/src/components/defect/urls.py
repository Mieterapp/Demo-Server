from rest_framework.routers import DefaultRouter

from .views.area import AreaViewSet
from .views.defect import DefectViewSet
from .views.defect_resolution_rating import DefectResolutionRatingViewSet
from .views.defect_status import DefectStatusView
from .views.defect_type import DefectTypeViewSet
from .views.reported_defect import ReportedDefectViewSet

app_name = "dit_defect"


class DefectApiRoot(DefaultRouter):
    include_root_view = False


router = DefectApiRoot()
router.register("areas", AreaViewSet, basename="areas")
router.register(
    "defect-resolution-rating",
    DefectResolutionRatingViewSet,
    basename="defect-resolution-rating",
)
router.register("defect-status", DefectStatusView, basename="defect-status")
router.register("defect-types", DefectTypeViewSet, basename="defect-types")
router.register("defects", DefectViewSet, basename="defects")
router.register("reported-defects", ReportedDefectViewSet, basename="reported-defects")

urlpatterns = router.urls
