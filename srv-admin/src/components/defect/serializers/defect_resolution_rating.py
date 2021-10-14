import swapper
from django.utils.translation import gettext as _
from rest_framework import serializers


class DefectResolutionRatingSerializer(serializers.ModelSerializer):
    class Meta:
        model = swapper.load_model("defect", "DefectResolutionRating")
        exclude = [
            "id",
        ]
