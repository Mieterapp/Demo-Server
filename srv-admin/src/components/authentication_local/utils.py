import binascii
import os

from django.conf import settings
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
import logging

logger = logging.getLogger(__name__)


def _generate_token(principal_id=None):
    print("utils.py no principal id")
    return binascii.hexlify(os.urandom(20)).decode("utf-8")


def send_multi_format_email(template_prefix, template_ctxt, target_email):
    subject_template = "authentication_local/%s_subject.txt" % template_prefix
    plain_template = "authentication_local/%s.txt" % template_prefix
    html_template = "authentication_local/%s.html" % template_prefix

    subject = render_to_string(subject_template).strip()
    from_email = settings.EMAIL_FROM_ADDRESS
    to = target_email
    logger.debug(f" send_email REGISTRATION 2  {from_email}")
    logger.debug(f" send_email REGISTRATION 3  {to}")
    logger.debug(f" send_email REGISTRATION 1  {subject}")
    text_content = render_to_string(plain_template, template_ctxt)
    html_content = render_to_string(html_template, template_ctxt)
    msg = EmailMultiAlternatives(subject, text_content, from_email, [to])
    msg.attach_alternative(html_content, "text/html")
    print(f"text_content {text_content}")
    print(f"subject {subject}")
    print(f"from_email {from_email}")
    print(f"to {to}")
    msg.send()
