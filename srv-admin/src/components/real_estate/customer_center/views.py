from src.components.docu_web.helper.customer_center import (
    get_customer_center_by_contracts,
)
from rest_framework import viewsets, mixins
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response


class CustomerCenterViewSet(viewsets.ViewSet, mixins.ListModelMixin):
    permission_classes = (IsAuthenticated,)

    def list(self, request):
        contracts = self.request.user.contracts.all()
        customer_center_normalized = get_customer_center_by_contracts(contracts)

        return Response(customer_center_normalized)