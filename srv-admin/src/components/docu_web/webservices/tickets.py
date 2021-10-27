import functools
from datetime import datetime
import json
import logging
from src.components.issues.issue_answer.models import IssueAnswer
from src.components.issues.constants import (
    AT_DATE,
    AT_MULTCHOICE,
    AT_MULTCHOICE_MULT,
    AT_TEXT,
    AT_TIME,
    AT_YESNO,
    AT_PHONE_NUMBER,
    AT_NUMBER,
    AT_CONTRACT_PARTNER,
)
from src.components.chat.session.constants import WELCOME_MESSAGE

import xmltodict

from src.components.docu_web.api import api_get, api_post
from src.components.docu_web.utils import load_xml_json_string, load_xml_json_string_ticket

logger = logging.getLogger(__name__)


def get_keywords():
    """
    query: {"sPartner": "0001051370"}
    """
    query = {
        "method": "getKeywords",
        "sChannel": "APP",
    }

    xml_response = api_get(path="/api/webservices/Tickets.cfc", query=query)

    return normalize_get_keywords(query, **load_xml_json_string(xml_response))


def normalize_get_keywords(query, **response):
    """
    normalizes doku web tickets to internal Issue

    TODO:
    - [ ] define full mapping
    - [ ] define import/update strategy

    INTERN             | EXTERN            | DESCRIPTION
    =========================================================
    Issue.group        |                   | Empfänger bei freien Tickets, sonst leer
    Issue.title        | KEYWORD           | Schlagwort/Anliegen
    Issue.code         | KEYWORD           | Ticketprozess bei Prozesstickets, "Freies Ticket" bei freien Tickets
    Issue.type         |                   | Tickettyp

    """
    data = response["DATA"]
    error = response["ERRORTEXT"]
    success = response["SUCCESS"]
    return {
        "data": {"issues": normalize_issues(data)},
        "error": error,
        "success": success,
    }


def normalize_issues(data):
    issues = data["ROWS"]

    def reduce_issues(acc, item):
        line_item = normalize_issue(item)
        acc.append(line_item)
        return acc

    return functools.reduce(reduce_issues, issues, [])


def normalize_issue(issue):
    return {
        "group": None,
        "code": issue["KEYWORD"],
        "title": issue["PROCESS"],
        "type": issue["TICKETTYPE"],
        "category": issue["CATEGORY"],
        "description_postman": issue["DESCRIPTION"],
    }


def build_get_ticket_process_fields_first_step_query(issue):
    return {
        "method": "getTicketProcessFieldsFirstStep",
        "sChannel": "APP",
        "sKeyword": issue.code,
    }

def sendintern_get_ticket_process_fields_first_step_query(issue):
    return {
        "method": "getTicketProcessFieldsFirstStep",
        "sChannel": "APP_I",
        "sKeyword": issue.code,
    }


def get_ticket_process_fields_first_step(query):
    xml_response = api_get(path="/api/webservices/Tickets.cfc", query=query)

    return normalize_get_ticket_process_fields_first_step(
        query, **load_xml_json_string(xml_response)
    )


def normalize_get_ticket_process_fields_first_step(query, **response):
    data = response["DATA"]
    if data==[]:
        return { "data": { "issue": {"description": "no data"}, "questions": [{'type': '1', 'question': 'no data', 'required': False, 'code': 'nodata'}]},"error": "no data", "success": False}
    error = response["ERRORTEXT"]
    success = response["SUCCESS"]
    return {
        "data": {
            "issue": {"description": data[0]["VALUE"]},
            "questions": normalize_issue_questions(data),
        },
        "error": error,
        "success": success,
    }


def normalize_issue_questions(data):
    def reduce_issue_question(acc, item):
        if item["TYPE"] == "label":
            return acc

        line_item = normalize_issue_question(item)
        acc.append(line_item)
        return acc

    return functools.reduce(reduce_issue_question, data, [])


def normalize_issue_question(item):
    issue_type = normalize_issue_type(item)

    if issue_type in [AT_MULTCHOICE[0], AT_MULTCHOICE_MULT[0]]:
        return {
            "type": issue_type,
            "question": item["LABEL"],
            "multi": True if issue_type == AT_MULTCHOICE_MULT[0] else False,
            "answers": normalize_issue_answers(item["PARAM1"]),
            "required": item["REQUIRED"],
            "code": item["FIELD"],
        }

    return {
        "type": issue_type,
        "question": item["LABEL"],
        "required": item["REQUIRED"],
        "code": item["FIELD"],
    }


