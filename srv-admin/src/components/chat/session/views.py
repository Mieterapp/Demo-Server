from django.utils.translation import gettext as _
from rest_framework import serializers
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.status import (
    HTTP_201_CREATED,
    HTTP_400_BAD_REQUEST,
)

from src.components.chat.session.constants import WELCOME_MESSAGE
from src.components.chat.session.model import Session
from src.components.docu_web.helper.init_chat import init_chat
from src.components.docu_web.webservices.tickets import (
    build_create_ticket_message_query,
    build_get_ticket_massages_query,
    create_ticket_message,
    get_chat_ticket_messages,
    build_set_ticket_massages_query,
    build_set_chat_ticket_messages,
)
import datetime
import logging
import django
import src
logger = logging.getLogger(__name__)

class SessionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Session
        fields = "__all__"

    messages = serializers.SerializerMethodField()

    def get_messages(self, obj):
        logger.debug(f" TYPE get_messages to_documents new data of TYPE tenantDDD 1  {type(obj)}")
        if type(obj)==src.components.chat.session.model.Session:
            logger.debug(f" TYPE get_messages to_documents new data of TYPE tenantDDD 2 {type(obj)} SESSION")
            if obj.code:
                logger.debug(f"get_messages to_documents new data of tenantDDD 3 {obj.code}")
                session = get_chat_ticket_messages(build_get_ticket_massages_query(obj))
                logger.debug(f"get_messages to_documents new data of tenantDDD 4 {session}")
                return session["data"]["session"]["messages"]
        elif type(obj)==django.db.models.query.QuerySet:
            logger.debug(f" TYPE get_messages to_documents new data of TYPE tenantDDD 5 {type(obj)} ObjectSet")
            logger.debug(f"get_messages to_documents new data of tenantDDD 6 {obj}")
            if not obj:
                logger.debug(f"get_messages to_documents new data of tenantDDD 7 {self} NO DATA")
                '''
                user = self.user
                contract = user.contracts.first()
                if not contract:
                    return Response(
                        {"message": "no contract found"}, status=HTTP_400_BAD_REQUEST
                    )

                response = init_chat(
                user, {"contract": contract, "message": [{'_id': 0, 'text': 'Willkommen! Hier können Sie Ihrem Kundenbetreuer eine Nachricht schreiben. Bitte beachten Sie: Um Ihre Anfrage zu Beantworten, benötigt Ihr Kundenbetreuer in der Regel ein wenig Zeit. Wir bitten um Ihr Verständnis, dass Ihre Anfrage nicht sofort bearbeitet werden kann.', 'createdAt': datetime.date.today(), 'user': {'_id': 0, 'name': 'GWG Kundenservice', 'avatar': 'https://facebook.github.io/react/img/logo_og.png'}}]}
                )
                #Session.objects.all().filter(code=obj[0].code).delete()
                logger.debug(f"get_document_file to_documents new data of tenantFFF {response}")
                if not response["success"]:
                    return Response(response, status=HTTP_400_BAD_REQUEST)

                return Response(session["data"]["session"]["messages"], status=HTTP_201_CREATED)
                '''
            else:
                session = get_chat_ticket_messages(build_get_ticket_massages_query(obj[0]))
                logger.debug(f"get_document_file to_documents new data of tenantDDD SESSION {session}")
                if len(session.get("error"))!=0:
                    errortext = session.get("error").split(" ")
                    logger.debug(f"get_messages to_documents new data of tenantDDD 8 {errortext}")
                    if (errortext[0]=="Ticket" and errortext[2]=="existiert" and errortext[3]=="nicht."):
                        logger.debug(f"get_messages to_documents new data of tenantDDD 9 {errortext[1]}")
                        user = obj[0].user
                        contract = user.contracts.first()
                        if not contract:
                            return Response(
                                {"message": "no contract found"}, status=HTTP_400_BAD_REQUEST
                            )

                        response = init_chat(
                        user, {"contract": contract, "message": [{'_id': 0, 'text': 'Willkommen! Hier können Sie Ihrem Kundenbetreuer eine Nachricht schreiben. Die Bearbeitung erfolgt innerhalb der Geschäftszeiten. Wir bitten um etwas Geduld.', 'createdAt': datetime.date.today(), 'user': {'_id': 0, 'name': 'GWG Kundenservice', 'avatar': 'https://facebook.github.io/react/img/logo_og.png'}}]}
                        )
                        #Session.objects.all().filter(code=obj[0].code).delete()
                        logger.debug(f"get_document_file to_documents new data of tenantFFF {response}")
                        if not response["success"]:
                            return Response(response, status=HTTP_400_BAD_REQUEST)

                        return Response(session["data"]["session"]["messages"], status=HTTP_201_CREATED) # session["data"]["session"]["messages"]
                    else:
                        #return session["data"]["messages"]
                        logger.debug(f"get_document_file to_documents new data of tenantFFF {session}")
                        return session["data"]["session"]["messages"]
                else:
                    return session["data"]["session"]["messages"]
        else:
            logger.debug(f" TYPE get_document_file to_documents new data of TYPE tenantDDD {type(obj)} OTHERS")
            return Response(
                {"message": "no valid chat found"}, status=HTTP_400_BAD_REQUEST
            )





