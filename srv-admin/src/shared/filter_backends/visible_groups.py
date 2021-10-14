from django.db.models import Q
from rest_framework import filters


class VisibleGroups(filters.BaseFilterBackend):
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            Q(visible_groups=None)
            | Q(visible_groups__in=request.user.groups.values_list("id", flat=True))
        ).distinct()