def normalize_issue_answers(field):
    if type(field) == dict:
        return ";".join([i["KURZTEXT"].strip() for i in field["ROWS"]])
    return field


def normalize_issue_type(item):
    try:
        type_map = {
            "text": AT_TEXT[0],
            "date": AT_DATE[0],
            "time": AT_TIME[0],
            "checkbox": AT_YESNO[0],
            "sefcombo": AT_MULTCHOICE[0],
            "stdcombo": AT_MULTCHOICE[0],
            "telnumb": AT_PHONE_NUMBER[0],
            "number": AT_NUMBER[0],
            "contractpartner":AT_CONTRACT_PARTNER[0],
        }
        return type_map[item["TYPE"]]
    except:
        # add error logger
        return f"-1"


def build_field_values(answers):
    logger.debug(f"build_field_values {answers}")
    json_answers = json.loads(answers)


    def to_field_values(acc, item):
        try:
            issue_answer = IssueAnswer.objects.get(id=item)
            logger.debug(
                f"build_field_values issue_answer.id: {issue_answer.id} issue_answer.code: {issue_answer.code}"
            )
            if issue_answer.code.find("DATE_") != -1:
                raw_data_date = json_answers[item][:10]
                all_data_asgerman_date = raw_data_date.split("-")
                json_answers[item] = all_data_asgerman_date[2]+"."+all_data_asgerman_date[1]+"."+all_data_asgerman_date[0]
            if issue_answer.code.find("TIME_") != -1:
                json_answers[item] = json_answers[item][11:19]
            logger.debug(f"issue answer with this id: {json_answers[item]} ")
            logger.debug(f"issue answer with this id: {type(json_answers[item])} ")
            acc[issue_answer.code] = json_answers[item]
        except IssueAnswer.DoesNotExist:
            logger.error(f"issue answer with this id: {item} does not exist")
        except:
            logger.error(f"unknown error with issue_answer id: {item}")

        return acc

    return functools.reduce(to_field_values, json_answers.keys(), {})


def build_create_ticket_query(data):
    #testdata = data.get("issue_requested")
    #logger.error(f"build_create_ticket_query: {testdata.answers}")
    #if len(testdata.answers)!=0:
    logger.error(f"build_create_ticket_query: {type(data)}")
    logger.error(f"build_create_ticket_query: {data}")
    query = {
        "method": "createTicket",
        "sSubject": data["issue"].code,
        "sPartner": data["contract"].code,
        "sKeyword": data["issue"].code,
        "sChannel": "APP_I",
        "sFieldvalues": json.dumps(build_field_values(data["issue_requested"].answers))
        # "sDescription": "", # TODO: needs to be defined
    }

    return query


def create_ticket(query):
    xml_response = api_post(path="/api/webservices/Tickets.cfc", query=query)

    return normalize_create_ticket(query, xml_response)


def normalize_create_ticket(query, response):
    parsed_xml = xmltodict.parse(response.content)
    response_raw = parsed_xml["wddxPacket"]["data"]["string"].split("|")
    success = response_raw[0] == "true"
    if not success:
        return {"data": {}, "error": response_raw[1], "success": False}
    return {
        "data": {
            "issue_requested": {
                "code": response_raw[2],  # Ticketnummer
            }
        },
        "error": "",
        "success": success,
    }


def build_create_ticket_user_query(data):
    query = {
        "method": "createTicket",
        "sSubject": data["issue"].code,
        "sPartner": data["contract"].code,
        "sKeyword": data["issue"].code,
        "sChannel": "APP_I",
        "sFieldvalues": json.dumps(build_field_values(data["user_update"]))
        # "sDescription": "", # TODO: needs to be defined
    }
    logger.debug(f"build_create_ticket_user_query {query}")
    return query

def create_ticket_user(query):
    xml_response = api_post(path="/api/webservices/Tickets.cfc", query=query)

    return normalize_create_ticket_user(query, xml_response)


def normalize_create_ticket_user(query, response):
    parsed_xml = xmltodict.parse(response.content)
    response_raw = parsed_xml["wddxPacket"]["data"]["string"].split("|")
    success = response_raw[0] == "true"
    if not success:
        return {"data": {}, "error": response_raw[1], "success": False} #ERRORTEXT
    return {
        "data": {
            "update_user": {
                "code": response_raw[2],  # Ticketnummer
            }
        },
        "error": "",
        "success": success,
    }