def handle_get_customer_chat(request):
    user = request.user

    #try:
        #user_sessions = Session.objects.get(user=user, is_customer_session=True)
    user_sessions = Session.objects.all().filter(user=user, is_customer_session=True)
    if len(user_sessions)>1:
        user_sessions = Session.objects.all().filter(user=user, is_customer_session=True).last()
    logger.debug(f"get_document_file to_documents new data of tenantFFF {user_sessions} OTHER TESTS")
    if type(user_sessions)==django.db.models.query.QuerySet:
        if not user_sessions:
            return Response(
                {
                    "code": "__prestine__",
                    "messages": [WELCOME_MESSAGE],
                }
            )
            contract = user.contracts.first()
            if not contract:
                return Response(
                    {"message": "no contract found"}, status=HTTP_400_BAD_REQUEST
                )

            response = init_chat(
            user, {"contract": contract, "message": [WELCOME_MESSAGE],}
            )
            if not response["success"]:
                return Response(response, status=HTTP_400_BAD_REQUEST)
            logger.debug(f"get_document_file to_documents new data of tenantFFF {response} OTHERSTEST1")
            user_sessions = Session.objects.all().filter(user=user, is_customer_session=True)
            logger.debug(f"get_document_file to_documents new data of tenantFFF {user_sessions[0]} OTHERSTEST2")
            serializer = SessionSerializer(user_sessions[0])
            logger.debug(f"get_document_file to_documents new data of tenantFFF {serializer.data} OTHERSTEST3")
            return Response(serializer.data)
        else:
            serializer = SessionSerializer(user_sessions[0])
            return Response(serializer.data)
    else:
        serializer = SessionSerializer(user_sessions)
        return Response(serializer.data)
'''
    except Session.DoesNotExist:
        return Response(
            {
                "code": "__prestine__",
                "messages": [WELCOME_MESSAGE],
            }
        )
'''

class PostChatMessageSerializer(serializers.Serializer):
    message = serializers.CharField()


