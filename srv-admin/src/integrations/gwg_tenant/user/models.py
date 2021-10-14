from rest_framework import serializers
from django.db import models
from django.utils.translation import gettext_lazy as _
from rest_framework import viewsets
from rest_framework.generics import RetrieveAPIView, UpdateAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.serializers import ModelSerializer
from src.components.docu_web.api import api_post
import xmltodict
from src.components.authentication_local.models import (
    AuthenticationLocalAbstractUser,
    AuthenticationLocalManager,
)
# from src.components.real_estate.contract.model import Contract
# from src.components.docu_web.webservices.tickets import normalize_create_ticket_foruser


# from src.components.docu_web.webservices.tickets import (
#    create_ticket_foruser,
#    build_create_ticket_query_foruser,
# )

import logging

logger = logging.getLogger(__name__)


class TenantManager(models.Manager):
    def create_tenant(self, partnerid, **extra_fields):
        tenant = self.model(partnerid=partnerid, **extra_fields)
        tenant.save()
        return tenant


class Tenant(models.Model):
    objects = TenantManager()

    bukrs = models.CharField(max_length=4, verbose_name=_("Buchungskreis"))
    swenr = models.CharField(max_length=8, verbose_name=_("Wirtschaftseinheit"))
    sgenr = models.CharField(max_length=8, verbose_name=_("Gebäude"))
    smenr = models.CharField(max_length=8, verbose_name=_("Mieteinheit"))
    recnnr = models.CharField(max_length=13, verbose_name=_("Mietvertrag"))
    name_last = models.CharField(max_length=40, verbose_name=_("Nachname"))
    name_first = models.CharField(max_length=40, verbose_name=_("Vorname"))
    partnerid = models.CharField(
        max_length=23, primary_key=True, verbose_name=_("Partner ID")
    )
    phone = models.CharField(
        max_length=11, blank=True, null=True, verbose_name=_("Telefonnummer")
    )
    mobile = models.CharField(
        max_length=11, blank=True, null=True, verbose_name=_("Mobilnummer")
    )


class TenantSerializer(ModelSerializer):
    class Meta:
        model = Tenant
        exclude = []


class User(AuthenticationLocalAbstractUser):
    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []
    objects = AuthenticationLocalManager()


class UserSerializer(ModelSerializer):
    contracts = serializers.PrimaryKeyRelatedField(many=True, read_only=True)

    class Meta:
        model = User
        exclude = [
            "groups",
            "user_permissions",
            "password",
            "is_superuser",
            "is_staff",
            "is_verified",
            "is_active",
            "last_login",
            "date_joined",
            "is_data_accepted",
        ]

    def update(self, instance, validated_data):
        # TODO:
        # - [ ] fix update method
        logger.debug(f"UpdateAPIView tenantJJJA {validated_data}")
        logger.debug(f"UpdateAPIView tenantJJJB {instance}")

        oldUserQueryset = User.objects.filter(id=instance.id).first()
        logger.debug(f"UpdateAPIView tenantJJJC oldUserQueryset {oldUserQueryset}")
        if validated_data.get("email"):
            logger.debug(f"UpdateAPIView tenantJJJC oldUserQueryset EMAIL JA")
        if validated_data.get("email_contract"):
            test123 = validated_data.get("email_contract")
            logger.debug(f"UpdateAPIView tenantJJJC oldUserQueryset {test123}")
        else:
            logger.debug(f"UpdateAPIView tenantJJJC oldUserQueryset NO EMAIL CONTRACCT")
        datacontractcode = str(validated_data.get("code"))
        # datacontractcode = str(validated_data.get("principal_id")) # principal_id is here the code of the user
        # datanew = datacontractcode + "A" + "2000.10295.0009.01"
        '''
        datanew = str(validated_data.get("code"))
        datasplit = datanew.split("A")
        logger.debug(f"UpdateAPIView tenantJJJB {datasplit}")
        logger.debug(f"UpdateAPIView tenantJJJB {len(datasplit)}")
        for contracts in datasplit:
            logger.debug(f"UpdateAPIView tenantJJJB {contracts}")
            if oldUserQueryset.mobile != validated_data.get("mobile"):
                logger.debug(f"UpdateAPIView MOBILE tenantJJJD {oldUserQueryset.mobile}")
                dataforquery = {"TEXT_Neue_Handynumme": validated_data.get("mobile")}
                query = getquesry_foruser("Mieter App: Neue Handynummer", dataforquery, contracts)
                xml_response = api_post(path="/api/webservices/Tickets.cfc", query=query)
                endresponse = normalize_create_ticket_foruser(query,xml_response)
                logger.debug(f"UpdateAPIView tenantJJJ {endresponse}")

            if oldUserQueryset.phone != validated_data.get("phone"):
                logger.debug(f"UpdateAPIView PHONE tenantJJJE {oldUserQueryset.phone}")
                dataforquery = {"TEXT_Neue_Telefonnum": validated_data.get("phone")}
                query = getquesry_foruser("Mieter App: Neue Telefonnummer", dataforquery, contracts)
                xml_response = api_post(path="/api/webservices/Tickets.cfc", query=query)
                endresponse = normalize_create_ticket_foruser(query,xml_response)
                logger.debug(f"UpdateAPIView tenantJJJ {endresponse}")

            if oldUserQueryset.email_contract != validated_data.get("email_contract"):
                logger.debug(f"UpdateAPIView EMAIL tenantJJJF {oldUserQueryset.email_contract}")
                dataforquery = {"TEXT_Neue_E_Mail_Adr": validated_data.get("email_contract")}
                query = getquesry_foruser("Mieter App: Neue E-Mail-Adresse", dataforquery, contracts)
                xml_response = api_post(path="/api/webservices/Tickets.cfc", query=query)
                endresponse = normalize_create_ticket_foruser(query,xml_response)
        '''
        if validated_data.get("mobile"):
            logger.debug(f"UpdateAPIView MOBILE tenantJJJD {oldUserQueryset.mobile}")
            dataforquery = {"TEXT_Neue_Handynumme": validated_data.get("mobile")}
            query = getquesry_foruser("Mieter App: Neue Handynummer", dataforquery, datacontractcode)
            # query = getquesry_foruser("Mieter App: Neue Handynummer", dataforquery, "1000.99999.0001.01")
            xml_response = api_post(path="/api/webservices/Tickets.cfc", query=query)
            logger.debug(f"UpdateAPIView tenantJJJ {xml_response}")
            endresponse = normalize_create_ticket_foruser(query, xml_response)
            logger.debug(f"UpdateAPIView tenantJJJ {endresponse}")

        if validated_data.get("phone"):
            logger.debug(f"UpdateAPIView PHONE tenantJJJE {oldUserQueryset.phone}")
            dataforquery = {"TEXT_Neue_Telefonnum": validated_data.get("phone")}
            query = getquesry_foruser("Mieter App: Neue Telefonnummer", dataforquery, datacontractcode)
            # query = getquesry_foruser("Mieter App: Neue Telefonnummer", dataforquery, "1000.99999.0001.01")
            xml_response = api_post(path="/api/webservices/Tickets.cfc", query=query)
            endresponse = normalize_create_ticket_foruser(query, xml_response)
            logger.debug(f"UpdateAPIView tenantJJJ {endresponse}")

        if validated_data.get("email_contract"):
            logger.debug(f"UpdateAPIView EMAIL tenantJJJF {oldUserQueryset.email}")
            dataforquery = {"TEXT_Neue_E_Mail_Adr": validated_data.get("email_contract")}
            query = getquesry_foruser("Mieter App: Neue E-Mail-Adresse", dataforquery, datacontractcode)
            # query = getquesry_foruser("Mieter App: Neue E-Mail-Adresse", dataforquery, "1000.99999.0001.01")
            xml_response = api_post(path="/api/webservices/Tickets.cfc", query=query)
            endresponse = normalize_create_ticket_foruser(query, xml_response)

        # validated_data = {'email': oldUserQueryset.email, 'principal_id': validated_data.get("principal_id"), 'phone': validated_data.get("phone"), 'mobile': validated_data.get("mobile")}
        User.objects.filter(id=instance.id).update(**validated_data)
        return User.objects.filter(id=instance.id).first()