def build_create_userdata_ticket_query(keywordtype, data, id):
    return {
        "method": "createTicket",
        "sSubject": "Aenderung Stammdaten",
        "sPartner": id,
        "sKeyword": keywordtype,
        "sChannel": "APP_I",
        "sDescription": data,
    }


def create_userdata_ticket(query):
    xml_response = api_post(path="/api/webservices/Tickets.cfc", query=query)
    return normalize_create_userdata_ticket(query, xml_response)


def normalize_create_userdata_ticket(query, response):
    parsed_xml = xmltodict.parse(response.content)
    response_raw = parsed_xml["wddxPacket"]["data"]["string"].split("|")
    success = response_raw[0] == "true"
    if not success:
        return {"data": {}, "error": response_raw[1], "success": False}
    return {
        "data": {
            "session": {
                "code": response_raw[2],  # Ticketnummer
            }
        },
        "error": "",
        "success": success,
    }



def build_create_chat_ticket_query(data):
    return {
        "method": "createTicket",
        "sSubject": "Chat",
        "sPartner": data["contract"].code,
        "sKeyword": "Chat", # "Chat",
        "sChannel": "APP_I",
        "sDescription": data["message"],
    }


def create_chat_ticket(query):
    """
    query: {
        "sSubject": "Chat",
        "sPartner": "2050.10847.0135.02",
        "sKeyword": "Chat",
        "sChannel": "APP",
        "sDescription": "Initial Text"
    }
    """

    xml_response = api_post(path="/api/webservices/Tickets.cfc", query=query)
    responsefeddback = normalize_create_chat_ticket(query, xml_response)
    logger.debug(f"get_document_file to_documents new data of tenantJJJ {responsefeddback}")
    return normalize_create_chat_ticket(query, xml_response)


def normalize_create_chat_ticket(query, response):
    parsed_xml = xmltodict.parse(response.content)
    response_raw = parsed_xml["wddxPacket"]["data"]["string"].split("|")
    success = response_raw[0] == "true"
    if not success:
        return {"data": {}, "error": response_raw[1], "success": False}
    return {
        "data": {
            "code": response_raw[2],
        },
        "error": "",
        "success": success,
    }


def build_create_ticket_message_query(data):
    return {
        "method": "addTicketNote",
        "sTicketnr": data["session"].code,
        "sNote": data["message"],
    }
'''
def build_get_ticketoverview_message_query(data):
    return {
        "f1_op": "=",
        "field_count": "1",
        "f1": "PARTNERID",
        "f1_val": data["session"].code, #get partnerid here
    }
    '''

def build_get_ticketoverview_message_query(data):
    return {
        "f1_op": "=",
        "field_count": "2",
        "f1": "PARTNERID",
        "f1_val": data, #data.partnerid, #get partnerid here
        "f1_con": "AND",
        "f2": "KEYWORD",
        "f2_op":"like",
        "f2_val": "Mieter App*",
    }

def build_get_ticketoverview_message(query, **response):
    xml_response = api_get(path="/api/dokuweb/tickets/", query=query)
    #logger.debug(f"get_document_file to_documents new data of tenantJJJ {xml_response}")
    firstTicketData = load_xml_json_string_ticket(xml_response)
    logger.debug(f"build_get_ticketoverview_message load_xml_json_string_ticket new data of tenantJJJ 1 {firstTicketData}")
    numbers = firstTicketData.get("tickets").get("total")
    logger.debug(f"build_get_ticketoverview_message load_xml_json_string_ticket new data of tenantJJJ 2 {numbers}")
    max=str(25)
    if int(numbers)>25:
        newnumber = str(int(numbers)-25)
    elif int(numbers)==0:
        newnumber=str(0)
        max=str(-1)
    else:
        newnumber = str(1)
    query2 = {
        "f1_op": "=",
        "field_count": "2",
        "f1":"PARTNERID",
        "f1_val": query["f1_val"],
        "max": max,
        "start": newnumber,
        "f1_con": "AND",
        "f2": "KEYWORD",
        "f2_op":"like",
        "f2_val": "Mieter App*",
    }
    logger.debug(f"build_get_ticketoverview_message load_xml_json_string_ticket new data of tenantJJJ 3 {query2}")
    xml_response_filter = api_get(path="/api/dokuweb/tickets/", query=query2)
    logger.debug(f"build_get_ticketoverview_message load_xml_json_string_ticket new data of tenantJJJ 3 {xml_response_filter}")
    return normalize_get_ticketoverview_messages(query, load_xml_json_string_ticket(xml_response_filter))
    #return normalize_get_ticketoverview_messages(query, **load_xml_json_string_ticket(xml_response))


