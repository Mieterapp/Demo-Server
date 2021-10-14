from rest_framework.permissions import BasePermission


class IsReportedByOwner(BasePermission):
    def has_permission(self, request, view):
        return True
