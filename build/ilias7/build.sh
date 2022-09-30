#!/bin/bash
source .env

ILIAS_BUILD=fluxms/flux-ilias-php
NGINX_BUILD=fluxms/flux-ilias-nginx
CRON_BUILD=fluxms/flux-ilias-cron
ILSERVER_BUILD=fluxms/flux-ilias-ilserver
DATABASE_BUILD=fluxms/flux-ilias-database

docker build --target ilias -t lxlms:latest .
docker build --target nginx -t lxlms:latest .
docker build --target cron -t lxlms:latest .
docker build --target ilserver -t lxlms:latest .
docker build --target database -t lxlms:latest .


${COMPOSE_PROJECT_NAME}