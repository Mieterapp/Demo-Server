GET_PARTNER_CONDITIONS = {
    "DATA": {
        "CONDDATA": {
            "COLUMNLIST": "CONDTYPE,CURR,DISPLAY,VALUE",
            "ROWCOUNT": "3",
            "ROWS": [
                {
                    "CONDTYPE": "1100 ",
                    "CURR": "EUR ",
                    "DISPLAY": "Grundmiete Wohnung ",
                    "VALUE": "654.000000 ",
                },
                {
                    "CONDTYPE": "2100 ",
                    "CURR": "EUR ",
                    "DISPLAY": "Betriebskosten ",
                    "VALUE": "85.000000 ",
                },
                {
                    "CONDTYPE": "2200 ",
                    "CURR": "EUR ",
                    "DISPLAY": "Heizkosten ",
                    "VALUE": "75.000000 ",
                },
            ],
        },
        "GESAMTMIETE": "3256",
        "WOHNUNGSGROESSE": "72,0000",
    },
    "ERRORTEXT": "",
    "SUCCESS": True,
}


def GET_PARTNER_CONDITIONS_NORMALIZED():
    return {
        "data": {
            "contract": {
                "code": "123.321",
                "condition": {
                    "condition_lines": [
                        {
                            "code": "1100 ",
                            "name": "Grundmiete Wohnung ",
                            "value": "654.000000 ",
                            "currency": "EUR ",
                            "value_netto": "",
                            "value_tax": "",
                            "tax_rate": "",
                        },
                        {
                            "code": "2100 ",
                            "name": "Betriebskosten ",
                            "value": "85.000000 ",
                            "currency": "EUR ",
                            "value_netto": "",
                            "value_tax": "",
                            "tax_rate": "",
                        },
                        {
                            "code": "2200 ",
                            "name": "Heizkosten ",
                            "value": "75.000000 ",
                            "currency": "EUR ",
                            "value_netto": "",
                            "value_tax": "",
                            "tax_rate": "",
                        },
                    ],
                    "total_per": "",
                    "total_usage": "",
                    "total": "3256",
                    "deposit": "",
                    "flat_size": "72,0000",
                    "prepayment_difference": "",
                },
            },
        },
        "error": "",
        "success": True,
    }