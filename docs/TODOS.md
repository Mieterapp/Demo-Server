# Authentication

## Register

- [ ] When email mismatch sollen die Stammdaten direkt überschrieben werden. API
      steht Ende Januar zur Verfügung. Allerdings erst nach email Verifikation.
      Da wir die Stammdaten bei der Registrierung schon holen muss
      zwischengespeichert werden ob die email nach Verifikation aktualisiert
      werden muss.

## Login

- [ ] check if contract still is_active

## Mailings

- [ ] make possible to use EMAIL_BACKEND = "django_smtp_ntlm_backend.NTLMEmail"
      with EMAIL_HOST_USER = "DOMAIN\USERNAME" # z.B. "gwdsmtp.local\noreply".
      So add EMAIL_FROM_ADDRESS
- [ ] set mailing topics
- [x] test email address

# DIT Real Estate

## Customer Center

## Contracts

## Property

- [ ] import der objektliste

# Documents

- [ ] Mietvertrag, unterschrieben (inkl. Hausordnung)(Lasche: 101)
- [ ] Betriebskostenabrechnung (Lasche: 201)
- [ ] Betriebskostenabrechnungen der 2 Vorjahre

# Content

# Chat

Deadline: 16.12 EOF API Specs von DataSec

- [x] on register wird Ticket erstellt. Ticket darf nicht geschlossen werden
      (wird von Markus Köppen geklärt wie man das verhindern kann)
- [x] Der leere Chat beinhaltet eine Willkommensnachricht
- [x] der chat erstellt kommentare am ticket
- [x] Florian definiert API Chat Schema
- [x] API Enpoint `/api/v1/customer-chat/`
- [x] reverse message order
- [x] add session admin view
- [ ] add static image for avatar

## Frontend Schema

```typescript
// Message Objekt:
IMessage {
  _id: string | number
  text: string
  createdAt: Date | number
  user: User
}


sample_message_item = {
  _id: 1,
  text: 'My message',
  createdAt: new Date(Date.UTC(2016, 5, 11, 17, 20, 0)),
  user: {
    _id: 2,
    name: 'React Native',
    avatar: 'https://facebook.github.io/react/img/logo_og.png',
  },
}

sample_response = [
    {
      _id: 1,
      text: 'My message',
      createdAt: new Date(Date.UTC(2016, 5, 11, 17, 20, 0)),
      user: {
        _id: 2,
        name: 'React Native',
        avatar: 'https://facebook.github.io/react/img/logo_og.png',
      }
  },
  {
    _id: 2,
    text: 'My message',
    createdAt: new Date(Date.UTC(2016, 5, 11, 17, 20, 0)),
    user: {
      _id: 2,
      name: 'React Native',
      avatar: 'https://facebook.github.io/react/img/logo_og.png',
    }
  }
]

```

## FAQs

- [x] visible_group attribute
- [x] visible_group filtering
- [x] add group field

# Real Estate

## Contracts

- [x] List view user.contracts
- [x] Detail view user.contracts
- [ ] Make sure contracts are unique

## Customer Center

- [x] List view

# Survey

- [x] filter by object identifier string

# Administration

[logging setup](https://www.scalyr.com/blog/getting-started-quickly-django-logging)

- [ ] setup
      [logging admin email handler](https://docs.djangoproject.com/en/3.1/topics/logging/#id4)
