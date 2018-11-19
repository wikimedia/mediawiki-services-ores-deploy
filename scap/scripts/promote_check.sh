#!/bin/sh

# Restart celery.
sudo service celery-ores-worker restart

# Check if celery is up
if [ "$(systemctl is-active celery-ores-worker.service)" = "inactive" ]; then
  echo 'Celery is not up'
  exit 1;
fi
