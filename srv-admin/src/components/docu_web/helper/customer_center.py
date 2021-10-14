from src.components.docu_web.webservices.masterdata import (
    build_get_partner_ext_masterdata_query,
    get_partner_ext_masterdata,
)


def get_customer_center_by_contracts(contracts):
    customer_center_normalized = []
    for contract in contracts:
        masterdata_ext_normalized = get_partner_ext_masterdata(
            build_get_partner_ext_masterdata_query(contract)
        )
        if masterdata_ext_normalized["success"]:
            customer_center_normalized.append(masterdata_ext_normalized["data"])
        # TODO: add error handling
    return customer_center_normalized