"""
Login and logout views for the browsable API.

Add these to your root URLconf if you're using the browsable API and
your API requires authentication:

    urlpatterns = [
        ...
        url(r'^auth/', include('rest_framework.urls'))
    ]

You should make sure your authentication settings include `SessionAuthentication`.
"""
from django.conf.urls import url
from django.contrib.auth import views
from rest_framework_jwt.views import obtain_jwt_token

app_name = "gwg_tenant"
urlpatterns = []
