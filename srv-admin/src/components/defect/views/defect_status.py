from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet

from ..settings import dit_defect_settings


class DefectStatusView(ViewSet):
    permission_classes = [
        IsAuthenticated,
    ]

    def list(self, request, format=None):
        return Response([{choice[0]: choice[1]} for choice in dit_defect_settings.STATUS_CHOICES.choices])
