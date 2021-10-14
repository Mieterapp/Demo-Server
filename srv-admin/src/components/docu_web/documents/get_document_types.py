import xmltodict

from src.components.docu_web.api import api_get


def get_document_types():
    xml_response = api_get(path="/api/dokuweb/document-types/")

    return xmltodict.parse(str(xml_response))