import os
import environ

env = environ.Env()
from unipath import Path

SETTINGS_DIR = Path(__file__).ancestor(2)


PUSH_NOTIFICATIONS_SETTINGS = {
    # "APNS_AUTH_KEY_PATH": os.path.join(
    #     SETTINGS_DIR, "certificates", "AuthKey_WJXNW2ULT6.p8"
    # ),
    # "APNS_AUTH_KEY_ID": env.str("APNS_AUTH_KEY_ID"),
    # "APNS_TEAM_ID": env.str("APNS_TEAM_ID"),
    # "APNS_TOPIC": env.str("APNS_TOPIC"),  # usually same as device bundle name
    # "APNS_USE_SANDBOX": env.bool("APNS_USE_SANDBOX", False),  # or false
    #"APNS_CERTIFICATE": os.path.join(
    #    SETTINGS_DIR, "certificates", "AppleDevTest.pem"
    #),
    "APNS_CERTIFICATE": os.path.join(
        SETTINGS_DIR, "certificates", "ApplePushTest.pem"
    ),
    "GCM_API_KEY": "AAAAZXPv9AA:APA91bGR9mQz_VNLPasgMNBry8hOTTvJaKD4xyUI0qC_IvM3PkMaW7k-z2YhlaULIMkygXq8jOz0x1rsiy8FUKNDg_ICgIxKe4YJSMOII41wM8GX8tPFaFqFG-O4nkni9fXosnVzzy7a",
    "GCM_POST_URL":"https://fcm.googleapis.com/fcm/send",
    "FCM_API_KEY": "AAAAZXPv9AA:APA91bGR9mQz_VNLPasgMNBry8hOTTvJaKD4xyUI0qC_IvM3PkMaW7k-z2YhlaULIMkygXq8jOz0x1rsiy8FUKNDg_ICgIxKe4YJSMOII41wM8GX8tPFaFqFG-O4nkni9fXosnVzzy7a",
    "FCM_POST_URL":"https://fcm.googleapis.com/fcm/send",
}

DIT_PUSH_NOTIFICATIONS = {
    "PUSH_NOTIFICATION_SECRET": "84caeab44eebf0032d5ac195d1faeecd"
}
