#!/bin/bash
source .env

ILIAS_BUILD=fluxms/flux-ilias-php
NGINX_BUILD=fluxms/flux-ilias-nginx
CRON_BUILD=fluxms/flux-ilias-cron
ILSERVER_BUILD=fluxms/flux-ilias-ilserver
DATABASE_BUILD=fluxms/flux-ilias-database

docker rmi $ILIAS_BUILD:$MAJOR_VERSION
docker build --target ilias -t $ILIAS_BUILD:$MAJOR_VERSION .

docker rmi $NGINX_BUILD:$MAJOR_VERSION
docker build --target nginx -t $NGINX_BUILD:$MAJOR_VERSION .

docker rmi $CRON_BUILD:$MAJOR_VERSION
docker build --target cron -t $CRON_BUILD:$MAJOR_VERSION .

docker rmi $ILSERVER_BUILD:$MAJOR_VERSION
docker build --target ilserver -t $ILSERVER_BUILD:$MAJOR_VERSION .

docker rmi $DATABASE_BUILD:$MAJOR_VERSION
docker build --target database -t $DATABASE_BUILD:$MAJOR_VERSION .