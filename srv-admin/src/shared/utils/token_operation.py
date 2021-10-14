import jwt
from src.settings.django import SECRET_KEY


def extract_keys_from_token(token, keys):
    """
    token: {
        "typ":"JWT",
        "alg":"HS256"}
        available keys
        {"user_id":3,
        "username":"P000036",
        "exp":1615192639,
        "email":"dustin.nowosad@dit-digital.de",
        "orig_iat":1614587839,
        "oAuthToken":"388e8c1bb9acdda6e56a67e2e35cca57"}
    """
    keys_content = dict()
    part_token = token[4:]
    print("decoded_jwt")
    print(keys_content)
    decoded_jwt = jwt.decode(
        part_token,
        SECRET_KEY,
        algorithms=['HS256']
    )
    print("decoded_jwt")
    print(decoded_jwt)
    for key in keys:
        keys_content[key] = decoded_jwt.get(key)

    return keys_content
