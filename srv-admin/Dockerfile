FROM python:3.8-slim

RUN apt-get update && apt-get install -y \
  libpq-dev \
  gcc \
  wkhtmltopdf

ENV PYTHONUNBUFFERED 1

RUN mkdir -p /opt/dit-app/
WORKDIR /opt/dit-app/
COPY requirements.txt /opt/dit-app/
RUN pip install -r requirements.txt
COPY src /opt/dit-app/