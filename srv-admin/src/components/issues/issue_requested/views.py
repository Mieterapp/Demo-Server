import base64
import datetime
import time

from django.conf import settings
from django.contrib.auth import get_user_model
from django.contrib.sites.models import Site
from django.views.generic import TemplateView
from rest_framework import mixins, serializers, viewsets
from rest_framework.response import Response
from rest_framework.status import HTTP_201_CREATED, HTTP_400_BAD_REQUEST

from src.components.issues.settings import dit_issues_settings
from src.components.docu_web.webservices.tickets import (
    sendintern_get_ticket_process_fields_first_step_query,
)

from ..models import Issue, IssueRequested
from ..utils import render_form_to_pdf

import logging
logger = logging.getLogger(__name__)

issue_requested_create_handler = dit_issues_settings.ISSUE_REQUESTED_CREATE_HANDLER

UserModel = get_user_model()


class RequestedFormularPreview(TemplateView):
    template_name = "email_sm/formular.html"

    def get_context_data(self, **kwargs):
        context = super(RequestedFormularPreview, self).get_context_data(**kwargs)
        id = kwargs.get("id", None)
        rf = IssueRequested.objects.get(id=id)
        site = Site.objects.all().first().domain

        context[
            "header_image"
        ] = "%s://%s/static/imgs/email_sm/header_formulare.png" % (
            settings.API_PROTOCOL,
            site,
        )
        context["tenant"] = rf.tenant
        context["requested_formular"] = rf
        return context


# TODO: why HyperlinkedModelSerializer
class IssueRequestedSerializer(serializers.HyperlinkedModelSerializer):
    updated_at_unixtime = serializers.SerializerMethodField("get_timestamp")
    created_at_unixtime = serializers.SerializerMethodField("get_ctimestamp")
    issue = serializers.PrimaryKeyRelatedField(many=False, queryset=Issue.objects.all())

    def get_timestamp(self, obj):
        return int(time.mktime(obj.updated_at.timetuple()) * 1000)

    def get_ctimestamp(self, obj):
        return int(time.mktime(obj.created_at.timetuple()) * 1000)

    class Meta:
        model = IssueRequested
        fields = (
            "id",
            "created_at_unixtime",
            "issue",
            "created_at",
            "updated_at",
            "updated_at_unixtime",
            # "lang",
            "answers",
            # "sap_id",
            "status",
            # "sap_property",
            "code",
        )


class IssuesRequestedViewSet(
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    viewsets.GenericViewSet,
):

    queryset = IssueRequested.objects.all()
    serializer_class = IssueRequestedSerializer
    ts = time.time() - (3600 * 24 * 60)
    timeStr = datetime.datetime.fromtimestamp(ts).strftime("%Y-%m-%d %H:%M")

    def _get_updated_user(self, request):
        queryset = UserModel.objects.filter(username=request.user.username)

        # if hasattr(request, "sap_oauth_token"):
        #     refresh_user_data(request.sap_oauth_token, request.user.username, queryset)
        return queryset.first()

    def _get_contract_conditions(self, request):
        # if hasattr(request, "sap_oauth_token"):
        #     user = request.user
        #     if not user.sap_contract_id:
        #         return {}

        #     return transform_sap_contract_conditions_to_internal(
        #         get_contract_conditions(
        #             request.sap_oauth_token, user.username, user.sap_contract_id
        #         )
        #     )
        pass

    def get_queryset(self):
        # userId = self.request.user.username
        queryset = self.queryset.filter(
            user=self.request.user.id, created_at__gte=self.timeStr
        ).order_by("-created_at")

        # if hasattr(self.request, "sap_oauth_token"):
        #     response = request_sap_params_cloud_get(
        #         {},
        #         path=f"/tenant('{userId}')/notifications",
        #         auth=f"Bearer {self.request.sap_oauth_token}",
        #     )
        #     sap_ids = [msg["id"] for msg in response["d"]["results"]]

        #     return queryset.filter(sap_id__in=sap_ids)

        return queryset

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)

        if serializer.instance.issue.requires_signature:

            pdf = render_form_to_pdf(
                serializer.validated_data,
                context_data={
                    "tenant": self._get_updated_user(request),
                    "contract_conditions": self._get_contract_conditions(request),
                },
            )
            logger.debug(f"UpdateAPIView tenantJJJ TENATN FEEDBACK A {serializer.data}")
            dataintern = sendintern_get_ticket_process_fields_first_step_query(serializer.instance)
            logger.debug(f"UpdateAPIView tenantJJJ TENATN FEEDBACK B {dataintern}")
            return Response(
                {
                    "data": base64.b64encode(pdf),
                    "title": serializer.instance.formular.title,
                },
                status=HTTP_201_CREATED,
                headers=headers,
            )

        if callable(issue_requested_create_handler):
            response = issue_requested_create_handler(
                serializer, request, *args, **kwargs
            )
            if not response["success"]:
                return Response(
                    {"error": response["error"]}, status=HTTP_400_BAD_REQUEST
                )
        logger.debug(f"UpdateAPIView tenantJJJ TENATN FEEDBACK C {serializer.data}")
        dataintern = sendintern_get_ticket_process_fields_first_step_query(serializer.instance)
        logger.debug(f"sendintern_get_ticket_process_fields_first_step_query tenantJJJ TENATN FEEDBACK D {dataintern}")
        return Response(serializer.data, status=HTTP_201_CREATED, headers=headers)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
