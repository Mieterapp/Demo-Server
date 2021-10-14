import swapper
from django.utils.module_loading import import_string
from django_filters.rest_framework.backends import DjangoFilterBackend
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated

from src.shared.permissions import IsReportedByOwner as IsReportedByOwnerPermission

from ..settings import dit_defect_settings

ReportedDefect = swapper.load_model("defect", "ReportedDefect")
ReportedDefectSerializer = import_string(dit_defect_settings.SERIALIZER_CLASSES["REPORTED_DEFECT"])

FilterBackend = import_string(dit_defect_settings.FILTER_BACKENDS["REPORTED_DEFECT"])


class ReportedDefectViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated, IsReportedByOwnerPermission)
    queryset = ReportedDefect.objects.all()
    serializer_class = ReportedDefectSerializer
    filter_backends = [FilterBackend, DjangoFilterBackend]
    filterset_fields = ["contract"]
