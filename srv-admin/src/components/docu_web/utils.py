import json
import logging
import re
import xmltodict

logger = logging.getLogger(__name__)


def build_query_string(query):
    query_string = ""

    for key, value in query.items():
        separator = "&" if query_string.find("?") == 0 else "?"
        query_string = f"{query_string}{separator}{key}={value}"

    return query_string


def load_xml_json_string(xml_response):
    logger.debug(xml_response.content)

    parsed_xml = xmltodict.parse(xml_response.content)
    return json.loads(parsed_xml["wddxPacket"]["data"]["string"])

def load_xml_json_string_ticket(xml_response):
    logger.debug(xml_response.content)
    parsed_xml = xmltodict.parse(xml_response.content)
    #logger.debug(f"load_xml_json_string_ticket tenantJJJ A")
    #logger.debug(parsed_xml)
    #logger.debug(f"load_xml_json_string_ticket tenantJJJ B")
    #logger.debug(dict(parsed_xml))
    data = dict(parsed_xml)
    for i in data:
        if "@" in i:
            data[i.replace("@", "")] = data.pop(i)
    #logger.debug(data)
    #logger.debug(re.sub("/","\/",json.dumps(data)))
    #logger.debug(f"load_xml_json_string_ticket tenantJJJ C")
    #logger.debug(json.loads(json.dumps(data)))
    #logger.debug(f"load_xml_json_string_ticket tenantJJJ D")
    #logger.debug(type(re.sub("@","",json.dumps(data))))
    #logger.debug(json.loads(json.dumps(parsed_xml)))
    #logger.debug(parsed_xml["tickets"]["ticket"])
    return json.loads(re.sub("@","",json.dumps(data)))
