import json
from collections import OrderedDict

import pytest

from src.components.docu_web.indexes.get_indexes import (
    get_indexes,
    normalize_get_indexes,
)


class MockResponse:
    def __init__(self, response_content):
        self.content = response_content


indexes_response = b"""<?xml version="1.0"?>
<documents start="1" total="3" max="3">
    <document collectid="00043CD6496D11E79950005056BF43">
        <page no="1">
            <index name="BELEGDATUM">2012-11-15</index>
            <index name="BETREFF">Vertragsausfertigungsgeb&#xfc;hr</index>
        </page>
    </document>
    <document collectid="7CE6CFD4497211E79950005056BF43">
        <page no="1">
            <index name="BELEGDATUM">2012-11-15</index>
            <index name="BETREFF">MIETVERTRAG</index>
        </page>
    </document>
    <document collectid="91E584B24C1D11E79950005056BF43">
        <page no="1">
            <index name="BELEGDATUM">2012-11-15</index>
            <index name="BETREFF">Zustimmung MEH</index>
        </page>
    </document>
</documents>"""

indexes_parsed_response = {
    "documents": {
        "@start": "1",
        "@total": "3",
        "@max": "3",
        "document": [
            {
                "@collectid": "00043CD6496D11E79950005056BF43",
                "page": {
                    "@no": "1",
                    "index": [
                        {"@name": "BELEGDATUM", "#text": "2012-11-15"},
                        {
                            "@name": "BETREFF",
                            "#text": "Vertragsausfertigungsgebühr",
                        },
                    ],
                },
            },
            {
                "@collectid": "7CE6CFD4497211E79950005056BF43",
                "page": {
                    "@no": "1",
                    "index": [
                        {"@name": "BELEGDATUM", "#text": "2012-11-15"},
                        {"@name": "BETREFF", "#text": "MIETVERTRAG"},
                    ],
                },
            },
            {
                "@collectid": "91E584B24C1D11E79950005056BF43",
                "page": {
                    "@no": "1",
                    "index": [
                        {"@name": "BELEGDATUM", "#text": "2012-11-15"},
                        {"@name": "BETREFF", "#text": "Zustimmung MEH"},
                    ],
                },
            },
        ],
    }
}


def test_get_indexes(mocker):
    m_api_get = mocker.patch(
        "src.components.docu_web.indexes.get_indexes.api_get",
        return_value=MockResponse(indexes_response),
    )

    index = "MIETVERTRAG"
    query = {}

    response = get_indexes(index=index, query=query)

    m_api_get.assert_called_with(path=f"/api/dokuweb/indexes/{index}", query=query)
    assert json.dumps(response) == json.dumps(indexes_parsed_response)


def test_normalize_get_indexes():
    parsed_xml_response = {
        "documents": {
            "@start": "1",
            "@total": "3",
            "@max": "3",
            "document": [
                {
                    "@collectid": "91E584B24C1D11E79950005056BF43",
                    "page": {
                        "@no": "1",
                        "index": [
                            {"@name": "BELEGDATUM", "#text": "2012-11-15"},
                            {"@name": "BETREFF", "#text": "Zustimmung MEH"},
                        ],
                    },
                }
            ],
        }
    }

    normalized_response = [
        {
            "id": "91E584B24C1D11E79950005056BF43",
            "name": "Zustimmung MEH",
            "date": "2012-11-15",
            "href": "/api/v1/documents/91E584B24C1D11E79950005056BF43/?type=MIETVERTRAG",
            "type": "contract",
        }
    ]

    assert (
        normalize_get_indexes(parsed_xml_response, doc_type="MIETVERTRAG")
        == normalized_response
    )
