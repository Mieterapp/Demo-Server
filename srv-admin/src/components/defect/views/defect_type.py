import swapper
from django.utils.module_loading import import_string
from rest_framework import mixins, viewsets
from rest_framework.permissions import IsAuthenticated

from src.shared.filter_backends import VisibleGroups

from ..settings import dit_defect_settings

DefectType = swapper.load_model("defect", "DefectType")
DefectTypeSerializer = import_string(
    dit_defect_settings.SERIALIZER_CLASSES["DEFECT_TYPE"]
)


class DefectTypeViewSet(mixins.ListModelMixin, viewsets.GenericViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = DefectType.objects.all()
    serializer_class = DefectTypeSerializer
    filter_backends = [VisibleGroups]
