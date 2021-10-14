from src.components.survey.views import SurveyViewSet
from rest_framework.routers import DefaultRouter


from . import NS

router = DefaultRouter()
router.register(r"survey", SurveyViewSet, basename="Survey")

urlpatterns = router.urls
