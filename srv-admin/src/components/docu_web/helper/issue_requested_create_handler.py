import logging
from src.components.docu_web.webservices.tickets import (
    build_create_ticket_query,
    create_ticket,
)

logger = logging.getLogger(__name__)


def issue_requested_create_handler(serializer, request, *args, **kwargs):
    contract = serializer.instance.user.contracts.all().filter(code=serializer.instance.code).first()
    #logger.debug(f"issue_requested_create_handler FEEDBACK A {contract}")
    #logger.debug(f"issue_requested_create_handler FEEDBACK A {serializer.instance.answers}")
    if not contract:
        return {"success": False, "error": "User has no contracts"}

    response = create_ticket(
        build_create_ticket_query(
            {
                "issue_requested": serializer.instance,
                "issue": serializer.instance.issue,
                "contract": contract,
            }
        )
    )
    logger.debug(f"issue_requested_create_handler FEEDBACK A {response}")
    logger.debug(f"issue_requested_create_handler DATA A {str(serializer.instance)}")
    if response["success"]:
        requested_issue = serializer.instance
        requested_issue.code = response["data"]["issue_requested"]["code"]
        requested_issue.status = "ticket created"
        requested_issue.save()
    return response
