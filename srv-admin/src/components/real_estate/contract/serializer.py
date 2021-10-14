from src.components.real_estate.contract.model import Contract
from rest_framework import serializers


class ContractsListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Contract
        fields = "__all__"


class ContractDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = Contract
        fields = "__all__"