def normalize_get_ticketoverview_messages(query, response):
    logger.debug("normalize_get_ticketoverview_messages")
    logger.debug(f"get_document_file to_documents new data of tenantJJJ {query}")
    logger.debug(f"get_document_file to_documents new data of tenantJJJ {response}")
    data = response.get("tickets").get("ticket")

    logger.debug(f"get_document_file to_documents new data of DATA tenantJJJ {data}")
    error = ""
    if data==[]:
        error = "no data of tickets"
    if data!=None:
        if type(data)!=dict:
            data.reverse()
        else:
            data=[data]
    else:
        error = "no tickets created yet"


    return {
        "data_user_parnterid": query["f1_val"],
        "tickets": data,
        "error": error,
        "success": "true",
    }

def create_ticket_message(query):
    xml_response = api_post(path="/api/webservices/Tickets.cfc", query=query)
    logger.debug(f"create_ticket_message CHAT POST {xml_response}")
    return normalize_create_ticket_message(query, **load_xml_json_string(xml_response))


def normalize_create_ticket_message(query, **response):
    error = response["ERRORTEXT"]
    success = response["SUCCESS"]
    return {"data": {}, "error": error, "success": success}


def build_get_ticket_massages_query(session):
    return {
        "method": "getTicketNotes",
        "sTicketnr": session.code
    }

def build_set_ticket_massages_query(session):
    return {
        "method": "setTicketState",
        "sTicketnr": session.code,
        "sNewState": "APP_CHAT_IN"
    }

def build_set_chat_ticket_messages(query, **response):

    xml_response = api_post(path="/api/webservices/Tickets.cfc", query=query)
    logger.debug(f"get_document_file to_documents new data of tenantJJJ {xml_response}")
    return normalize_build_set_chat_ticket_messages(
        query, xml_response
    )

def normalize_build_set_chat_ticket_messages(query, response):
    #error = response["ERRORTEXT"]
    response_data = {'response': response, 'status_code': response.status_code}
    logger.debug(f"get_document_file to_documents new data of tenantJJJ {response_data}")
    success = response.status_code
    if success!=200:
        return {"data": {}, "error": "no chat message is send to sub...", "success": False}
    return {
        "data": {
            "session": {
                "code": query["sTicketnr"],
            }
        },
        "error": "",
        "success": "true",
    }

def get_chat_ticket_messages(query, **response):
    """
    query: {
        "sSubject": "Chat",
        "sPartner": "2050.10847.0135.02",
        "sKeyword": "Chat",
        "sChannel": "APP",
        "sDescription": "Initial Text"
    }
    """

    xml_response = api_get(path="/api/webservices/Tickets.cfc", query=query)

    return normalize_get_chat_ticket_messages(
        query, **load_xml_json_string(xml_response)
    )


def normalize_get_chat_ticket_messages(query, **response):
    data = response["ANOTES"]
    error = response["ERRORTEXT"]
    success = response["SUCCESS"]
    return {
        "data": {
            "session": {
                "code": query["sTicketnr"],
                "messages": normalize_messages(data),
            }
        },
        "error": error,
        "success": success,
    }


def normalize_messages(messages):
    def reduce_messages(acc, item):
        if item.get("NOTE"):
            getitem = item.get("NOTE")
            logger.debug(f"normalize_messages reduce_messages FOUND DATA " + str(getitem))
            substringsearch="Willkommen! Hier können Sie Ihrem Kundenbetreuer eine Nachricht schreiben."
            if getitem.find(substringsearch) != -1:
                logger.debug(f"normalize_get_chat_ticket_messages to_documents new data of tenantJJJ FOUND")
            else:
                line_item = normalize_message(item)
                acc.append(line_item)
        return acc

    return functools.reduce(reduce_messages, messages[::-1], [WELCOME_MESSAGE])


def normalize_message(message):
    return {
        "_id": message["NOTEID"],
        "text": message["NOTE"],
        "createdAt": datetime.strptime(
            message["CREATE_ON"], "%d.%m.%Y %H:%M:%S"
        ).__str__(),
        "user": {"_id": message["CREATE_BY"], "name": message["NAME_RAW"]},
    }
