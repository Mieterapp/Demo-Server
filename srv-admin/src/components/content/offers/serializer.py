from django.conf import settings
from django.contrib.sites.models import Site
from rest_framework import serializers
from rest_framework.decorators import permission_classes
from rest_framework.permissions import AllowAny

from src.components.content.offers.models import Offer


# FIXME: static path for icon
class OfferSerializer(serializers.ModelSerializer):
    @permission_classes(
        [
            AllowAny,
        ]
    )
    class Meta:
        model = Offer
        fields = ("id", "title", "text", "website", "icon", "visible_role","icons")
