from rest_framework import serializers
from rest_framework.decorators import permission_classes
from rest_framework.permissions import AllowAny

from .models import FAQ


class FAQSerializer(serializers.HyperlinkedModelSerializer):
    @permission_classes(
        [
            AllowAny,
        ]
    )
    class Meta:
        model = FAQ
        fields = (
            "id",
            "title",
            "text",
            # "visible_role",
            "href",
            "group",
            "sorting",
        )
