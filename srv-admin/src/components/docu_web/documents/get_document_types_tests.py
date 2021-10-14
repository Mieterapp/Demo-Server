import pytest

from src.components.docu_web.documents.get_document_types import get_document_types

document_types_response = """<?xml version="1.0"?>
<document-types>
    <document-type name="ALTAKTE" departments="Mieterakte"/>
    <document-type name="ALTAKTE_MG" departments="Mieterakte"/>
</document-types>"""


def test_get_document_types(mocker):
    m_api_get = mocker.patch(
        "src.components.docu_web.documents.get_document_types.api_get",
        return_value=document_types_response,
    )

    response = get_document_types()

    m_api_get.assert_called_with(path="/api/dokuweb/document-types/")

    assert response == {
        "document-types": {
            "document-type": [
                {"@name": "ALTAKTE", "@departments": "Mieterakte"},
                {"@name": "ALTAKTE_MG", "@departments": "Mieterakte"},
            ]
        }
    }
