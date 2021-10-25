import json
import logging
from functools import reduce

import xmltodict

from src.components.docu_web.api import api_get, api_get2

logger = logging.getLogger(__name__)



def get_indexes(index: str, query: dict, index_of_mieterakte: int):
    logger.debug(f"get_indexes to_documents getquery {index}")
    if index=="FREIGEGEBENE_DO":
        getquery = query
        logger.debug(f"get_indexes to_documents getquery {getquery}")
        query = {
                "field_count": 3,
                "f1": "BUKRS",
                "f1_op": "=",
                "f1_val":getquery.get("f2_val"),
                "f1_con":"AND",
                "f2": "RECNNR",
                "f2_op": "=",
                "f2_val": getquery.get("f3_val"),
                "f2_con":"AND",
                "f3": "APPANZEIGE",
                "f3_op": "=",
                "f3_val": "J",
            }
    elif index=="MIETERAKTE":
        getquery = query
        logger.debug(f"get_indexes to_documents getquery {getquery}")
        if index_of_mieterakte==0:
            query = {
                "field_count": 3,
                "f1": "BUKRS",
                "f1_op": "=",
                "f1_val": "0057",
                "f1_con": "AND",
                "f2": "MV",
                "f2_op": "=",
                "f2_val": "0242.00004.22",
                "f2_con": "AND",
                "f3": "REPOSITORY",
                "f3_op": "=",
                "f3_val": "R01_09_01",
                "f3_con": "AND",
            }
        elif index_of_mieterakte==1:
            query = {
                "field_count": 3,
                "f1": "BUKRS",
                "f1_op": "=",
                "f1_val": "0057",
                "f1_con": "AND",
                "f2": "MV",
                "f2_op": "=",
                "f2_val": "0242.00004.22",
                "f2_con": "AND",
                "f3": "REPOSITORY",
                "f3_op": "=",
                "f3_val": "R01_00_01",
                "f3_con": "AND",
            }
        else:
            query = {
                "field_count": 3,
                "f1": "BUKRS",
                "f1_op": "=",
                "f1_val": "0057",
                "f1_con": "AND",
                "f2": "MV",
                "f2_op": "=",
                "f2_val": "0242.00004.22",
                "f2_con": "AND",
                "f3": "REPOSITORY",
                "f3_op": "=",
                "f3_val": "R01_05_01",
                "f3_con": "AND",
            }
    else:
        query.update(
            {
                "field_count": 3,
                "f1": "APPANZEIGE",
                "f1_op": "=",
                "f1_val": "J",
                "f1_con": "AND",
            }
        )
    logger.debug(f"get_indexes to_documents {query}")
    xml_response = api_get2(path=f"/api/dokuweb/indexes/{index}/", query=query)
    logger.debug(f"get_indexes to_documents {xml_response}")
    if not xml_response.status_code == 200:
        logger.debug(f"get_indexes to_documents {xml_response}")
        return {"error": xml_response.content, "success": False}

    if xml_response.status_code == 400:
        logger.debug(f"get_indexes to_documents {xml_response}")
        return {"error": xml_response.content, "success": False}

    if xml_response.status_code == 404:
        logger.debug(f"get_indexes to_documents {xml_response}")
        return {"error": xml_response.content, "success": False}

    return normalize_get_indexes(xmltodict.parse(xml_response.content), index, index_of_mieterakte)


def normalize_document(doc):
    return


def get_attribute_from_index(index, attr):
    for item in index:
        logger.debug(f"normalize_get_indexes {item}")
        if item["@name"] == attr:
            if len(item)>1:
                return item["#text"]
            else:
                return "9999-99-99"


def get_href(id: str, type: str):
    #return f"/api/v1/documents/detail/{id}/?type={type}"
    return f"/api/v1/documents/{id}/?type={type}"


def get_doc_type(doc_type: str, index_of_mieterakte: int):
    if doc_type == "MIETVERTRAG":
        return "contract"
    if doc_type == "BETRIEBSKOSTENA":
        return "operating_costs"
    if doc_type == "FREIGEGEBENE_DO":
        return "issues"
    if doc_type == "MIETERAKTE":
        if index_of_mieterakte==0:
            return "issues"
        elif index_of_mieterakte==1:
            return "contract"
        else:
            return "operating_costs"


def normalize_get_indexes(response, doc_type: str, index_of_mieterakte: int):
    documents = response["documents"]["document"]
    logger.debug(f"normalize_get_indexes {json.dumps(response)}")

    def to_documents(acc, item):
        logger.debug(f"normalize_get_indexes to_documents {item}")
        id = item["@collectid"]

        item = {
            "id": id,
            "name": get_attribute_from_index(item["page"]["index"], "BETREFF"),
            "date": get_attribute_from_index(item["page"]["index"], "BELEGDATUM"),
            "href": get_href(id, doc_type),
            "type": get_doc_type(doc_type, index_of_mieterakte),
        }
        acc.append(item)
        return acc

    return {
        "data": {
            "documents": reduce(
                to_documents,
                documents if isinstance(documents, list) else [documents],
                [],
            )
        },
        "error": "",
        "success": True,
    }
