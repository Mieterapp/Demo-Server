from django.test import TestCase

# Create your tests here.
import json

from django.test import TestCase
from src.components.common.base_test_class import BaseTest


# yarn test-specific src.components.authentication_local.tests.AuthenticationApi
class AuthenticationApi(BaseTest):

    def setUp(self):
        super().setUp()

    # yarn test-specific src.components.authentication_local.tests.AuthenticationApi.test_should_sent_invitation_email_when_authenticated
    def test_should_sent_invitation_email_when_authenticated(self):
        invitation_email = "dustin.nowosad@dit-digital.de"
        response = self.req.post(
            self.backend_url + '/register/invite/',
            json={
                "email": invitation_email
            },
            headers={
                'content_type': 'application/json',
                'Authorization': f"JWT {self.token}"
            }
        )
        result = json.loads(response.content)
        self.assertEqual(result.get("message"),  f"sent invitation to {invitation_email}")
        self.assertEqual(response.status_code, 200)

    # yarn test-specific src.components.authentication_local.tests.AuthenticationApi.test_should_get_contract_and_principal_id_when_token_works
    def test_should_get_contract_and_principal_id_when_token_works(self):
        invitation_email = "dustin.nowosad@dit-digital.de"
        #todo set token
        response = self.req.get(
            self.backend_url + '/register/token/71b20c37219deb009692c06493f20e3cac930ebe',
            headers={
                'content_type': 'application/json',
                'Authorization': f"JWT {self.token}"
            }
        )
        result = json.loads(response.content)
        print(result)
        self.assertEqual(result.get("message"), f"sent invitation to {invitation_email}")
        self.assertEqual(response.status_code, 200)

    # yarn test-specific src.components.authentication_local.tests.AuthenticationApi.test_should_sent_reset_email_when_authenticated
    def test_should_sent_reset_email_when_authenticated(self):
        email_to_reset = "dustin.nowosad@dit-digital.de"
        response = self.req.post(
            self.backend_url + '/password/reset/',
            json={
                "email": email_to_reset,
            },
            headers={
                'content_type': 'application/json',
                'Authorization': f"JWT {self.token}"
            }
        )
        result = json.loads(response.content)
        self.assertEqual(result.get("message"),  f"sent invitation to {email_to_reset}")
        self.assertEqual(response.status_code, 200)

