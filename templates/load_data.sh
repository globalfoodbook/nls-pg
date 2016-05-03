#!/bin/bash

set -e

export DB_DUMP_PLAIN_LOCATION=/tmp/psql_data/nutrition_sr26.sql
# export DB_DUMP_ARCHIVE_LOCATION=/tmp/psql_data/nutrition_sr26.archive

echo -e "*** LOADING DATABASE ***"

# create default database
# gosu $POSTGRES_MAIN_USER $POSTGRES_MAIN_USER --single <<-EOSQL
#   CREATE DATABASE "$POSTGRES_DB";
#   GRANT ALL PRIVILEGES ON DATABASE "$POSTGRES_DB" TO $POSTGRES_MAIN_USER;
# EOSQL

# clean sql_dump - because I want to have a one-line command

# remove indentation
# sed 's/^[ \t]*//' -i $DB_DUMP_PLAIN_LOCATION

# remove comments
# sed '/^--/ d' -i $DB_DUMP_PLAIN_LOCATION

# remove new lines
# sed ':a;N;$!ba;s/\n/ /g' -i $DB_DUMP_PLAIN_LOCATION

# remove other spaces
# sed 's/  */ /g' -i $DB_DUMP_PLAIN_LOCATION

# remove firsts line spaces
# sed 's/^ *//' -i $DB_DUMP_PLAIN_LOCATION

# append new line at the end
# sed -e '$a\' -i $DB_DUMP_PLAIN_LOCATION

# sed -i s"/ikennaokpala/$POSTGRES_USER/" $DB_DUMP_PLAIN_LOCATION

# gosu $POSTGRES_MAIN_USER psql -h $POSTGRES_IP -p $POSTGRES_PORT -U $POSTGRES_USER -d $POSTGRES_DB -a -f $DB_DUMP_PLAIN_LOCATION
# gosu $POSTGRES_MAIN_USER pg_restore --verbose --clean --no-acl --no-owner -h $POSTGRES_IP -p $POSTGRES_PORT -U $POSTGRES_USER -d $POSTGRES_DB $DB_DUMP_ARCHIVE_LOCATION

# gosu $POSTGRES_MAIN_USER psql -h $POSTGRES_IP -p $POSTGRES_PORT -U $POSTGRES_USER  <<-EOSQL
#   CREATE ROLE "ikennaokpala";
# EOSQL

gosu $POSTGRES_MAIN_USER psql -h $POSTGRES_IP -p $POSTGRES_PORT -U $POSTGRES_USER -d $POSTGRES_DB < $DB_DUMP_PLAIN_LOCATION

echo -e "*** DATABASE LOADED! ***"
