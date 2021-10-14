import os

from django.conf import settings
from django.template.defaultfilters import filesizeformat
from rest_framework import serializers
from rest_framework.decorators import permission_classes
from rest_framework.permissions import AllowAny

from src.components.content.settings import dit_content_settings

from .model import News
import logging
logger = logging.getLogger(__name__)

class NewsSerializer(serializers.ModelSerializer):
    class Meta:
        model = News
        fields = (
            "id",
            "title",
            # "title_en",
            # "title_ru",
            # "title_tr",
            "text",
            # "text_en",
            # "text_ru",
            # "text_tr",
            "document",
            # "document_url_en",
            # "document_url_ru",
            # "document_url_tr",
            # "document_size",
            # "document_name",
            "href",
            "kind",
            # "visible_role",
            # "visible_object",
            "show_in_header",
            "date_from",
            "date_to",
            "order",
            "documents",
        )
