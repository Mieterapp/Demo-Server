from src.shared.utils.dict_helper import dict_deep_merge
from src.components.docu_web.helper.register import handle_register_user
from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_masterdata import (
    GET_PARTNER_MASTERDATA,
    GET_PARTNER_MASTERDATA_NORMALIZED,
)
from src.components.docu_web.webservices.__mocks__.masterdata_get_partner_id import (
    GET_PARTNER_ID,
    GET_PARTNER_ID_NORMALIZED,
)
import pytest

from src.components.docu_web.mock_utils import MockResponse, get_xml_wrapped_json


@pytest.mark.django_db
def test_register_user_valid_data_succeeds(mocker):
    m_get_partner_id = mocker.patch(
        "src.components.docu_web.helper.register.get_partner_id",
        return_value=GET_PARTNER_ID_NORMALIZED(),
    )
    m_get_partner_masterdata = mocker.patch(
        "src.components.docu_web.helper.register.get_partner_masterdata",
        return_value=GET_PARTNER_MASTERDATA_NORMALIZED(),
    )

    register_data = {
        "contract": "123",
        "birthdate": "1958-04-19",
    }

    response = handle_register_user("a@b.cd", "123", register_data)

    m_get_partner_id.assert_called()
    m_get_partner_masterdata.assert_called()

    assert response["user"].email == "a@b.cd"
