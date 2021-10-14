#!/usr/bin/env bash

# Ensure the log file exists
touch /var/log/import-issues.log

# Ensure permission on the command
chmod a+x /dit-app/etc/cron.daily/import-issues.sh

# Added a cronjob in a new crontab
ln -s /dit-app/etc/cron.daily/import-issues.sh /etc/cron.daily/