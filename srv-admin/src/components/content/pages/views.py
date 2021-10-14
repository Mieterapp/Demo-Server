import datetime
from src.components.content.pages.model import Page
from src.components.content.pages.serializer import PageSerializer

from rest_framework import viewsets
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

class PagesViewSet(viewsets.ReadOnlyModelViewSet):

    permission_classes = (AllowAny,)
    serializer_class = PageSerializer
    queryset = Page.objects.all()

    def list(self, request):
        pages_data = []
        for dt in Page.objects.all():
            data = {
                "id": dt.id,
                "name": dt.slug,
                "html_content": dt.html,
            }
            pages_data.append(data)

        return Response(pages_data)
