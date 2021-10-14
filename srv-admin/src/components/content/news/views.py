
from datetime import datetime
from logging import debug
from src.components.real_estate.properties.model import Property

from django.db.models import Q
from django.contrib.sites.models import Site
from rest_framework import viewsets
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from .model import News
from .serializer import NewsSerializer
import logging
logger = logging.getLogger(__name__)
from src.settings import django
import json
import environ

class NewsViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = (AllowAny,)
    queryset = News.objects.all()
    serializer_class = NewsSerializer
    #logger.debug(f"retrieve(self, request, pk) FEEDBACK {serializer_class}")

    def filter_queryset(self, queryset):
        user = self.request.user
        startdate = datetime.now()
        queryset = (
            super(NewsViewSet, self)
            .filter_queryset(queryset)
            .filter(
                (
                    (Q(date_from=None) & Q(date_to=None))
                    | (Q(date_from=None) & Q(date_to__gte=startdate))
                    | (Q(date_from__lte=startdate) & Q(date_to__gte=startdate))
                    | (Q(date_from__lte=startdate) & Q(date_to=None))
                )
            )
            .order_by("-order", "-id")
        )
        queryset2 = (
            super(NewsViewSet, self)
            .filter_queryset(queryset)
            .filter(
                (
                    (Q(date_from=None) & Q(date_to=None))
                    | (Q(date_from=None) & Q(date_to__gte=startdate))
                    | (Q(date_from__lte=startdate) & Q(date_to__gte=startdate))
                    | (Q(date_from__lte=startdate) & Q(date_to=None))
                )
            )
            .order_by("-order", "-id")
        ).values()
        list = queryset
        sList = []
        if len(list) > 0:
            varcounter = 0
            for vdata in list:
                if vdata.document:
                    urldocumentnew = "%s://%s/media/%s" % (
                        django.API_PROTOCOL,
                        Site.objects.all().first().domain,
                        vdata.document,
                    )
                else:
                    urldocumentnew = ""
                #logger.debug("NEWS DATA: QuerySet\n" + str(urldocumentnew))
                #logger.debug("NEWS DATA: QuerySet\n" + str(varcounter))
                #logger.debug("NEWS DATA: QuerySet" + str(queryset[varcounter].document))
                #logger.debug("NEWS DATA: QuerySet" + str(type(vdata.document)))
                #if varcounter==7:
                #    queryset.update(document=urldocumentnew)
                #logger.debug("NEWS DATA: QuerySet" + str(queryset2[varcounter].get("document")))
                templocationdata = {
                    "id": vdata.id,
                    "title": vdata.title,
                    "text": vdata.text,
                    "documents": urldocumentnew,
                    "href": vdata.href,
                    "kind":vdata.kind,
                    "show_in_header": vdata.show_in_header,
                    "date_from":vdata.date_from,
                    "date_to":vdata.date_to,
                    "order":vdata.order,
                }
                sList.append(templocationdata)
                varcounter=varcounter+1
            #logger.debug("NEWS DATA: QuerySet" + str(queryset[varcounter-1].document))
            #logger.debug("NEWS DATA: 12" + str(sList))

        if not user.is_anonymous:
            # TODO:
            # - [ ] check for contracts and filter for each contract.company_code
            # - [ ] make it configurable
            #
            # company_code = user.company_code
            queryset2 = json.dumps(sList)
            logger.debug("NEWS DATA: 12" + str(queryset2))
            return sList
            #return queryset.filter(
                # Q(property=None) | Q(property__company_code=company_code)
            #    Q(property=None)
            #)
        #     # if self.request.user.id and self.request.user.owner:
        #     #     queryset = queryset.exclude(visible_role="1")
        #     # else:
        #     #     queryset = queryset.exclude(visible_role="2")

        #     username = self.request.user.username

        #     # return queryset.filter(Q(visible_object='') | Q(visible_object__in=username)).order_by('title')
        #     # queryyy = queryset.extra(where=["visible_object= '' or %s LIKE CONCAT('',visible_object,'%%') "], params=[username]).order_by('title')
        #     ids = []

        #     for e in queryset.all():
        #         if e.visible_object:
        #             allowed = e.visible_object.split(";")
        #             for a in allowed:
        #                 for a in allowed:
        #                     if username.find(a.strip(), 0, len(a.strip())) != -1:
        #                         ids.append(e.id)
        #         else:
        #             ids.append(e.id)

        #     return queryset.filter(id__in=ids).order_by("-order", "-id")
        queryset2 = json.dumps(sList)
        logger.debug("NEWS DATA: 12" + str(queryset2))
        return sList
        #return queryset.filter(property=None)
