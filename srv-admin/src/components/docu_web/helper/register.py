from src.components.real_estate.contract.model import Contract
from django.contrib.auth import get_user_model
from src.shared.utils.dict_helper import dict_deep_merge
from src.integrations.gwg_tenant.user.utils import build_get_partner_id_query_dict
from src.components.docu_web.webservices.masterdata import (
    build_get_partner_masterdata_query,
    get_partner_id,
    get_partner_masterdata,
)
from src.components.chat.session.constants import WELCOME_MESSAGE
from src.components.chat.session.model import Session
from src.components.docu_web.helper.init_chat import init_chat
import logging
logger = logging.getLogger(__name__)
UserModel = get_user_model()


def handle_register_user(email, password, data):
    response_partner_id = get_partner_id(build_get_partner_id_query_dict(data))
    logger.debug(f" RegisterAPIView REGISTRATION 2  {str(response_partner_id)}")
    if response_partner_id["success"]:
        response_partner_masterdata = get_partner_masterdata(
            build_get_partner_masterdata_query(response_partner_id["data"]["user"])
        )
        if response_partner_masterdata["success"]:
            registration_data = dict_deep_merge(
                dict(response_partner_id), dict(response_partner_masterdata)
            )
            return {
                "user": create_user_instance_and_relations(
                    email=email, password=password, registration_data=registration_data
                ),
                "error": None,
                "success": True,
            }

        return {"error": "could not get master data", "success": False}

    return {"error": "could not identify user", "success": False}


def create_user_instance_and_relations(email: str, password: str, registration_data):
    """
    TODO:
    - [ ] check if email and registration_data.user.email are equal
    - [ ] if emails are different, create ticket or something
    - [x] add contract relations
    - [x] add groups relations
    """

    registration_data["data"]["user"].pop("email")
    registration_data["data"]["user"].pop("contract")
    groups = registration_data["data"]["user"].pop("groups")

    user = UserModel.objects.create_user(
        email=email, password=password, **registration_data["data"]["user"]
    )
    user.groups.set(groups)

    contract = Contract.objects.create(**registration_data["data"]["contract"])
    contract.partners.add(user)
    logger.debug(f"create_user_instance_and_relations new chat data of tenantFFF A {contract} OTHERSTEST2")
    '''
    if not contract:
        return Response(
            {"message": "no contract found"}, status=HTTP_400_BAD_REQUEST
        )

    response = init_chat(
    user, {"contract": contract, "message": [WELCOME_MESSAGE],}
    )
    '''
    logger.debug(f"create_user_instance_and_relations new chat data of tenantFFF A {user} OTHERSTEST2")
    '''
    if not response["success"]:
        logger.debug(f"create_user_instance_and_relations new chat data of tenantFFF A {response} OTHERSTEST2")
        #return Response(response, status=HTTP_400_BAD_REQUEST)
    '''
    #user_sessions = Session.objects.all().filter(user=user, is_customer_session=True)
    #logger.debug(f"create_user_instance_and_relations new chat data of tenantFFF {user_sessions} OTHERSTEST2")
    return user
