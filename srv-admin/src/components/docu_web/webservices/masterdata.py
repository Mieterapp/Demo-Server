import functools
import json
import logging

from src.components.authentication_local.settings import al_settings
from src.components.docu_web.api import api_get
from src.components.docu_web.utils import load_xml_json_string

logger = logging.getLogger(__name__)


def get_partner_id(query=dict):
    query.update(
        {
            "method": "getPartnerId",
        }
    )

    xml_response = api_get(path="/api/webservices/Masterdata.cfc", query=query)

    return normalize_get_partner_id(query, **load_xml_json_string(xml_response))


def normalize_get_partner_id(query, **response):
    data = response["DATA"]
    error = response["ERRORTEXT"]
    success = response["SUCCESS"]
    if success == False:
        return {
            "data": {
                "user": {
                    "principal_id": "",
                    "contract": "",
                    # FIXME:
                    # - [ ] Birthdate required in doku_web response
                    "birthdate": json.loads(query["sParams"])["BIRTHDT"],
                },
            },
            "error": error,
            "success": success,
        }
    else:
        return {
            "data": {
                "user": {
                    "principal_id": data["PARTNER"],
                    "contract": data["PARTNERID"],
                    # FIXME:
                    # - [ ] Birthdate required in doku_web response
                    "birthdate": json.loads(query["sParams"])["BIRTHDT"],
                },
            },
            "error": error,
            "success": success,
        }


def build_get_partner_masterdata_query(user):
    return {"sPartnerid": user["contract"]}


def get_partner_masterdata(query=dict):
    """
    query: {"sPartnerid": "2050.10847.0135.02"}
    """
    query.update(
        {
            "method": "getPartnerMasterdata",
        }
    )

    xml_response = api_get(path="/api/webservices/Masterdata.cfc", query=query)

    return normalize_get_partner_masterdata(**load_xml_json_string(xml_response))


def normalize_get_partner_masterdata(**response):
    """

    INTERN                   | EXTERN           | DESCRIPTION
    Contract.building        | SGENR            | Gebäude(-einheit)
    Contract.city            | GE_CITY          | Gebäude-Ort
    Contract.city_district   | GE_CITY_DISTRICT | Gebäude-Ortsteil
    Contract.code            | PARTNERID        |
    Contract.number          | PARTNERID        | Mieter-ID/sPartnerid
    Contract.company_code    | BUKRS            | Buchungskreis
    Contract.date_from       | RECNBEG          | Vertragsbeginn
    Contract.date_to         | RECNENDABS       | Vertragsende
    Contract.economic_unit   | SWENR            | Wirtschaftseinheit
    Contract.is_active       | STATE            | Status TODO: Was ist der Feld typ
    Contract.rental_contract | RECNNR           | Mietvertrag
    Contract.rental_unit     | SMENR            | Mieteinheit/Mietobjekt
    Contract.street          | GE_STREET        | Gebäude-Straße
    # TODO: rename to house_number
    Contract.street_number   | GE_HOUSE_NUM     | Gebäude-Hausnummer
    Contract.zip_code        | GE_POST_CODE     | Gebäude-PLZ

    User.principal_id        | PARTNER          | Partner/sPartner
    User.first_name          | NAME_FIRST       | Vorname
    User.last_name           | NAME_LAST        | Nachname
    User.street              | STREET           | Partner-Straße
    User.street_number       | HOUSE_NUM        | Partner-Hausnummer
    User.zip_code            | POST_CODE        | Partner-PLZ
    User.city                | CITY1            | Partner-Ort
    User.phone               | TEL_NUMBER       | Telefonnummer
    User.mobile              | MOB_NUMBER       | Mobilnummer
    User.email               | SMTP_ADDR        | E-Mail-Adresse

    """
    data = response["DATA"]
    error = response["ERRORTEXT"]
    success = response["SUCCESS"]
    logger.debug(f"normalize_get_partner_masterdata MASTER NEW {str(data)}")
    logger.debug(f"normalize_get_partner_masterdata MASTER NEW {str(error)}")
    logger.debug(f"normalize_get_partner_masterdata MASTER NEW {str(success)}")
    return {
        "data": {
            "contract": {
                "building": data["SGENR"],
                "city": data["GE_CITY"],
                "city_district": data["GE_CITY_DISTRICT"],
                "code": data["PARTNERID"],
                "number": data["PARTNERID"],  # Put additionaly on number
                "company_code": data["BUKRS"],
                "date_from": data["RECNBEG"],
                "date_to": data["RECNENDABS"],
                "economic_unit": data["SWENR"],
                "is_active": True if data["STATE"] == "0_ACTIVE" else False,
                "rental_contract": data["RECNNR"],
                "rental_unit": data["SMENR"],
                "street": data["GE_STREET"],
                "street_number": data["GE_HOUSE_NUM"],
                "zip_code": data["GE_POST_CODE"],
            },
            "user": {
                "principal_id": data["PARTNER"],
                "groups": [
                    al_settings.TENANT_USER_GROUP_ID
                ],  # TODO: identifier required for dynamic evaluation
                "first_name": data["NAME_FIRST"],
                "last_name": data["NAME_LAST"],
                "street": data["STREET"],
                "street_number": data["HOUSE_NUM"],
                "zip_code": data["POST_CODE"],
                "city": data["CITY1"],
                "phone": data["TEL_NUMBER"],
                "mobile": data["MOB_NUMBER"],
                "email": data["SMTP_ADDR"],
            },
        },
        "error": error,
        "success": success,
    }


