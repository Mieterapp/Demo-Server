from django.db.models import Q
from rest_framework import filters


class IsReportedByOwner(filters.BaseFilterBackend):
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(reported_by=request.user)
