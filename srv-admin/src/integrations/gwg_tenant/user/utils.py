import json
from rest_framework import serializers, status
from rest_framework.response import Response
import logging
logger = logging.getLogger(__name__)

def build_get_indexes_query_dict_from_user(user):
    # TODO:
    # - [ ] handle missing contract. Maybe raise?
    if user:
        #logger.debug(f"build_get_indexes_query_dict_from_user CONRACTS NEW A {str(user)}")
        logger.debug(f"build_get_indexes_query_dict_from_user CONRACTS NEW A {str(user.contracts)}")
        if user.contracts:
            contract = user.contracts.filter(
                rental_contract__isnull=False, company_code__isnull=False
            ).first()
            contract2 = user.contracts.filter(
                rental_contract__isnull=False, company_code__isnull=False
            ).values()
            logger.debug(f"build_get_indexes_query_dict_from_user CONRACTS NEW A {contract2}")
            return {
                "f2": "BUKRS",
                "f2_op": "=",
                "f2_val": contract.company_code if contract else "",
                "f2_con": "AND",
                "f3": "RECNNR",
                "f3_op": "=",
                "f3_val": contract.rental_contract if contract else "",
            }
        else:
            #logger.debug(f"build_get_indexes_query_dict_from_user CONRACTS NEW A {str(contract)}")
            return {"error"}
    else:
        return Response("No Contracts or no User", status=status.HTTP_400_BAD_REQUEST)


def build_get_partner_id_query_dict(data):
    logger.debug(f" RegisterAPIView REGISTRATION 2 DATA  {str(data)}")
    if data:
        return {
            "sParams": json.dumps(
                {"RECNNR": data["contract"], "BIRTHDT": None, "PARTNER": data["principal_id"]}
            )
        }
    else:
        return {
            "sParams": json.dumps(
                {"RECNNR": None, "BIRTHDT": None, "PARTNER": None}
            )
        }
