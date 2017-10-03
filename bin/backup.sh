#!/bin/sh

HOOK_URL=https://hooks.slack.com/services/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
CHANNEL=infrastructure

OUTPUT=$($BACKUP_SCRIPT 2>&1)

if [ $? -eq 0 ]; then
  echo "Backup succeeded"
  echo "$OUTPUT" | slack.sh -h $HOOK_URL -c $CHANNEL -u backer-upper -i penguin \
      -T "Backup succeeded" \
      -C good
else
  >&2 echo "Backup failed!"
  echo "$OUTPUT" | slack.sh -h $HOOK_URL -c $CHANNEL -u backer-upper -i penguin \
      -T "Backup failed" \
      -C danger
fi

