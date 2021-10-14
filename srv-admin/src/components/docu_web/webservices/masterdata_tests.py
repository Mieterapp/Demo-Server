import json
from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_id import (
    GET_PARTNER_ID,
    GET_PARTNER_ID_NORMALIZED,
)
from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_contracts import (
    GET_PARTNER_CONTRACTS,
)
from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_conditions import (
    GET_PARTNER_CONDITIONS,
    GET_PARTNER_CONDITIONS_NORMALIZED,
)
from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_ext_masterdata import (
    GET_PARTNER_EXT_MASTERDATA,
)
from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_masterdata import (
    GET_PARTNER_MASTERDATA,
    GET_PARTNER_MASTERDATA_NORMALIZED,
)

from src.components.docu_web.mock_utils import MockResponse, get_xml_wrapped_json

from .masterdata import (
    get_partner_conditions,
    get_partner_contracts,
    get_partner_ext_masterdata,
    get_partner_id,
    get_partner_masterdata,
)


def test_get_partner_id(mocker):
    m_api_get = mocker.patch(
        "src.components.docu_web.webservices.masterdata.api_get",
        return_value=MockResponse(get_xml_wrapped_json(GET_PARTNER_ID)),
    )

    query = {"method": "getPartnerId", "sParams": json.dumps({"BIRTHDT": "1958-04-19"})}

    response = get_partner_id(query=query)

    m_api_get.assert_called_with(
        path="/api/webservices/Masterdata.cfc",
        query=query,
    )
    assert response == GET_PARTNER_ID_NORMALIZED()


def test_get_partner_masterdata(mocker):
    m_api_get = mocker.patch(
        "src.components.docu_web.webservices.masterdata.api_get",
        return_value=MockResponse(get_xml_wrapped_json(dict(GET_PARTNER_MASTERDATA))),
    )

    query = {"method": "getPartnerMasterdata"}

    response = get_partner_masterdata(query=query)

    m_api_get.assert_called_with(
        path="/api/webservices/Masterdata.cfc",
        query=query,
    )
    assert response == GET_PARTNER_MASTERDATA_NORMALIZED()


def test_get_partner_ext_masterdata(mocker):
    m_api_get = mocker.patch(
        "src.components.docu_web.webservices.masterdata.api_get",
        return_value=MockResponse(get_xml_wrapped_json(GET_PARTNER_EXT_MASTERDATA)),
    )

    query = {"method": "getPartnerExtMasterdata", "sPartnerid": "123.321"}

    response = get_partner_ext_masterdata(query=query)

    m_api_get.assert_called_with(
        path="/api/webservices/Masterdata.cfc",
        query=query,
    )
    assert response == {
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


def test_get_partner_conditions(mocker):
    m_api_get = mocker.patch(
        "src.components.docu_web.webservices.masterdata.api_get",
        return_value=MockResponse(get_xml_wrapped_json(GET_PARTNER_CONDITIONS)),
    )

    query = {"method": "getPartnerConditionsApp", "sPartnerid": "123.321"}

    response = get_partner_conditions(query=query)

    m_api_get.assert_called_with(
        path="/api/webservices/Masterdata.cfc",
        query=query,
    )
    assert response == GET_PARTNER_CONDITIONS_NORMALIZED()


def test_get_partner_contracts(mocker):
    m_api_get = mocker.patch(
        "src.components.docu_web.webservices.masterdata.api_get",
        return_value=MockResponse(get_xml_wrapped_json(GET_PARTNER_CONTRACTS)),
    )

    query = {"method": "getPartnerContracts", "sPartner": "123456"}

    response = get_partner_contracts(query=query)

    m_api_get.assert_called_with(
        path="/api/webservices/Masterdata.cfc",
        query=query,
    )
    assert response == {
        "data": {
            "contracts": [
                {
                    "code": "2000.10171.0610.01",
                    "type_name": "Mietvertrag Garage\/Stellplatz",
                    "description": "Birgül Yazici \/ Leinf.-Echterdingen, Esslinger Str. 3",
                },
                {
                    "code": "2000.10171.0026.04",
                    "type_name": "Mietvertrag Wohnung",
                    "description": "Birgül Yazici \/ Leinf.-Echterdingen, Esslinger Str. 3\/1",
                },
                {
                    "code": "2000.10171.0028.05",
                    "type_name": "Mietvertrag Wohnung",
                    "description": "Birgül Yazici-Esslinger Straße 3\/1-3. Obergeschoss rechts",
                },
            ],
        },
        "error": "",
        "success": True,
    }