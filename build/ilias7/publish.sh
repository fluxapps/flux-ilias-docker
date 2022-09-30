#!/bin/bash
source .env

ILIAS_BUILD=fluxms/flux-ilias-php
NGINX_BUILD=fluxms/flux-ilias-nginx
CRON_BUILD=fluxms/flux-ilias-cron
ILSERVER_BUILD=fluxms/flux-ilias-ilserver
DATABASE_BUILD=fluxms/flux-ilias-database

docker push   $ILIAS_BUILD:$MAJOR_VERSION
docker tag    $ILIAS_BUILD:$MAJOR_VERSION $ILIAS_BUILD:$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION
docker push   $ILIAS_BUILD:$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION

docker push   $NGINX_BUILD:$MAJOR_VERSION
docker tag    $NGINX_BUILD:$MAJOR_VERSION $NGINX_BUILD:$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION
docker push   $NGINX_BUILD:$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION

docker push   $CRON_BUILD:$MAJOR_VERSION
docker tag    $CRON_BUILD:$MAJOR_VERSION $CRON_BUILD:$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION
docker push   $CRON_BUILD:$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION

docker push   $ILSERVER_BUILD:$MAJOR_VERSION
docker tag    $ILSERVER_BUILD:$MAJOR_VERSION $ILSERVER_BUILD:$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION
docker push   $ILSERVER_BUILD:$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION

docker push   $DATABASE_BUILD:$MAJOR_VERSION
docker tag    $DATABASE_BUILD:$MAJOR_VERSION $DATABASE_BUILD:$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION
docker push   $DATABASE_BUILD:$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION