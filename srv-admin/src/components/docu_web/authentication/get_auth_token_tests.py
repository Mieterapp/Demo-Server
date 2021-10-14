import pytest

from src.components.docu_web.authentication.get_auth_token import get_auth_token


def test_get_auth_token(mocker):
    """TEST COMMIT"""

    m_api_get = mocker.patch(
        "src.components.docu_web.authentication.get_auth_token.api_get",
        return_value="ABC",
    )
    token = get_auth_token(username="test", password="test")

    m_api_get.assert_called_with(
        path="/api/dokuweb/auth/token", headers={"Authorization": "Basic dGVzdDp0ZXN0"}
    )

    assert token == "ABC"