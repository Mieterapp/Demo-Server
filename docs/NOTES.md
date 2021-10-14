# NOTES

## JOURFIX QUESTIONS

- [ ] email: welcome verification success?
- [ ] 23.10: integrations.gwg_tenant import: diff for insert, update, delete
      tenants Clarified until KW 44 by Markus Köppen
- [ ] 23.10: integrations.gwg_tenant import: file handling
- [ ] 23.10: GWG Infrastructure: deployment zugang
- [ ] 23.10: GWG FAQs: fetch once a day

## API

### Registration Flow

#### Test Datensätze

```
RECNNR        | BIRTHDT    | NAME
62095.0019.02 | 1998-13-12 | Denis Lichtenwald
62085.0004.07 | 1990-24-12 | Sabrina Thouett
62139.0009.06 | 1987-06-01 | Josefine Delius
62085.0030.07 | 1952-01-01 | Ekrem Erkil
62139.0508.05 | 1987-06-01 | Josefine Delius
```

### Authentication

- [x] api: register (requires tenant data import)
- [x] email: verification mail
- [x] api: verify email
- [x] login (obtain jwt token)
- [x] password lost input: email (send mail with deeplink to password reset)
      NOTE: django/contrib/auth/urls.py
- [x] change password input: password, token
- [x] authenticated user => returns full profile

### Data import

- [x] integrations.gwg_tenant: import tenant base data

## B&O Schadensmeldung

wird mittels iFrame in App eingebunden

- [ ] Schadens History?
- [ ] Anlegen der Schäden über iFrame

https://www.donatianna.it/litzenberger.engineering

## Anliegen über Doku@Web

webservices/Tickets

### DokuWeb Fields

`method=getTicketProcessFieldsFirstStep`

- Die Felder aus dem data array werden der Reihe nach in der Form gerendert.
- Alle gelieferten Felder werden gerendert. Außer `HIDDEN: True`

HIDDEN: Boolean | Show/Hide

TYPE: label | Info Text Feld aus `LABEL` | `VALUE`

TYPE: sapfuba

### Feldtypen

1 Text

2 Datum:

Zeit:

Ja/Nein: checkbox

Multiple Choice:

Multiple Choice Mehrfachauswahl:

Telefonnummer:

Zahl:

Welcher Vertragspartner:

## TODO: check system EMAIL

gwggruppe-de0i.mail.protection.outlook.com Port: 587 (STARTTLS)
mieterapp@gwg-gruppe.de mit Stuttgart21!

## Deployment

- [ ] Build local vagrant or packer image
- [ ] Integrate webhook on server and use
      [github webhook-action](https://github.com/marketplace/actions/webhook-action)

# Content

## FAQs

- [ ] 16.12 Kommen erst in V2

## Push Notifications

- [ ] 14.12.2020 API um Push Notifications von außen zu triggern. Von Außen ist
      neu bisher nur von intern erstellbar (Andi)
- [ ] "device/gcm": "https://apptest.neueluebecker.de/api/v1/device/gcm/",

###

### External API

**Security Note:**

- API steht hinter Firewall + authentication
- API muss mit authentication gesichert werden
- Andis Token API Auth (token: hash(principal_id + timestamp))

```python
def
hash = hashlib.sha256(f"{settings.DIT_API_SECRET}{str(reqTs)}").hexdigest()
```

_PAYLOAD_

```python
# PARTNER: principal_id
# UNIX_TIMESTAMP: 2123123 in s
# DIT_API_SECRET: wird ausgetauscht
PAYLOAD = {
      "principal_id": "",
      "auth_token": "sha256(DIT_API_SECRET|UNIX_TIMESTAMP|PARTNER)",
      "type": "typeOfMessage | Document | News | Defect | DefectStatusUpdate | Issue",
      "object_id": "object identifier"
}
```

# Anliegen

# Content

## FAQ
