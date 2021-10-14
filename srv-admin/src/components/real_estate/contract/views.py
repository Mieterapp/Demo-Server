from src.components.docu_web.webservices.masterdata import (
    build_get_partner_conditions_query,
    build_get_partner_ext_masterdata_query,
    get_partner_conditions,
    get_partner_contracts,
    get_partner_ext_masterdata,
)
from rest_framework.status import HTTP_404_NOT_FOUND
from src.components.real_estate.contract.model import Contract
from src.components.real_estate.contract.serializer import (
    ContractDetailSerializer,
    ContractsListSerializer,
)
from rest_framework import viewsets, mixins
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
import logging
logger = logging.getLogger(__name__)


class ContractViewSet(
    viewsets.ViewSet, mixins.ListModelMixin, mixins.RetrieveModelMixin
):
    permission_classes = (IsAuthenticated,)

    def _update_contracts(self, request):
        principal_id = request.user.principal_id
        response = get_partner_contracts({"sPartner": principal_id})
        if response["success"]:
            user_contract_codes = [c.code for c in request.user.contracts.all()]
            external_contracts = [
                Contract(**c)
                for c in response["data"]["contracts"]
                if c["code"] not in user_contract_codes
            ]
            external_contract_codes = [c.code for c in external_contracts]
            new_contracts_codes = [
                code
                for code in external_contract_codes
                if code not in user_contract_codes
            ]
            existing_contract_codes = [
                code for code in external_contract_codes if code in user_contract_codes
            ]
            if len(new_contracts_codes) > 0:
                new_contracts = [
                    c for c in external_contracts if c.code in new_contracts_codes
                ]
                Contract.objects.bulk_create(new_contracts)
                for contract in new_contracts:
                    contract.partners.add(request.user)

            for contract in response["data"]["contracts"]:
                Contract.objects.filter(code=contract["code"]).update(**contract)

    def list(self, request):
        self._update_contracts(request)
        queryset = self.request.user.contracts.all().order_by("type_name")
        counter = 0
        querysetmain = []
        querysetother = []
        for length in queryset:
            if length.rental_contract==None:
                testrentalcode = length.code[-13:]
                queryset[counter].rental_contract=testrentalcode
            counter += 1
            if length.type_name=="Mietvertrag Wohnung":
                querysetmain.append(length)
            else:
                querysetother.append(length)

        queryset = querysetmain + querysetother
        serializer = ContractsListSerializer(queryset, many=True)
        return Response(serializer.data)

    def retrieve(self, request, pk):
        try:
            queryset = self.request.user.contracts.get(id=pk)
            serializer = ContractDetailSerializer(queryset)
            # TODO: find configurable solution

            data = serializer.data.copy()
            testdata = data["rental_contract"]
            if testdata==None:
                data["rental_contract"]=data["code"][-13:]
            logger.debug(f"retrieve EMAIL NEW {str(data)}")
            partner_conditions = get_partner_conditions(
                build_get_partner_conditions_query(queryset)
            )
            if partner_conditions["success"]==True:
                data["condition"] = partner_conditions["data"]["contract"]["condition"]
            else:
                data["condition"] = "null"

            partner_ext_masterdata = get_partner_ext_masterdata(
                build_get_partner_ext_masterdata_query(queryset)
            )
            if partner_ext_masterdata["success"]==True:
                data["customer_center"] = partner_ext_masterdata["data"][
                    "customer_center"
                ]
                data["contact_person"] = partner_ext_masterdata["data"][
                    "contact_person"
                ]
                #testneu = partner_ext_masterdata["data"]["contract"]["condition"]["contract_balance"]
                #logger.debug(f"retrieve EMAIL NEW DATA {str(testneu)}")
                if data["condition"]!="null":
                    #testneu = data["condition"]["prepayment_difference"]
                    #logger.debug(f"retrieve EMAIL NEW DATA {str(testneu)}")
                    data["condition"]["prepayment_difference"]=partner_ext_masterdata["data"]["contract"]["condition"]["contract_balance"]
            else:
                data["customer_center"] = None
                data["contact_person"] = None

            #logger.debug(f"retrieve EMAIL NEW DATA {str(testdata)}")
            logger.debug(f"retrieve EMAIL NEW DATA {str(data)}")
            #logger.debug(f"retrieve EMAIL NEW partner_ext_masterdata CONDItiON {str(partner_ext_masterdata)}")
            #logger.debug(f"retrieve EMAIL NEW CONDItiON {str(partner_conditions)}")
            #logger.debug(f"retrieve EMAIL NEW QUERYSET {str(queryset)}")
            return Response(data)
        except Contract.DoesNotExist:
            return Response(status=HTTP_404_NOT_FOUND)
