# POST_CREATE_TICKET = {
#     "DATA": {"TICKETID": "20201217140200013374", "TICKETNUMMER": "64-201217-Q0001"},
#     "ERRORTEXT": "",
#     "SUCCESS": True,
# }

POST_CREATE_TICKET = "true|20201217170500013375|64-201217-Q0001"


def POST_CREATE_TICKET_NORMALIZED():
    return {
        "data": {"issue_requested": {"code": "64-201217-Q0001"}},
        "error": "",
        "success": True,
    }


def POST_CREATE_CHAT_TICKET_NORMALIZED():
    return {
        "data": {"session": {"code": "64-201217-Q0001"}},
        "error": "",
        "success": True,
    }