def build_get_partner_ext_masterdata_query(contract):
    return {"method": "getPartnerExtMasterdata", "sPartnerid": contract.code}


def get_partner_ext_masterdata(query=dict):
    """
    query: {"method": "getPartnerExtMasterdata", "sPartnerid": "2050.10847.0135.02"}
    """

    xml_response = api_get(path="/api/webservices/Masterdata.cfc", query=query)

    return normalize_get_partner_ext_masterdata(
        query, **load_xml_json_string(xml_response)
    )


def normalize_get_partner_ext_masterdata(query, **response):
    """
    TODO: [ ] MAPPING FREIGABE

    INTERN                              | EXTERN           | DESCRIPTION
    ====================================================================
    TODO: please specify internal meaning and variablename:
    Contract.condition.contract_balance | VERTRAGSSALDO    | Vertragssaldo TODO: What if we have multiple contracts?
    TODO: please specify internal meaning and variablename:
    Contract.condition.partner_balance  | PARTNERSALDO     | Partnersaldo  TODO: What if we have multiple contracts?

    CustomerCenter.name                 | GESCHAEFTSSTELLE | Geschäftsstelle
    CustomerCenter.street               | GS_STREET        | Geschäftsstelle Straße
    CustomerCenter.street_number        | GS_HOUSE_NUM     | Geschäftsstelle Hausnummer
    CustomerCenter.zip_code             | GS_POST_CODE     | Geschäftsstelle PLZ
    CustomerCenter.city                 | GS_CITY          | Geschäftsstelle Ort

    ContactPerson.display_name          | KUNDENBETREUER   | Kundenbetreuer Vorname Nachname
    ContactPerson.phone                 | KB_TEL_NUMBER    | Kundenbetreuer Telefonnummer
    ContactPerson.email                 | KB_SMTP_ADDR     | Kundenbetreuer E-Mail-Adresse
    ContactPerson.street                | KB_STREET        | Kundenbetreuer Straße
    ContactPerson.street_number         | KB_HOUSE_NUM     | Kundenbetreuer Hausnummer
    ContactPerson.zip_code              | KB_POST_CODE     | Kundenbetreuer PLZ
    ContactPerson.city                  | KB_CITY          | Kundenbetreuer Ort
    """
    data = response["DATA"]
    error = response["ERRORTEXT"]
    success = response["SUCCESS"]
    logger.debug(f"normalize_get_partner_ext_masterdata EMAIL NEW {str(data)}")
    logger.debug(f"normalize_get_partner_ext_masterdata EMAIL NEW {str(error)}")
    logger.debug(f"normalize_get_partner_ext_masterdata EMAIL NEW {str(success)}")
    if success == False:
        return {
            "data": {
                "contract": {
                    "code": query["sPartnerid"],
                    "condition": {
                        "contract_balance": "",
                        "partner_balance": "",
                    },
                },
                "customer_center": {
                    "name": "",
                    "street": "",
                    "street_number": "",
                    "zip_code": "",
                    "city": "",
                },
                "contact_person": {
                    "display_name": "",
                    "phone": "",
                    "email": "",
                    "street": "",
                    "street_number": "",
                    "zip_code": "",
                    "city": "",
                },
            },
            "error": error,
            "success": None,
        }
    else:
        return {
            "data": {
                "contract": {
                    "code": query["sPartnerid"],
                    "condition": {
                        "contract_balance": data["VERTRAGSSALDO"]*(-1),
                        "partner_balance": data["PARTNERSALDO"],
                    },
                },
                "customer_center": {
                    "name": data["GESCHAEFTSSTELLE"],
                    "street": data["GS_STREET"],
                    "street_number": data["GS_HOUSE_NUM"],
                    "zip_code": data["GS_POST_CODE"],
                    "city": data["GS_CITY"],
                },
                "contact_person": {
                    "display_name": data["KUNDENBETREUER"],
                    "phone": data["KB_TEL_NUMBER"],
                    "email": data["KB_SMTP_ADDR"],
                    "street": data["KB_STREET"],
                    "street_number": data["KB_HOUSE_NUM"],
                    "zip_code": data["KB_POST_CODE"],
                    "city": data["KB_CITY"],
                },
            },
            "error": error,
            "success": success,
        }


