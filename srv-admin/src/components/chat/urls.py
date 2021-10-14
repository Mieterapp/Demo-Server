from src.components.chat.session.views import customer_chat
from django.urls import path
from rest_framework.routers import DefaultRouter


from . import NS

router = DefaultRouter()

urlpatterns = [
    path("customer-chat/", customer_chat),
]

urlpatterns += router.urls