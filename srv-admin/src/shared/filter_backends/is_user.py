from django.db.models import Q
from rest_framework import filters


class IsCurrentUser(filters.BaseFilterBackend):
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(user=request.user)
