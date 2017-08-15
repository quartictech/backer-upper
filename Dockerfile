# This is based on Debian 8.8 (jessie)
FROM google/cloud-sdk:159.0.0-slim

RUN \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        postgresql-client-9.4=9.4.13-0+deb8u1 && \
    rm -rf /var/lib/apt/lists/*

