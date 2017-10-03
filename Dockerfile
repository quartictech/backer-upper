FROM debian:9.1

# Prerequisites
RUN \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        curl \
        apt-transport-https \
        ca-certificates \
        gnupg && \
rm -rf /var/lib/apt/lists/*

RUN \
    # GCloud SDK
    # (see https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu)
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb http://packages.cloud.google.com/apt cloud-sdk-stretch main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \

    # Finally
    apt-get update && \
    apt-get install --no-install-recommends -y \
        google-cloud-sdk=173.0.0-0 \
        postgresql-client-9.6 \
        cron \
        rsync \
        ssh \
        rsyslog \
        unzip && \
    rm -rf /var/lib/apt/lists/*

ADD crontab /etc/cron.d/hello-cron
RUN chmod 0644 /etc/cron.d/hello-cron
 
ADD bin/slack.sh /usr/bin
RUN chmod +x /usr/bin/slack.sh

ADD bin/backup.sh /usr/bin
RUN chmod +x /usr/bin/backup.sh

ADD bin/write_env.sh /usr/bin
RUN chmod +x /usr/bin/write_env.sh

ADD bin/start.sh /usr/bin
RUN chmod +x /usr/bin/start.sh

RUN mkdir /scripts
ADD bin/pg-backup.sh /scripts
RUN chmod +x /scripts/pg-backup.sh

CMD start.sh