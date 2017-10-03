#!/bin/bash
source /etc/cron.env

SLACK_HOOK_URL=https://hooks.slack.com/services/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
SLACK_CHANNEL=infrastructure

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


