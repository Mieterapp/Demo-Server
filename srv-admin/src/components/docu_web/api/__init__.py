from src.components.docu_web.utils import build_query_string
from requests_pkcs12 import get, head, post, put

from ..settings import dw_settings

SERVICE_URL = f"{dw_settings.PROTOCOL}://{dw_settings.HOST_NAME}"
# comment
# SERVICE_URL2 = f"{dw_settings.PROTOCOL}://dokuweb.datasec.de"
# SERVICE_URL = f"{dw_settings.PROTOCOL}://dokuweb.datasec.de"

def api_get(path="", query=dict, headers={}, auth_token=dw_settings.AUTH_TOKEN):
    query.update({"authtoken": auth_token})
    query_string = build_query_string(query)

    url = f"{SERVICE_URL}{path}{query_string}"
    return get(url, headers=headers)

def api_get2(path="", query=dict, headers={}, auth_token=dw_settings.AUTH_TOKEN):
    query.update({"authtoken": auth_token})
    query_string = build_query_string(query)

    url = f"{SERVICE_URL2}{path}{query_string}"
    return get(url, headers=headers)


def api_post(path="", query=dict, auth_token=dw_settings.AUTH_TOKEN):
    query.update({"authtoken": auth_token})
    query_string = build_query_string(query)

    url = f"{SERVICE_URL}{path}{query_string}"
    return post(url)


def api_put(path="", query=dict, auth_token=dw_settings.AUTH_TOKEN):
    query.update({"authtoken": auth_token})
    query_string = build_query_string(query)

    url = f"{SERVICE_URL}{path}{query_string}"
    return put(url)
