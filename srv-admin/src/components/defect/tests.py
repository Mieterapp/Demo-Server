from django.test import TestCase

# Create your tests here.
import json

from django.test import TestCase
from src.components.common.base_test_class import BaseTest


# yarn test-specific src.components.defect.tests.DefectApiTest
class DefectApiTest(BaseTest):

    def setUp(self):
        super().setUp()

    # yarn test-specific src.components.defect.tests.DefectApiTest.test_should_get_defects_when_authenticated
    def test_should_get_defects_when_authenticated(self):
        response = self.req.get(
            self.backend_url + '/defects/',
            headers={
                'content_type': 'application/json',
                'Authorization': f"JWT {self.token}"
            }
        )
        result = json.loads(response.content)
        self.assertTrue(isinstance(result, list))
        self.assertEqual(response.status_code, 200)

    # yarn test-specific src.components.defect.tests.DefectApiTest.test_should_get_defects_types_when_authenticated
    def test_should_get_defects_types_when_authenticated(self):
        response = self.req.get(
            self.backend_url + '/defect-types/',
            headers={
                'content_type': 'application/json',
                'Authorization': f"JWT {self.token}"
            }
        )
        result = json.loads(response.content)
        self.assertTrue(isinstance(result, list))
        self.assertEqual(response.status_code, 200)

    # yarn test-specific src.components.defect.tests.DefectApiTest.test_should_get_defect_status_when_authenticated
    def test_should_get_defect_status_when_authenticated(self):
        response = self.req.get(
            self.backend_url + '/defect-status/',
            headers={
                'content_type': 'application/json',
                'Authorization': f"JWT {self.token}"
            }
        )
        result = json.loads(response.content)
        self.assertTrue(isinstance(result, list))
        self.assertEqual(response.status_code, 200)

    # yarn test-specific src.components.defect.tests.DefectApiTest.test_should_get_reported_defects_when_authenticated
    def test_should_get_reported_defects_when_authenticated(self):
        response = self.req.get(
            self.backend_url + '/reported-defects/',
            headers={
                'content_type': 'application/json',
                'Authorization': f"JWT {self.token}"
            }
        )
        result = json.loads(response.content)
        print(result)
        self.assertTrue(isinstance(result, list))
        self.assertEqual(response.status_code, 200)


