from src.components.chat.session.model import Session
from src.components.docu_web.webservices.tickets import (
    build_create_chat_ticket_query,
    create_chat_ticket,
)
import logging
logger = logging.getLogger(__name__)

def init_chat(user, data):
    logger.debug(f"init_chat to_documents new data of tenantDDD DATA {data}")
    response_create_ticket = create_chat_ticket(build_create_chat_ticket_query(data))
    logger.debug(f"init_chat to_documents new data of tenantDDD RESPONSE {response_create_ticket}")
    if response_create_ticket["success"]:
        Session.objects.create(
            user=user, code=response_create_ticket["data"]["code"]
        )
    return response_create_ticket
