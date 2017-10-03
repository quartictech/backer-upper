#!/bin/bash
source /etc/cron.env

HOOK_URL=https://hooks.slack.com/services/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
CHANNEL=infrastructure

echo "Starting backup"
exec 5>&1
OUTPUT=$(bash /scripts/pg-backup.sh 2>&1 | tee >(cat - >&5))

if [ $? -eq 0 ]; then
  echo "Backup succeeded"
  echo "$OUTPUT" | slack.sh -h $HOOK_URL -c $CHANNEL -u backer-upper -i penguin \
      -T "Backup succeeded" \
      -C good
else
  echo "Backup failed!"
  echo "$OUTPUT" | slack.sh -h $HOOK_URL -c $CHANNEL -u backer-upper -i penguin \
      -T "Backup failed" \
      -C danger
fi