def handle_post_customer_chat(request):
    user = request.user
    serializer = PostChatMessageSerializer(data=request.data)

    if not serializer.is_valid():
        return Response(serializer.errors, status=HTTP_400_BAD_REQUEST)

    try:
        user_session = Session.objects.all().filter(user=user, is_customer_session=True)
        if len(user_session)>1:
            user_session = Session.objects.all().filter(user=user, is_customer_session=True).last()
        if len(user_session)==0:
            logger.debug(f"NO USER_SESSION AA {user_session}")
            contract = user.contracts.first()
            if not contract:
                return Response(
                    {"message": "no contract found"}, status=HTTP_400_BAD_REQUEST
                )

            response = init_chat(
            user, {"contract": contract, "message": serializer.data["message"]}
            )
            logger.debug(f"get_document_file to_documents new data of tenantFFF {response}")
            if not response["success"]:
                return Response(response, status=HTTP_400_BAD_REQUEST)

            user_session = Session.objects.all().filter(user=user, is_customer_session=True)
            if len(user_session)>1:
                user_session = Session.objects.all().filter(user=user, is_customer_session=True).last()
            if type(user_session)==django.db.models.query.QuerySet:
                serializer = SessionSerializer(user_session[0])
                #logger.debug(f"get_document_file to_documents new data of tenantDDD {response_create_ticket_message}")
                sendsession = build_set_chat_ticket_messages(build_set_ticket_massages_query(user_session[0]))
            else:
                serializer = SessionSerializer(user_session)
                #logger.debug(f"get_document_file to_documents new data of tenantDDD {response_create_ticket_message}")
                sendsession = build_set_chat_ticket_messages(build_set_ticket_massages_query(user_session))
            logger.debug(f"get_document_file to_documents new data of tenantFFF {serializer}")
            return Response(serializer.data, status=HTTP_201_CREATED)

        logger.debug(f"get_document_file to_documents new data of tenantDDD A {user_session}")
        logger.debug(f"get_document_file to_documents new data of tenantDDD B {type(user_session)}")
        if type(user_session)==django.db.models.query.QuerySet:
            logger.debug(f"get_document_file to_documents new data of tenantDDD C {user_session[0]}")
            response_create_ticket_message = create_ticket_message(
                build_create_ticket_message_query(
                    {
                        "message": serializer.data["message"],
                        "session": user_session[0],
                    }
                )
            )
        else:
            logger.debug(f"get_document_file to_documents new data of tenantDDD D {user_session}")
            response_create_ticket_message = create_ticket_message(
                build_create_ticket_message_query(
                    {
                        "message": serializer.data["message"],
                        "session": user_session,
                    }
                )
            )
        logger.debug(f"get_document_file to_documents new data of tenantDDD E {response_create_ticket_message}")
        errortext = response_create_ticket_message.get("error").split(" ")
        logger.debug(f"get_document_file to_documents new data of tenantDDD F {errortext}")
        if (errortext[0]=="Ticket" and errortext[2]=="existiert" and errortext[3]=="nicht."):
            logger.debug(f"get_document_file to_documents new data of tenantDDD G {errortext[1]}")

            contract = user.contracts.first()
            if not contract:
                return Response(
                    {"message": "no contract found"}, status=HTTP_400_BAD_REQUEST
                )

            response = init_chat(
            user, {"contract": contract, "message": serializer.data["message"]}
            )
            logger.debug(f"get_document_file to_documents new data of tenantFFF {response}")
            if not response["success"]:
                return Response(response, status=HTTP_400_BAD_REQUEST)

            if type(user_session)==django.db.models.query.QuerySet:
                serializer = SessionSerializer(user_session[0])
                #logger.debug(f"get_document_file to_documents new data of tenantDDD {response_create_ticket_message}")
                sendsession = build_set_chat_ticket_messages(build_set_ticket_massages_query(user_session[0]))
            else:
                serializer = SessionSerializer(user_session)
                #logger.debug(f"get_document_file to_documents new data of tenantDDD {response_create_ticket_message}")
                sendsession = build_set_chat_ticket_messages(build_set_ticket_massages_query(user_session))
            logger.debug(f"get_document_file to_documents new data of tenantFFF {serializer}")
            return Response(serializer.data, status=HTTP_201_CREATED)
        else:
            if not response_create_ticket_message["success"]:
                return Response(response_create_ticket_message, status=HTTP_400_BAD_REQUEST)

            if type(user_session)==django.db.models.query.QuerySet:
                serializer = SessionSerializer(user_session[0])
                #logger.debug(f"get_document_file to_documents new data of tenantDDD {response_create_ticket_message}")
                sendsession = build_set_chat_ticket_messages(build_set_ticket_massages_query(user_session[0]))
            else:
                serializer = SessionSerializer(user_session)
                #logger.debug(f"get_document_file to_documents new data of tenantDDD {response_create_ticket_message}")
                sendsession = build_set_chat_ticket_messages(build_set_ticket_massages_query(user_session))
            logger.debug(f"get_document_file to_documents new data of tenantFFF {serializer}")
            return Response(serializer.data, status=HTTP_201_CREATED)

    except Session.DoesNotExist:
        contract = user.contracts.first()
        if not contract:
            return Response(
                {"message": "no contract found"}, status=HTTP_400_BAD_REQUEST
            )

        response = init_chat(
            user, {"contract": contract, "message": serializer.data["message"]}
        )
        if response["success"]:
            return Response({"message": "message send"})
        return Response(response, status=HTTP_400_BAD_REQUEST)


@api_view(["GET", "POST"])
@permission_classes((IsAuthenticated,))
def customer_chat(request):
    if request.method == "GET":
        logger.debug(f"permission_classes customer_chat GET {request}")
        return handle_get_customer_chat(request)

    if request.method == "POST":
        logger.debug(f"permission_classes customer_chat POST {request}")
        return handle_post_customer_chat(request)
