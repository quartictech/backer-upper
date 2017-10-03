#!/bin/bash

function write_env {
  echo "export $1=\"${!1}\"" >> /etc/cron.env
}

write_env VERSION
write_env GCS_BUCKET
write_env SOURCE_POSTGRES_HOST
write_env SOURCE_POSTGRES_USER
write_env SOURCE_POSTGRES_PASSWORD
write_env TEMP_POSTGRES_HOST
write_env TEMP_POSTGRES_USER
write_env SLACK_HOOK_URL
write_env SLACK_CHANNEL