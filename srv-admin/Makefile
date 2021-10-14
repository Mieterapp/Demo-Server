install: ./venv/bin/pip
	./venv/bin/pip install -r requirements.txt

migrate: .env
	docker-compose run srv-admin ./manage.py migrate

migrations: .env
	docker-compose run srv-admin ./manage.py makemigrations

reset_db: .env
	docker-compose stop srv-db
	docker-compose rm db
	docker-compose up -d srv-db

build: .env
	docker-compose build

createsuperuser: .env
	docker-compose run srv-admin ./manage.py createsuperuser --username pli --email a@b.de

collectstatic: build .env
	docker-compose run srv-admin ./manage.py collectstatic

start: build migrate
	docker-compose up srv-admin


appenv: ./venv/bin/activate ./venv/bin/pip
./venv/bin/activate ./venv/bin/pip:
	python3 -m venv venv
	./venv/bin/pip install --upgrade pip

.env:
	cp env.template .env

clean:
	rm -rf venv .env