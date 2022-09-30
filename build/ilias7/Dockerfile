# syntax=docker/dockerfile:1
ARG ilias_version=7.13
ARG php_version=7.4
ARG time_zone=Europe/Zurich
ARG ilias_cron_user_login=cron
ARG database_image=mariadb:10.3.35-focal
ARG database_ilias=ilias_lms
ARG database_ilias_user=lms

FROM fluxfw/flux-ilias-ilias-base:php$php_version AS ilias
ARG ilias_version
ARG time_zone
ARG ilias_cron_user_login
ARG database_ilias
ARG database_ilias_user
RUN /flux-ilias-ilias-base/bin/install-ilias-core.sh $ilias_version


# ILIAS Core
RUN apk add npm
RUN npm install less -g
RUN mkdir -p /var/www/html/Customizing/global/skin
RUN chown -R www-data:www-data /var/www/html/Customizing/global/skin
# Setup java 8 in ilias container because the certificate plugin generates the certificates via jasper reports.
RUN apk add --no-cache libretls musl-locales musl-locales-lang tzdata zlib fontconfig ttf-dejavu \
    && rm -rf /var/cache/apk/*
ENV JAVA_HOME=/opt/java/openjdk
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

COPY --from=eclipse-temurin:8u332-b09-jre-alpine $JAVA_HOME $JAVA_HOME
ENV PATH="${JAVA_HOME}/bin:${PATH}"

ENV ILIAS_DATABASE_HOST=database
ENV ILIAS_DATABASE_PORT=3306
ENV ILIAS_PHP_MEMORY_LIMIT=2048M
ENV ILIAS_ROOT_USER_LOGIN=fluxiliasroot
ENV ILIAS_DATABASE_CREATE_DATABASE=false
ENV ILIAS_DATABASE_TYPE=innodb
ENV ILIAS_SYSTEMFOLDER_CONTACT_FIRSTNAME=fluxlabs
ENV ILIAS_SYSTEMFOLDER_CONTACT_LASTNAME=ag
ENV ILIAS_SYSTEMFOLDER_CONTACT_EMAIL=support@fluxlabs.ch
ENV ILIAS_LUCENE_SEARCH=true
ENV ILIAS_HTTP_HTTPS_AUTODETECTION_HEADER_NAME=X-Forwarded-Proto
ENV ILIAS_HTTP_HTTPS_AUTODETECTION_HEADER_VALUE=https
ENV ILIAS_STYLE_MANAGE_SYSTEM_STYLES=true
ENV ILIAS_GLOBALCACHE_SERVICE=none
ENV ILIAS_GLOBALCACHE_COMPONENTS=all
ENV ILIAS_DATABASE_DATABASE=$database_ilias
ENV ILIAS_DATABASE_USER=$database_ilias_user
ENV ILIAS_CRON_USER_LOGIN=$ilias_cron_user_login
ENV ILIAS_COMMON_SERVER_TIMEZONE=$time_zone
ENV TZ=$time_zone

FROM fluxfw/flux-ilias-nginx-base:latest AS nginx
ARG time_zone
COPY --from=ilias $ILIAS_WEB_DIR $ILIAS_WEB_DIR
ENV ILIAS_COMMON_SERVER_TIMEZONE=$time_zone
ENV TZ=$time_zone


FROM fluxfw/flux-ilias-cron-base:php7.4 AS cron
COPY --from=ilias $ILIAS_WEB_DIR $ILIAS_WEB_DIR

# Setup java 8 in ilias container because the certificate plugin generates the certificates via jasper reports.
RUN apk add --no-cache libretls musl-locales musl-locales-lang tzdata zlib fontconfig ttf-dejavu \
    && rm -rf /var/cache/apk/*
ENV JAVA_HOME=/opt/java/openjdk
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

COPY --from=eclipse-temurin:8u332-b09-jre-alpine $JAVA_HOME $JAVA_HOME
ENV PATH="${JAVA_HOME}/bin:${PATH}"

ARG ilias_cron_user_login
ENV ILIAS_CRON_USER_LOGIN=$ilias_cron_user_login
ENV ILIAS_COMMON_SERVER_TIMEZONE=$time_zone
ENV TZ=$time_zone


FROM fluxfw/flux-ilias-ilserver-base:java8 AS ilserver
COPY --from=ilias $ILIAS_WEB_DIR $ILIAS_WEB_DIR
ENV ILIAS_ILSERVER_RAM_BUFFER_SIZE=512
ENV ILIAS_COMMON_SERVER_TIMEZONE=$time_zone
ENV TZ=$time_zone


FROM mariadb:10.3.35-focal AS database
ARG database_ilias
ARG database_ilias_user
ENV MARIADB_DATABASE=$database_ilias
ENV MARIADB_USER=$database_ilias_user
ENV TZ=$time_zone