import swapper
from rest_framework import serializers


class AreaSerializer(serializers.ModelSerializer):
    class Meta:
        model = swapper.load_model("defect", "Area")
        exclude = [
            "visible_groups",
        ]
