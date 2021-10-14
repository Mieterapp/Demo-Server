GET_PARTNER_ID = {
    "DATA": {"PARTNERID": "2050.10847.0135.02", "PARTNER": "0001051370"},
    "ERRORTEXT": "",
    "SUCCESS": True,
}


def GET_PARTNER_ID_NORMALIZED():
    return {
        "data": {
            "user": {
                "principal_id": "0001051370",
                "contract": "2050.10847.0135.02",
                "birthdate": "1958-04-19",
            },
        },
        "error": "",
        "success": True,
    }


def GET_PARTNER_ID_FAILURE():
    return {
        "DATA": {},
        "ERRORTEXT": "Der Partner existiert nicht.",
        "SUCCESS": False,
    }