def build_get_partner_conditions_query(contract):
    logger.debug(f"build_get_partner_conditions_query contract.code: {contract.code}")
    return {"sPartnerid": contract.code}


def get_partner_conditions(query=dict):
    """
    query: {"sPartnerid": "2050.10847.0135.02"}
    """
    query.update(
        {
            "method": "getPartnerConditionsApp",
        }
    )

    xml_response = api_get(path="/api/webservices/Masterdata.cfc", query=query)

    return normalize_get_partner_conditions(query, **load_xml_json_string(xml_response))


def normalize_get_partner_conditions(query, **response):
    """
    TODO: [ ] MAPPING FREIGABE

    INTERN                                            | EXTERN          | DESCRIPTION
    ===================================================================================================
    Contract.condition.condition_lines[n].code        | CONDTYPE        | Condition id TODO: Missing docs in postman
    Contract.condition.condition_lines[n].name        | DISPLAY         | Anzeigentext TODO: Missing docs in postman
    Contract.condition.condition_lines[n].value       | VALUE           | Betrag TODO: Missing docs in postman
    Contract.condition.condition_lines[n].currency    | CURR            | Währung TODO: Missing docs in postman
    Contract.condition.condition_lines[n].value_netto | FIXME:          | Condition netto value
    Contract.condition.condition_lines[n].value_tax   | FIXME:          | Condition tax amount
    Contract.condition.condition_lines[n].tax_rate    | FIXME:          | Condition tax rate
    Contract.condition.total_pre                      | FIXME:          | Summe Vorauszahlungen
    Contract.condition.total_usage                    | FIXME:          | Summe Verbräuche
    Contract.condition.total                          | GESAMTMIETE     | TODO: Missing docs in postman
    Contract.condition.deposit                        | FIXME:          | Kaution
    Contract.condition.flat_size                      | WOHNUNGSGROESSE | Wohnungsgröße

    """
    data = response["DATA"]
    error = response["ERRORTEXT"]
    success = response["SUCCESS"]
    logger.debug(f"normalize_get_partner_conditions MASTER NEW {str(data)}")
    logger.debug(f"normalize_get_partner_conditions MASTER NEW {str(error)}")
    logger.debug(f"normalize_get_partner_conditions MASTER NEW {str(success)}")
    if success == False:
        return {
            "data": {
                "contract": {
                    "code": query["sPartnerid"],
                    "condition": {
                        "condition_lines": "No data",
                        "total_per": "",  # TODO: please specify
                        "total_usage": "",  # TODO: please specify
                        "total": "0",
                        "deposit": "",  # TODO: please specify
                        "flat_size": "0",
                        "prepayment_difference": "",  # TODO: please specify
                    },
                },
            },
            "error": error,
            "success": None,
        }
    else:
        return {
            "data": {
                "contract": {
                    "code": query["sPartnerid"],
                    "condition": {
                        "condition_lines": normalize_conditions(data),
                        "total_per": "",  # TODO: please specify
                        "total_usage": "",  # TODO: please specify
                        "total": data["GESAMTMIETE"],
                        "deposit": "",  # TODO: please specify
                        "flat_size": data["WOHNUNGSGROESSE"],
                        "prepayment_difference": "",  # TODO: please specify
                    },
                },
            },
            "error": error,
            "success": success,
        }


