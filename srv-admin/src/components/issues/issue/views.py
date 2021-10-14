from functools import reduce

from django.db.models import Q
from rest_framework import viewsets, mixins
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from .models import Issue
from ..issue_answer.models import IssueAnswer

from src.integrations.gwg_tenant.user.models import Tenant

from src.components.docu_web.webservices.tickets import (
    build_get_ticketoverview_message_query,
    build_get_ticketoverview_message,
)

import logging

logger = logging.getLogger(__name__)


class IssueStatusViewSet(viewsets.ViewSet, mixins.ListModelMixin):
    permission_classes = (AllowAny,)

    '''
    def list(self, request):
        principal_id = request.user.principal_id
        logger.debug(f"UpdateAPIView tenantJJJ NEW {str(principal_id)}")
        #logger.debug(f"UpdateAPIView tenantJJJ NEW {str(self.request.user.first_name)}")
        #getTenant = Tenant.objects.all().filter(name_last=self.request.user.last_name,name_first=self.request.user.first_name).first()
        getTenant = Tenant.objects.all().filter(principal_id=principal_id).first()
        logger.debug(f"UpdateAPIView tenantJJJ TENATN {getTenant}")
        if getTenant!=None:
            datatickets123 = build_get_ticketoverview_message(build_get_ticketoverview_message_query("1000.99999.0001.01"))
            logger.debug(f"UpdateAPIView tenantJJJ TENATN FEEDBACK {datatickets123}")
        else:
            datatickets123 = {"data_user_parnterid": "no tenant in database","tickets": "","error": "no data in tenant database","success": "false",}
            logger.debug(f"UpdateAPIView tenantJJJ TENATN FEEDBACK {datatickets123}")
        return Response(datatickets123)
        '''

    def retrieve(self, request, pk):
        try:
            # logger.debug(f"retrieve(self, request, pk) FEEDBACK {request}")
            # logger.debug(f"retrieve(self, request, pk) FEEDBACK {pk}")
            new_partnerid = pk.replace("A", ".")
            # logger.debug(f"retrieve(self, request, pk) FEEDBACK {new_partnerid}")
            getTenant = new_partnerid  # Tenant.objects.all().filter(partnerid=new_partnerid).first()
            logger.debug(f"UpdateAPIView tenantJJJ TENATN {getTenant}")
            if getTenant != None:
                datatickets123 = build_get_ticketoverview_message(
                    build_get_ticketoverview_message_query(getTenant))  # getTenant.partnerid
                logger.debug(f"UpdateAPIView tenantJJJ TENATN FEEDBACK {datatickets123}")
            else:
                datatickets123 = {"data_user_parnterid": "no tenant in database", "tickets": "",
                                  "error": "no data in tenant database", "success": "false", }
                logger.debug(f"UpdateAPIView tenantJJJ TENATN FEEDBACK {datatickets123}")
            # queryset = self.request.user.contracts.get(id=pk)
            return Response(datatickets123)
        except Tenant.DoesNotExist:
            return Response(status=HTTP_404_NOT_FOUND)


class IssuesViewSet(viewsets.ViewSet):
    permission_classes = (AllowAny,)

    def list(self, request):
        formular_pdfs = []

        forms_sorted = self.get_forms()
        for dt in forms_sorted:
            # FIXME: create/use serializer
            data = {
                "id": dt.id,
                "group": dt.group,
                "display_location": dt.display_location,
                "title": dt.title,
                "visible_role": dt.visible_role,
                "requires_printing": dt.requires_printing,
                "requires_signature": dt.requires_signature,
                "signing_type": dt.signing_type,
                "answers": [],
                "description": dt.description,
                "type": dt.type,
                "category": dt.category,
                "description_postman": dt.description_postman,
            }

            rreasons = IssueAnswer.objects.filter(issue=dt).order_by("sorting")

            for reason in rreasons:
                answers = None
                if reason.answers:
                    answers = reason.answers.split(";")

                data["answers"].append(
                    {
                        "id": reason.id,
                        "question": reason.question,
                        "type": reason.type,
                        "multi": reason.multi,
                        "answers": answers,
                        "sorting": reason.sorting,
                        "marker": reason.marker,
                        "required": reason.required,
                    }
                )

            formular_pdfs.append(data)
        '''
        logger.debug(f"UpdateAPIView tenantJJJ NEW {str(self.request.user.first_name)}")
        getTenant = Tenant.objects.all().filter(name_last=self.request.user.last_name,name_first=self.request.user.first_name).first()
        logger.debug(f"UpdateAPIView tenantJJJ TENATN {getTenant}")
        if getTenant!=None:
            datatickets123 = build_get_ticketoverview_message(build_get_ticketoverview_message_query("1000.99999.0001.01"))
            logger.debug(f"UpdateAPIView tenantJJJ TENATN FEEDBACK {datatickets123}")
        else:
            datatickets123 = {"data_user_parnterid": "no tenant in database","tickets": "","error": "no data in tenant database","success": "false",}
            logger.debug(f"UpdateAPIView tenantJJJ TENATN FEEDBACK {datatickets123}")
        '''
        forms = reduce(self.group_by_reducer, formular_pdfs, {})
        return Response(forms)

    def group_by_reducer(self, acc, item):
        print(item)
        group = item["group"]
        try:
            acc[group].append(item)
        except:
            acc[group] = [item]
        return acc

    def get_forms(self):
        request = self.request
        f_objects = Issue.objects.order_by("sorting").order_by("group")
        location_filter = request.query_params.get("display-location", None)

        if location_filter:
            f_objects = f_objects.filter(display_location=location_filter)

        if request.user.is_anonymous:
            return f_objects.filter(visible_role=None)

        # FIXME: add group based filtering
        # if request.user.role != ROLE_TENANT_MEMBER[0]:
        #     return f_objects.filter(
        #         Q(visible_role=request.user.role) | Q(visible_role=ROLE_PUBLIC[0])
        #     )

        return f_objects.all()
