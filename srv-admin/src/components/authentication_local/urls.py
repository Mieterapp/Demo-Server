from django.urls import path

from .api.authenticate import Authenticate
from .api.register import RegisterAPIView
from .api.verify_email import VerifyEmailByToken
from .invitation.views import InviteByEmail, InvitationData
from .password_reset.views import PasswordChange, PasswordReset

app_name = "authentication_local"


urlpatterns = [
    path("register/", RegisterAPIView.as_view(), name="register"),
    path(
        "register/verify-email/",
        VerifyEmailByToken.as_view(),
        name="verify-email",
    ),
    path(
        "register/invite/",
        InviteByEmail.as_view(),
        name="invite",
    ),
    path(
        "register/token/<str:token>/",
        InvitationData.as_view(),
        name="invite-data",
    ),
    path(
        "authenticate/",
        Authenticate.as_view(),
        name="authenticate",
    ),
    path(
        "password/reset/",
        PasswordReset.as_view(),
        name="password-reset",
    ),
    path(
        "password/change/",
        PasswordChange.as_view(),
        name="password-change",
    ),
]
