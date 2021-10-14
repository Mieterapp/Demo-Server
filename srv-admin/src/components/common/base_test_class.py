import json
import requests as req

from django.test import TestCase


class BaseTest(TestCase):

    def setUp(self):
        self.token = None
        self.req = req
        self.email = "dustin.nowosad@dit-digital.de"
        self.password = "123"
        self.backend_url = 'http://0.0.0.0:8000/api/v1'
        if self.token is None:
            self._authenticate_with_user()

    def _authenticate_with_user(self):
        result = self.req.post(
            self.backend_url + '/authenticate/',
            json={
                'email': self.email,
                'password': self.password
            },
            headers={
                'content_type': 'application/json'
            }
        )

        self.token = json.loads(result.content)["token"]
        pass