class AuthenticatedUserAPIView(viewsets.ViewSet, RetrieveAPIView, UpdateAPIView):
    permission_classes = (IsAuthenticated,)
    serializer_class = UserSerializer

    def get(self, request, format=None):
        logger.debug(f"AuthenticatedUserAPIView GET tenantJJJ {self.serializer_class(request.user).data}")
        return Response(self.serializer_class(request.user).data)

    def patch(self, request):
        user = request.user
        logger.debug(f"AuthenticatedUserAPIView PATCH tenantJJJ {request}")
        serializer = self.serializer_class(user, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            logger.debug(f"AuthenticatedUserAPIView PATCH tenantJJJ {serializer.data}")
            logger.debug(f"AuthenticatedUserAPIView PATCH tenantJJJ {user}")
            logger.debug(f"AuthenticatedUserAPIView PATCH tenantJJJ {Tenant.objects.all().first().partnerid}")
            # responseUserTicket = user_update_create_handler(serializer, request)
            return Response(serializer.data)

        return Response(serializer.errors)

    def delete(self, request):
        user = request.user
        user.delete()
        return Response({"message": "ok"})


def getquesry_foruser(keywordtypenew, descriptionofdata, prinzipalid):
    return {
        "method": "createTicket",
        "sSubject": "Aenderung Stammdaten",
        "sPartner": prinzipalid,
        "sKeyword": keywordtypenew,
        "sChannel": "APP_I",
        "sDescription": descriptionofdata,
    }


def normalize_create_ticket_foruser(query, response):
    parsed_xml = xmltodict.parse(response.content)
    response_raw = parsed_xml["wddxPacket"]["data"]["string"].split("|")
    sucess = response_raw[0] == "true"
    if not sucess:
        return {"data": {}, "error": response_raw[1], "success": False}
    return {
        "data": {
            "session": response_raw[2],  # Ticketnummer
        },
        "error": "",
        "success": sucess,
    }


'''
def user_update_create_handler(serializer, request, *args, **kwargs):
    contract = serializer.instance.user.contracts.first()
    if not contract:
        return {"success": False, "error": "User has no contracts"}

    response = create_ticket_user(
        build_create_ticket_user_query(
            {
                "user_update": serializer.instance,
                "issue": serializer.instance.issue,
                "contract": contract,
            }
        )
    )

    if response["success"]:
        logger.debug(response)
        # check here Stammdaten

    return Response(response)
'''
