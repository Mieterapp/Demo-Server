from src.components.docu_web.mock_utils import MockResponse, get_xml_wrapped_json
from src.components.docu_web.utils import build_query_string, load_xml_json_string


def test_build_query_string():
    query = {
        "first": 123,
        "second": 456,
    }

    result = build_query_string(query)
    expected = "?first=123&second=456"

    assert result == expected


def test_load_xml_json_string():
    xml_response_mock = get_xml_wrapped_json({"test": "data"})
    response_parsed = load_xml_json_string(MockResponse(xml_response_mock))

    assert response_parsed == {"test": "data"}
