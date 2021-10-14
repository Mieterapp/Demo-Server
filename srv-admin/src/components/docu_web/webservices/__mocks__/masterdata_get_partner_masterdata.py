GET_PARTNER_MASTERDATA = {
    "DATA": {
        "BUKRS": "2050",
        "CITY1": "Stuttgart",
        "GE_CITY": "Stuttgart",
        "GE_CITY_DISTRICT": "",
        "GE_HOUSE_NUM": "41",
        "GE_POST_CODE": "70376",
        "GE_STREET": "Rostocker Straße",
        "HOUSE_NUM": "20",
        "MOB_NUMBER": "015228706421",
        "NAME_FIRST": "Angelika",
        "NAME_LAST": "Ostrowski-Kicherer",
        "PARTNER": "0001051370",
        "PARTNERID": "2050.10847.0135.02",
        "POST_CODE": "70182",
        "RECNBEG": "2012-11-01",
        "RECNENDABS": "2018-04-30",
        "RECNNR": "10847.0135.02",
        "SGENR": "0017",
        "SMENR": "0135",
        "SMTP_ADDR": "a.ostrowski-kicherer@web.de",
        "STATE": "1_INACTIVE",
        "STREET": "Heusteigstraße",
        "SWENR": "10847",
        "TEL_NUMBER": "",
    },
    "ERRORTEXT": "",
    "SUCCESS": True,
}


# TODO: refactor all other global mocks to the same pattern.
def GET_PARTNER_MASTERDATA_NORMALIZED():
    return {
        "data": {
            "contract": {
                "building": "0017",
                "city": "Stuttgart",
                "city_district": "",
                "code": "2050.10847.0135.02",
                "number": "2050.10847.0135.02",
                "company_code": "2050",
                "date_from": "2012-11-01",
                "date_to": "2018-04-30",
                "economic_unit": "10847",
                "is_active": False,
                "rental_contract": "10847.0135.02",
                "rental_unit": "0135",
                "street": "Rostocker Straße",
                "street_number": "41",
                "zip_code": "70376",
            },
            "user": {
                "principal_id": "0001051370",
                "groups": [1],
                "first_name": "Angelika",
                "last_name": "Ostrowski-Kicherer",
                "street": "Heusteigstraße",
                "street_number": "20",
                "zip_code": "70182",
                "city": "Stuttgart",
                "phone": "",
                "mobile": "015228706421",
                "email": "a.ostrowski-kicherer@web.de",
            },
        },
        "error": "",
        "success": True,
    }


GET_PARTNER_MASTERDATA_FAILURE = {
    "DATA": {},
    "ERRORTEXT": "Der Partner (10847.0135.02) existiert nicht.",
    "SUCCESS": False,
}
