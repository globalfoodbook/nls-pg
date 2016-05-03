#!/bin/bash

set -e

export PATH=/usr/local/bin:/usr/lib/postgresql/$POSTGRES_VERSION/bin/:$PATH
export NUT_PG_DSN="postgres://$POSTGRES_USER:$POSTGRES_PASS@$POSTGRES_IP/$POSTGRES_DB?sslmode=disable"

/etc/init.d/pg_entrypoint.sh $POSTGRES_MAIN_USER
