import swapper
from rest_framework import serializers


class DefectSerializer(serializers.ModelSerializer):
    class Meta:
        model = swapper.load_model("defect", "Defect")
        exclude = [
            "visible_groups",
        ]
