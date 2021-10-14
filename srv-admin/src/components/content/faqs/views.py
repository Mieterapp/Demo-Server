from src.components.content.utils import get_filtered_by_object_id
from django.db.models import Q
from rest_framework import viewsets
from rest_framework.permissions import AllowAny

from src.components.content.faqs.models import FAQ
from src.components.content.faqs.serializer import FAQSerializer


class FAQViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = (AllowAny,)
    queryset = FAQ.objects.all()
    serializer_class = FAQSerializer

    def filter_queryset(self, queryset):
        queryset = super(FAQViewSet, self).filter_queryset(queryset).order_by("title")

        if self.request.user.is_anonymous:
            return queryset.filter(visible_role=None)

        if len(self.request.user.groups.all()) >= 1:
            group_ids = [g.id for g in self.request.user.groups.all()]
            queryset = queryset.filter(visible_role__in=group_ids)

        ids = get_filtered_by_object_id(self.request.user, queryset)

        return queryset.filter(id__in=ids)
