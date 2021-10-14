# GWGStuttgartServer

**CONTACT FOR ANY QUESTIONS**

Philipp Litzenberger

<philipp@litzenberger.engineering>

+49 172 8677 306

## Project Information

- [click dummy](https://xd.adobe.com/view/4d122ce7-a43e-44ee-5862-bd15d1fc94ba-3b23/)
  Passwort: GWG-Gruppe-demo2

## Service Admin including API

### Requirements

- [docker-compose](https://docs.docker.com/compose/install/)

### Start srv-admin

```
yarn start:srv-admin
```

this will pull up `srv-db` automatically and run the migrations.

Access the API `http://localhost:8000/api/v1/`

### Create Admin user

```
yarn db:createsuperuser
```

### Import gwg issues data:

```
yarn db:import-issues
```

### Run tests

```
yarn test
```

### Reset db

in case you run in any trouble with the db, just reset and run migrations again.

```
yarn db:reset
yarn db:migrate
yarn db:import
```
