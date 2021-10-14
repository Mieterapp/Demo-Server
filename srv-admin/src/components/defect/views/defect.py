import swapper
from django.utils.module_loading import import_string
from django_filters.rest_framework.backends import DjangoFilterBackend
from rest_framework import mixins, viewsets
from rest_framework.permissions import IsAuthenticated

from src.shared.filter_backends import VisibleGroups

from ..settings import dit_defect_settings

Defect = swapper.load_model("defect", "Defect")
DefectSerializer = import_string(dit_defect_settings.SERIALIZER_CLASSES["DEFECT"])


class DefectViewSet(mixins.ListModelMixin, viewsets.GenericViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Defect.objects.all()
    serializer_class = DefectSerializer
    filter_backends = [VisibleGroups, DjangoFilterBackend]
    # spezifische id felder hier mit aufnehmen
    filterset_fields = ["defect_type"]
