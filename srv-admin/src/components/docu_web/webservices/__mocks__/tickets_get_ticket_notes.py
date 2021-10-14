from src.components.chat.session.constants import WELCOME_MESSAGE


GET_TICKET_NOTES = {
    "ANOTES": [
        {
            "CREATE_BY": "0064api_app_pro",
            "CREATE_ON": "17.12.2020 14:02:51",
            "NAME": "64-201216-Q0005, API GWG Mieterapp Prod",
            "NAME_RAW": "API GWG Mieterapp Prod",
            "NOTE": "Dies ist eine Notiz aus der App.",
            "NOTEID": "20201217140200031977",
            "TICKETGROUP": "API",
        },
        {
            "CREATE_BY": "0064api_app_pro",
            "CREATE_ON": "17.12.2020 09:39:44",
            "NAME": "64-201216-Q0005, API GWG Mieterapp Prod",
            "NAME_RAW": "API GWG Mieterapp Prod",
            "NOTE": "Dies ist eine Notiz aus der App.",
            "NOTEID": "20201217093900031956",
            "TICKETGROUP": "API",
        },
        {
            "CREATE_BY": "0064datasec",
            "CREATE_ON": "16.12.2020 19:31:38",
            "NAME": "64-201216-Q0005, Datasec Support",
            "NAME_RAW": "Datasec Support",
            "NOTE": "Dies ist ein Test!",
            "NOTEID": "20201216193100031937",
            "TICKETGROUP": "W_GS_STM_KB",
        },
        {
            "CREATE_BY": "0064api_app_pro",
            "CREATE_ON": "16.12.2020 19:28:18",
            "NAME": "64-201216-Q0005, API GWG Mieterapp Prod",
            "NAME_RAW": "API GWG Mieterapp Prod",
            "NOTE": "Hier müsste der initiale Text mitgegeben werden.",
            "NOTEID": "20201216192800031936",
            "TICKETGROUP": "",
        },
    ],
    "ERRORTEXT": "",
    "SUCCESS": True,
}


def GET_TICKET_NOTES_NORMALIZED():
    return {
        "data": {
            "session": {
                "code": "123",
                "messages": [
                    WELCOME_MESSAGE,
                    {
                        "_id": "20201216192800031936",
                        "text": "Hier müsste der initiale Text mitgegeben werden.",
                        "createdAt": "2020-12-16 19:28:18",
                        "user": {
                            "_id": "0064api_app_pro",
                            "name": "API GWG Mieterapp Prod",
                        },
                    },
                    {
                        "_id": "20201216193100031937",
                        "text": "Dies ist ein Test!",
                        "createdAt": "2020-12-16 19:31:38",
                        "user": {"_id": "0064datasec", "name": "Datasec Support"},
                    },
                    {
                        "_id": "20201217093900031956",
                        "text": "Dies ist eine Notiz aus der App.",
                        "createdAt": "2020-12-17 09:39:44",
                        "user": {
                            "_id": "0064api_app_pro",
                            "name": "API GWG Mieterapp Prod",
                        },
                    },
                    {
                        "_id": "20201217140200031977",
                        "text": "Dies ist eine Notiz aus der App.",
                        "createdAt": "2020-12-17 14:02:51",
                        "user": {
                            "_id": "0064api_app_pro",
                            "name": "API GWG Mieterapp Prod",
                        },
                    },
                ],
            }
        },
        "error": "",
        "success": True,
    }
