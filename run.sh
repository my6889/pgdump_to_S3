#!/bin/bash

set -e

if [ "${AWS_ACCESS_KEY_ID}" = "**None**" ]; then
  echo "You need to set the AWS_ACCESS_KEY_ID environment variable."
  exit 1
fi

if [ "${AWS_SECRET_ACCESS_KEY}" = "**None**" ]; then
  echo "You need to set the AWS_SECRET_ACCESS_KEY environment variable."
  exit 1
fi

if [ "${AWS_BUCKET}" = "**None**" ]; then
  echo "You need to set the AWS_BUCKET environment variable."
  exit 1
fi

if [ "${PREFIX}" = "**None**" ]; then
  echo "You need to set the PREFIX environment variable."
  exit 1
fi

if  [ "${ALL_DATABASES}" = "" ]; then
   if [ "${PGDUMP_DATABASE}" = "**None**" ]; then
   echo "You need to set the PGDUMP_DATABASE environment variable."
   exit 1
   fi
fi

if [ -z "${POSTGRES_ENV_POSTGRES_USER}" ]; then
  echo "You need to set the POSTGRES_ENV_POSTGRES_USER environment variable."
  exit 1
fi

if [ -z "${POSTGRES_ENV_POSTGRES_PASSWORD}" ]; then
  echo "You need to set the POSTGRES_ENV_POSTGRES_PASS environment variable."
  exit 1
fi

if [ -z "${POSTGRES_PORT_5432_TCP_ADDR}" ]; then
  echo "You need to set the POSTGRES_PORT_5432_TCP_ADDR environment variable or link to a container named POSTGRES."
  exit 1
fi

if [ -z "${POSTGRES_PORT_5432_TCP_PORT}" ]; then
  echo "You need to set the POSTGRES_PORT_5432_TCP_PORT environment variable or link to a container named POSTGRES."
  exit 1
fi



if [ "${ALL_DATABASES}" = "" ]; then

POSTGRES_HOST_OPTS="-h $POSTGRES_PORT_5432_TCP_ADDR -p $POSTGRES_PORT_5432_TCP_PORT -U $POSTGRES_ENV_POSTGRES_USER"

echo "Starting dump of ${PGDUMP_DATABASE} database(s) from ${POSTGRES_PORT_5432_TCP_ADDR}..."

export PGPASSWORD=${POSTGRES_ENV_POSTGRES_PASSWORD}

ds=`date +%Y%m%d_%H%M%S`
DUMPFILE=/pgdump
pg_dump $PGDUMP_OPTIONS $POSTGRES_HOST_OPTS $PGDUMP_DATABASE > $DUMPFILE/$PGDUMP_DATABASE.$ds.sql

elif [ "${ALL_DATABASES}" = "TRUE" ]; then
POSTGRES_HOST_OPTS="-h $POSTGRES_PORT_5432_TCP_ADDR -p $POSTGRES_PORT_5432_TCP_PORT -U $POSTGRES_ENV_POSTGRES_USER"
echo "Starting dump of all databases from ${POSTGRES_PORT_5432_TCP_ADDR}..."
export PGPASSWORD=${POSTGRES_ENV_POSTGRES_PASSWORD}
ds=`date +%Y%m%d_%H%M%S`
DUMPFILE=/pgdump

pg_dumpall  $POSTGRES_HOST_OPTS > $DUMPFILE/PG_ALL_DB.$ds.sql
fi

echo "rsync to S3"
echo "rsync to S3"
echo "rsync to S3"


aws s3 sync /pgdump/ s3://$AWS_BUCKET/$PREFIX/
echo "Done!"
echo "Done!"
echo "Done!"

exit 0

