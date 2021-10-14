from rest_framework import filters


class IsContractPartnerFilterBackend(filters.BaseFilterBackend):
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(contract__partners__in=[request.user])
