import swapper
from django.utils.module_loading import import_string
from rest_framework import mixins, viewsets
from rest_framework.permissions import IsAuthenticated

from ..settings import dit_defect_settings

DefectResolutionRating = swapper.load_model("defect", "DefectResolutionRating")
DefectResolutionRatingSerializer = import_string(
    dit_defect_settings.SERIALIZER_CLASSES["DEFECT_RESOLUTION_RATING"]
)


class DefectResolutionRatingViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    permission_classes = [IsAuthenticated]
    queryset = DefectResolutionRating.objects.all()
    serializer_class = DefectResolutionRatingSerializer