def normalize_conditions(data):
    conditions = data["CONDDATA"]["ROWS"]

    def reduce_conditions(acc, item):
        line_item = normalize_condition_line(item)
        acc.append(line_item)
        return acc

    return functools.reduce(reduce_conditions, conditions, [])


def normalize_condition_line(line):
    return {
        "code": line["CONDTYPE"],
        "name": line["DISPLAY"],
        "value": line["VALUE"],
        "currency": line["CURR"],
        "value_netto": "",  # TODO: please specify
        "value_tax": "",  # TODO: please specify
        "tax_rate": "",  # TODO: please specify
    }


def get_partner_contracts(query=dict):
    """
    query: {"sPartner": "0001051370"}
    """
    query.update(
        {
            "method": "getPartnerContracts",
        }
    )

    xml_response = api_get(path="/api/webservices/Masterdata.cfc", query=query)

    return normalize_get_partner_contracts(query, **load_xml_json_string(xml_response))


def normalize_get_partner_contracts(query, **response):
    """
    TODO: [ ] MAPPING FREIGABE

    INTERN                  | EXTERN      | DESCRIPTION
    ==============================================================
    Contract.code           | PARTNERID   | Mieter-ID/sPartnerid
    Contract.type_name      | VERTRAGSART | Vertragsart
    Contract.description    | VERTRAGSBEZ | Vertragsbezeichnung

    """
    data = response["DATA"]
    error = response["ERRORTEXT"]
    success = response["SUCCESS"]
    logger.debug(f"CONTRACTS ALL MASTER NEW {str(data)}")
    return {
        "data": {"contracts": normalize_contracts(data)},
        "error": error,
        "success": success,
    }


def normalize_contracts(data):
    rowcount = data["ROWCOUNT"]

    contracts = data["ROWS"]
    if int(rowcount)>1:
        newconstractsorder = []
        maincontractid = []
        othercontractid = []
        for allcontracs in contracts:
            if allcontracs["VERTRAGSART"]=="Mietvertrag Wohnung":
                maincontractid.append(allcontracs)
                logger.debug(f"CONTRACTS ALL MASTER NEW {str(maincontractid)}")
            else:
                othercontractid.append(allcontracs)
                logger.debug(f"CONTRACTS ALL MASTER NEW {type(othercontractid)}")
        contracts = maincontractid + othercontractid
        logger.debug(f"CONTRACTS ALL MASTER NEW {str(contracts)}")


    def reduce_conditions(acc, item):
        line_item = normalize_contract(item)
        acc.append(line_item)
        return acc

    return functools.reduce(reduce_conditions, contracts, [])


def normalize_contract(contract):
    return {
        "code": contract["PARTNERID"],
        "type_name": contract["VERTRAGSART"],
        "description": contract["VERTRAGSBEZ"],
    }
