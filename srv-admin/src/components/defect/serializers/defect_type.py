import swapper
from rest_framework import serializers


class DefectTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = swapper.load_model("defect", "DefectType")
        exclude = [
            "visible_groups",
        ]
