from django.conf.urls import include
from django.urls.conf import re_path
from rest_framework import routers
from rest_framework.response import Response
from rest_framework.reverse import reverse
from rest_framework.views import APIView

from src.components.authentication_local import urls as AL_URLS
from src.components.authentication_local.urls import app_name as NAMESPACE
from src.components.chat import urls as CHAT_URLS
from src.components.content import urls as CONTENT_URLS
from src.components.dit_push_notifications import urls as DIT_PUSH_NOTIFICATIONS_URLS
from src.components.documents import urls as DOCUMENT_URLS
from src.components.defect import urls as DEFECT_URLS
from src.components.issues import urls as ISSUE_URLS
from src.components.real_estate import urls as REAL_ESTATE_URLS
from src.components.survey import urls as SURVEY_URLS
from src.integrations.gwg_tenant.user.models import AuthenticatedUserAPIView

app_name = "gwg_api"
NS = f"{app_name}:{NAMESPACE}"


class GWGApiTitleView(routers.APIRootView):
    """
    GWG API documentation
    """

    pass


class DocumentedRouter(routers.DefaultRouter):
    APIRootView = GWGApiTitleView


class APIRoot(APIView):
    """
    GWG API documentation
    """

    def get(self, request, format=None):
        # TODO: create root view automatically
        # [p.name for p in urlpatterns]
        return Response(
            {
                "register": reverse(f"{NS}:register", request=request, format=format),
                "verify-email": reverse(
                    f"{NS}:verify-email",
                    request=request,
                    format=format,
                ),
                "authenticate": reverse(
                    f"{NS}:authenticate",
                    request=request,
                    format=format,
                ),
                "password-reset": reverse(
                    f"{NS}:password-reset",
                    request=request,
                    format=format,
                ),
                "password-change": reverse(
                    f"{NS}:password-change",
                    request=request,
                    format=format,
                ),
                "authenticated-user": reverse(
                    f"{app_name}:authenticated-user",
                    request=request,
                    format=format,
                ),
            }
        )


router = DocumentedRouter()

urlpatterns = [
    re_path(r"^$", APIRoot.as_view()),
    re_path(r"", include(AL_URLS)),
    re_path(r"", include(CHAT_URLS)),
    re_path(r"", include(CONTENT_URLS)),
    re_path(r"", include(DIT_PUSH_NOTIFICATIONS_URLS)),
    re_path(r"", include(DOCUMENT_URLS)),
    re_path(r"", include(DEFECT_URLS)),
    re_path(r"", include(ISSUE_URLS)),
    re_path(r"", include(REAL_ESTATE_URLS)),
    re_path(r"", include(SURVEY_URLS)),
    re_path(
        r"^authenticated-user",
        AuthenticatedUserAPIView.as_view({"get": "get", "patch": "patch"}),
        name="authenticated-user",
    ),
]

urlpatterns += router.urls
