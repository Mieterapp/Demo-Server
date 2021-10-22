from src.integrations.gwg_tenant.user.utils import (
    build_get_indexes_query_dict_from_user,
)
from src.components.docu_web.indexes.get_indexes import (
    get_indexes,
)
import datetime
import logging

logger = logging.getLogger(__name__)


def get_all_documents(user):
    indexes = ["MIETVERTRAG", "BETRIEBSKOSTENA", "FREIGEGEBENE_DO", "MIETERAKTE", "MIETERAKTE"]
    response = []
    index_of_mieterakte = 0
    for index in indexes:

        normalized_reponse = get_indexes(
            index, build_get_indexes_query_dict_from_user(user), index_of_mieterakte
        )
        if index=="MIETERAKTE":
            index_of_mieterakte = 1
        if normalized_reponse["success"]:
            response.extend(normalized_reponse["data"]["documents"])
    logger.debug(f"UpdateAPIView tenantJJJ NEW {response}")
    if response != []:
        now = datetime.datetime.now()
        nowinyear = now.strftime("%Y-%m-%d")
        nowinyearssplit = nowinyear.split("-")
        nowinthreeyears = int(nowinyearssplit[0]) - 2
        alldatayears = str(nowinthreeyears) + "-" + nowinyearssplit[1] + "-" + nowinyearssplit[2]
        newdataresponse = []
        for indata in response:
            if indata.get("name") != "MIETVERTRAG":
                if indata.get("date") <= nowinyear:
                    if indata.get("date") >= alldatayears:
                        newdataresponse.append(indata)
            else:
                newdataresponse.append(indata)

        logger.debug(f"UpdateAPIView tenantJJJ NEW {newdataresponse}")

        return newdataresponse
    else:
        # logger.debug(f"UpdateAPIView tenantJJJ NEW {response}")
        return ["No Documents are found"]


def get_all_documents_contracts(user, code):
    indexes = ["MIETVERTRAG", "BETRIEBSKOSTENA", "FREIGEGEBENE_DO", "MIETERAKTE", "MIETERAKTE"]
    response = []
    index_of_mieterakte = 0
    for index in indexes:
        contract = user.contracts.filter(
            code=code
        ).first()
        logger.debug(f"UpdateAPIView tenantJJJ NEW contract BBB {user}")
        logger.debug(f"UpdateAPIView tenantJJJ NEW contract BBB {code}")
        logger.debug(f"UpdateAPIView tenantJJJ NEW contract BBB {contract}")
        if index=="MIETERAKTE":
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
            query = {
                "f2": "BUKRS",
                "f2_op": "=",
                "f2_val": contract.code[0:4] if contract else "",
                "f2_con": "AND",
                "f3": "RECNNR",
                "f3_op": "=",
                "f3_val": contract.code[-13:] if contract else "",
            }
        logger.debug(f"UpdateAPIView tenantJJJ NEW query {query}")
        normalized_reponse = get_indexes(
            index, query, index_of_mieterakte
        )
        if index=="MIETERAKTE":
            index_of_mieterakte = 1
        if normalized_reponse["success"]:
            response.extend(normalized_reponse["data"]["documents"])
    logger.debug(f"UpdateAPIView tenantJJJ NEW ALL {response}")
    if response != []:
        now = datetime.datetime.now()
        nowinyear = now.strftime("%Y-%m-%d")
        nowinyearssplit = nowinyear.split("-")
        nowinthreeyears = int(nowinyearssplit[0]) - 2
        alldatayears = str(nowinthreeyears) + "-" + nowinyearssplit[1] + "-" + nowinyearssplit[2]
        newdataresponse = []
        for indata in response:
            if indata.get("name") != "MIETVERTRAG":
                if indata.get("date") <= nowinyear:
                    if indata.get("date") >= alldatayears:
                        newdataresponse.append(indata)
            else:
                newdataresponse.append(indata)

        # logger.debug(f"UpdateAPIView tenantJJJ NEW {newdataresponse}")

        return newdataresponse
    else:
        # logger.debug(f"UpdateAPIView tenantJJJ NEW {response}")
        return ["No Documents are found"]
