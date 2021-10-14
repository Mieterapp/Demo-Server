import hashlib

from django.test import TestCase
import requests

from django.contrib.auth.tokens import PasswordResetTokenGenerator


class AccountActivationTokenGenerator:
    def __init__(self, contract_id,timestamp):
        self.contract_id = contract_id
        self.timestamp = timestamp
        self.hashed_code = "timestamp"

    def make_hash_value(self):
        self.hashed_code = hashlib.sha256((self.contract_id + "||" + self.timestamp).encode('utf-8')).hexdigest()
        return self.hashed_code


# yarn test:specific src/components/authentication_local/api/tests.py
# yarn test:specific src/components/authentication_local/api/tests.py -k "TokenTest.test_create_token_to_hash"
class TokenTest(TestCase):

    def test_create_token_to_hash(self):
        account_activation_token = AccountActivationTokenGenerator("112233", "aabbcc")
        my_new_token = account_activation_token.make_hash_value()
        print(my_new_token)
        print("---------------------------------")
        print("---------------------------------")
        print("---------------------------------")
        pass
