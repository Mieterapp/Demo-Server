#!/usr/bin/env bash

cd /dit-app/ && docker-compose run srv-admin ./manage.py import_issues >> /var/log/import-issues.log 2>&1