GET_PARTNER_EXT_MASTERDATA = {
    "DATA": {
        "GESCHAEFTSSTELLE": "GWG-Gruppe GS Stuttgart-Mitte",
        "GS_CITY": "Stuttgart",
        "GS_HOUSE_NUM": "3",
        "GS_POST_CODE": "70174",
        "GS_STREET": "Börsenstraße",
        "KB_CITY": "Stuttgart",
        "KB_HOUSE_NUM": "3",
        "KB_POST_CODE": "70174",
        "KB_SMTP_ADDR": "anissa.thiele@gwg-gruppe.de",
        "KB_STREET": "Börsenstraße",
        "KB_TEL_NUMBER": "071122777487",
        "KUNDENBETREUER": "Anissa Thiele",
        "PARTNERSALDO": "0,00",
        "VERTRAGSSALDO": "0,00",
    },
    "ERRORTEXT": "",
    "SUCCESS": True,
}


def GET_PARTNER_EXT_MASTERDATA_NORMALIZED():
    return {
        "data": {
            "contract": {
                "code": "123.321",
                "condition": {
                    "contract_balance": "0,00",
                    "partner_balance": "0,00",
                },
            },
            "customer_center": {
                "name": "GWG-Gruppe GS Stuttgart-Mitte",
                "street": "Börsenstraße",
                "street_number": "3",
                "zip_code": "70174",
                "city": "Stuttgart",
            },
            "contact_person": {
                "display_name": "Anissa Thiele",
                "phone": "071122777487",
                "email": "anissa.thiele@gwg-gruppe.de",
                "street": "Börsenstraße",
                "street_number": "3",
                "zip_code": "70174",
                "city": "Stuttgart",
            },
        },
        "error": "",
        "success": True,
    }