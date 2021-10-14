import swapper
from django.utils.module_loading import import_string
from rest_framework import mixins, viewsets
from rest_framework.permissions import IsAuthenticated
from django.contrib.admin.decorators import register

from src.shared.filter_backends import VisibleGroups

from ..settings import dit_defect_settings

Area = swapper.load_model("defect", "Area")
AreaSerializer = import_string(dit_defect_settings.SERIALIZER_CLASSES["AREA"])


class AreaViewSet(mixins.ListModelMixin, viewsets.GenericViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Area.objects.all()
    serializer_class = AreaSerializer
    filter_backends = [VisibleGroups]
