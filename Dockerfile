# This is based on Debian 8.8 (jessie)
FROM google/cloud-sdk:159.0.0-slim

RUN \
    # Need newer version of Postgres
    # (see https://www.jurisic.org/index.php?post/2017/02/28/How-to-install-PostgreSQL-9.6-server-on-Debian-8-Jessie)
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list.d/postgresql.list && \

    apt-get update && \
    apt-get install --no-install-recommends -y \
        postgresql-client-9.6 cron && \
    rm -rf /var/lib/apt/lists/*

ADD crontab /etc/cron.d/hello-cron
RUN chmod 0644 /etc/cron.d/hello-cron
RUN touch /var/log/cron.log
 
ADD bin/slack.sh /usr/bin
RUN chmod +x /usr/bin/slack.sh

ADD bin/backup.sh /usr/bin
RUN chmod +x /usr/bin/backup.sh

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log

