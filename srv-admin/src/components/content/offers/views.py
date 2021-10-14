import datetime

from django.db.models import Q
from rest_framework import viewsets
from rest_framework.permissions import AllowAny

from src.components.content.offers.models import Offer
from src.components.content.offers.serializer import OfferSerializer
from src.components.content.utils import get_filtered_by_object_id

import logging
logger = logging.getLogger(__name__)
from src.settings import django
from django.contrib.sites.models import Site
import json

class OfferViewSet(viewsets.ReadOnlyModelViewSet):

    permission_classes = (AllowAny,)
    queryset = Offer.objects.filter(hidden=False, only_guest=True)
    serializer_class = OfferSerializer

    def filter_queryset(self, queryset):
        startdate = datetime.datetime.now()
        queryset = (
            super(OfferViewSet, self)
            .filter_queryset(queryset)
            .filter(
                (
                    (Q(date_from=None) & Q(date_to=None))
                    | (Q(date_from=None) & Q(date_to__gte=startdate))
                    | (Q(date_from__lte=startdate) & Q(date_to__gte=startdate))
                    | (Q(date_from__lte=startdate) & Q(date_to=None))
                )
            )
        ).order_by("sorting")
        list = queryset
        sList = []
        if len(list) > 0:
            varcounter = 0
            for vdata in list:
                if vdata.icon:
                    urliconnew = "%s://%s/media/%s" % (
                        django.API_PROTOCOL,
                        Site.objects.all().first().domain,
                        vdata.icon,
                    )
                else:
                    urliconnew = ""
                logger.debug("OfferViewSet DATA: QuerySet\n" + str(urliconnew))
                logger.debug("OfferViewSet DATA: QuerySet\n" + str(varcounter))
                logger.debug("OfferViewSet DATA: QuerySet" + str(queryset[varcounter].icon))
                logger.debug("OfferViewSet DATA: QuerySet" + str(type(vdata.icon)))
                templocationdata = {
                    "id": vdata.id,
                    "title": vdata.title,
                    "text": vdata.text,
                    "website": vdata.website,
                    "icons": urliconnew,
                    "visible_role":vdata.visible_role,
                }
                sList.append(templocationdata)
                varcounter=varcounter+1
            logger.debug("OfferViewSet DATA: QuerySet" + str(queryset[varcounter-1].icon))
            logger.debug("OfferViewSet DATA: 12" + str(sList))
        if self.request.user.is_anonymous:
            return sList
            #return queryset.filter(visible_role=None)

        if len(self.request.user.groups.all()) >= 1:
            group_ids = [g.id for g in self.request.user.groups.all()]
            queryset = queryset.filter(visible_role__in=group_ids)
            logger.debug("OfferViewSet DATA: 12" + str(queryset))

        return sList
        #return queryset.order_by("sorting")
