from rest_framework import serializers

from src.components.docu_web.webservices.masterdata import (
    get_partner_ext_masterdata,
    normalize_get_partner_ext_masterdata,
)
from src.components.real_estate.contract.model import Contract


class ContactPersonSerializer:
    class Meta:
        data_request = get_partner_ext_masterdata
        data_normalizer = normalize_get_partner_ext_masterdata
        data_path = "data.contact_person"


class CustomerCenterSerialzer:
    class Meta:
        data_request = get_partner_ext_masterdata
        data_normalizer = normalize_get_partner_ext_masterdata
        data_path = "data.customer_center"

    contact_person = ContactPersonSerializer


class ContractDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = Contract
        fields = "__all__"

    customer_center = CustomerCenterSerialzer
    # customer_center = serializers.ExternalRessourceSerializer(adapter=get_partner_ext_masterdata, attributes='data.customer_center')
