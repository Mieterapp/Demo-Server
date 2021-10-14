from base64 import b64encode

from src.components.docu_web.api import api_get


def get_auth_token(username: str, password: str):
    credentials = f"{username}:{password}".encode()
    headers = {"Authorization": f"Basic {b64encode(credentials).decode('ascii')}"}

    return api_get(path="/api/dokuweb/auth/token", headers=headers)