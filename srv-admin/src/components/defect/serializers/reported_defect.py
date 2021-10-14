import swapper
from django.utils.module_loading import import_string
from django.utils.translation import gettext as _
from drf_extra_fields.fields import Base64ImageField
from rest_framework import fields, serializers
from rest_framework.fields import CurrentUserDefault

from ..settings import dit_defect_settings

DefectResolutionRatingSerializer = import_string(dit_defect_settings.SERIALIZER_CLASSES["DEFECT_RESOLUTION_RATING"])


class ReportedDefectSerializer(serializers.ModelSerializer):
    class Meta:
        model = swapper.load_model("defect", "ReportedDefect")
        fields = "__all__"

    reported_by = serializers.HiddenField(
        default=CurrentUserDefault(),
    )

    status = fields.ReadOnlyField()

    ratings = DefectResolutionRatingSerializer(
        many=True,
        read_only=True,
    )

    image_1_thumbnail = fields.ImageField(
        read_only=True,
    )

    image_2_thumbnail = fields.ImageField(
        read_only=True,
    )

    image_1 = Base64ImageField(
        allow_null=True,
    )

    image_2 = Base64ImageField(
        allow_null=True,
    )

    def validate(self, data):
        defect = data["defect"]
        if not defect:
            return data
        if defect.is_image_required and not data["image_1"] and not data["image_2"]:
            raise serializers.ValidationError(_("At least one image is required, to report this defect."))
        return data
