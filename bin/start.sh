#!/bin/sh
set -euo pipefail

# The cron configs need to be touched because of https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=647193
# The log needs to be touched for tailing
touch /etc/crontab /etc/cron.*/* /var/log/cron.log
# This gets injected from infra so make sure its +x
chmod +x /scripts/pg-backup.sh
# Save environment variables to be used by cron
write_env.sh
# Start syslog to get cron logging
rsyslogd
# Run backup on startup so that we can run ad hoc backups by bouncing
backup.sh
# Run cron with decent log level
cron -L 15
# Watch logs
tail -f /var/log/syslog /var/log/cron.log

