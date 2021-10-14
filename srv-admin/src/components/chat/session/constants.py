from datetime import date

from django.utils.translation import gettext as _

# TODO: move to settings
INITIAL_CHAT_MESSAGE = "Willkommen! Hier können Sie Ihrem Kundenbetreuer eine Nachricht schreiben. Die Bearbeitung erfolgt innerhalb der Geschäftszeiten." #"Willkommen! Hier können Sie Ihrem Kundenbetreuer eine Nachricht schreiben. Bitte beachten Sie: Um Ihre Anfrage zu Beantworten, benötigt Ihr Kundenbetreuer in der Regel ein wenig Zeit. Wir bitten um Ihr Verständnis, dass Ihre Anfrage nicht sofort bearbeitet werden kann."
#INITIAL_CHAT_MESSAGE = "Willkommen Bei der Mieterapp. Wie können wir helfen"


WELCOME_MESSAGE = {
    "_id": 0,
    "text": _(INITIAL_CHAT_MESSAGE),
    "createdAt": date.today().__str__(),
    "user": {
        "_id": 0,
        "name": "GWG Kundenservice",
        "avatar": "https://facebook.github.io/react/img/logo_og.png",
    },
}
