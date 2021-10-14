import json
from datetime import datetime

import pdfkit
from .constants import (
    AT_CONTRACT_PARTNER,
    AT_DATE,
    AT_MULTCHOICE,
    AT_MULTCHOICE_MULT,
    AT_NUMBER,
    AT_PHONE_NUMBER,
    AT_TEXT,
    AT_TIME,
    AT_YESNO,
)
from .models import IssueAnswer
from django.core.mail import EmailMessage
from django.template import Context, Template

from django.conf import settings


def render_to_string(tmpl, context):
    t = Template(tmpl)
    return t.render(Context(context))


# def get_contact_person(tenant):
#     # TODO: configurable role_sqp
#     cp = tenant.contact_persons.filter(role_sqp="ZCL206").first()

#     if cp:
#         return cp

#     return ContactPerson(**{
#         "name": "MISSING CONTACT PERSON",
#         "address": "MISSING CONTACT PERSON",
#         "postal_code": "MISSING CONTACT PERSON",
#         "city": "MISSING CONTACT PERSON",
#     })


def get_today():
    return datetime.now().strftime("%d.%m.%Y")


def get_static_context(context):
    tenant = context["tenant"]
    contract_conditions = context["contract_conditions"]

    # cp = get_contact_person(tenant)

    context = {
        "date": get_today(),
        # "bp_reference_number": tenant.sap_contract_id if tenant.role in [ROLE_TENANT[0], ROLE_TENANT_MEMBER[0]] else tenant.sap_member_id,
        # "cp_name": cp.name,
        # "cp_address": cp.address,
        # "cp_postal_code": cp.postal_code,
        # "cp_city": cp.city,
        # "cp_phone": cp.phone,
        # "cp_email": cp.email,
        # "cp_fax": cp.fax,
        "cp_lead_management": "TODO: add me please",
        # /nl/tenant('<userId>')
        "username": tenant.username,  # userId
        "birthday": tenant.birthday,  # dateOfBirthDate
        "phone": tenant.sap_mob_number1,  # phoneIso
        "sap_mob_number1": tenant.sap_mob_number1,  # DEPRECATED
        "mobile": tenant.sap_mob_number1,
        "email": tenant.email,
        "address": tenant.address,  # DEPRECATED use tenant_address
        "intreno": tenant.intreno,
        "mieter1": tenant.mieter1,
        "MIETER1": tenant.mieter1,
        "mieter2": tenant.mieter2,
        "MIETER2": tenant.mieter2,
        "salutation": tenant.salutation,  # titleName
        "first_name": tenant.first_name,
        "FIRST_NAME": tenant.first_name,
        "last_name": tenant.last_name,
        "LAST_NAME": tenant.last_name,
        "contract_id": tenant.sap_contract_id,
        # getContractsForTentant => "number": "0748-0-006-06",
        "tenant_object_number": tenant.property.id if tenant.property else "",
        "tenant_address": tenant.address,
        "tenant_postal_code": tenant.postal_code,
        "tenant_city": tenant.city,
        "member_business_credit": "TODO: Tatsächliches Geschäftsguthaben (in Euro)",
        "member_number_registered_shares": "TODO: Anzahl der eingetragenen Anteile",
        "member_value_registered_shares": "TODO: Wert der eingetragenen Anteile",
        "member_count_cancellable_shares": "TODO: Kündbare Anteile/freiwillige Anteile (in Stück)",
        "member_account_numer_last_three": "TODO: Wahlbezirk Bankverbindung Mitglied (*** nur die letzten 3 Ziffern klar)",
        "member_is_resigned": "TODO: Abtretung (Text „Abtretungserklärung vorhanden“, wenn in SAP gültig)",
        # getRentForContract
        "rental_base_fee": contract_conditions["rental_base_fee"],
        "pre_payment_operation": contract_conditions["pre_payment_operation"],
        "pre_payment_heating": contract_conditions["pre_payment_heating"],
        "pre_payment_water": contract_conditions["pre_payment_water"],
        "rental_total": contract_conditions["rental_total"],
    }

    return context


def build_answer_context(answers, context):

    for key, item in answers.items():
        k = key
        if key.find("#") > 0:
            split = key.split("#")
            k = split[0]

        a = IssueAnswer.objects.get(id=int(k))
        if (
            a.type == AT_TEXT[0]
            or a.type == AT_TIME[0]
            or a.type == AT_PHONE_NUMBER[0]
            or a.type == AT_NUMBER[0]
        ):
            context[a.marker] = item

        if item and a.type == AT_DATE[0]:  # DATUM
            date = item.split("-")
            context[a.marker] = f"{date[2]}.{date[1]}.{date[0]}"

        if a.type == AT_YESNO[0]:  # Ja/Nein
            if item == "YES":
                context[f"{a.marker}_YES"] = "X"
                context[f"{a.marker}_NO"] = ""
            else:
                context[f"{a.marker}_NO"] = "X"
                context[f"{a.marker}_YES"] = ""

        # if a.type == AT_CONTRACT_PARTNER[0]:  # VertragPartner
        #     if int(item) == 1:
        #         context["mieter2"]= tenant.mieter1
        #         context["mieter1"]= tenant.mieter2

        #         context["first_name"]= tenant.sap_name21
        #         context["last_name"]= tenant.sap_name22

        # FIXME: this looks like eighter doesn't work or could be moved to the top
        if a.type == AT_MULTCHOICE[0]:  # Multi
            context[a.marker] = item

        if a.type == AT_MULTCHOICE_MULT[0]:  # MultiMulti
            context[a.marker] = item
    return context


def render_form_to_pdf(validated_data, context_data):
    static_context = get_static_context(context_data)
    context = build_answer_context(
        json.loads(validated_data.get("answers")), static_context
    )
    template_string = render_to_string(validated_data.get("formular").html, context)
    options = {
        "encoding": "UTF-8",
        "page-size": "A4",
        "margin-top": "0mm",
        "margin-bottom": "0mm",
        "margin-left": "0mm",
        "margin-right": "0mm",
        "dpi": 800,
    }
    # False means don't render to file instead return bytes
    return pdfkit.from_string(template_string, False, options=options)


def get_description(answers) -> str:
    description = ""
    for key, item in answers.items():
        k = key
        if key.find("#") > 0:
            split = key.split("#")
            k = split[0]

        a = IssueAnswer.objects.get(id=int(k))
        text = ""

        if a.type in [
            AT_TEXT[0],
            AT_TIME[0],
            AT_MULTCHOICE[0],
            AT_MULTCHOICE_MULT[0],
            AT_PHONE_NUMBER[0],
            AT_NUMBER[0],
            AT_CONTRACT_PARTNER[0],
        ]:

            text = item

        if item and a.type == AT_DATE[0]:
            strr = item.split("-")
            text = strr[2] + "." + strr[1] + "." + strr[0]

        if a.type == AT_YESNO[0]:  # Ja/Nein
            text = "Nein"
            if item == "YES":
                text = "Ja"

        description = description + a.question + ": " + text + "\n"
    return description


def render_form_to_sap_req(instance, tenant):
    return {
        "userId": tenant.username,
        "typeId": instance.formular.sapkind.upper(),
        "codeGroupId": instance.formular.codegrp,
        "codeId": instance.formular.code,
        "propertyId": instance.sap_property,
        "description": get_description(json.loads(instance.answers)),
        # "files": itattachment,
    }
