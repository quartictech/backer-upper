#!/bin/bash
source /etc/cron.env

echo "Starting backup"
exec 5>&1
OUTPUT=$(set -o pipefail; /scripts/pg-backup.sh 2>&1 | tee >(cat - >&5))

if [ $? -eq 0 ]; then
  echo "Backup succeeded"
  echo "$OUTPUT" | slack.sh -h $SLACK_HOOK_URL -c $SLACK_CHANNEL -u backer-upper -i penguin \
      -T "Backup succeeded" \
      -C good
else
  echo "Backup failed!"
  echo "$OUTPUT" | slack.sh -h $SLACK_HOOK_URL -c $SLACK_CHANNEL -u backer-upper -i penguin \
      -T "Backup failed" \
      -C danger
fi


