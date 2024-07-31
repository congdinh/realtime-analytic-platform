#!/bin/bash
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d "$POSTGRES_DB_METABSE"  <<-EOSQL
     create schema if not exists $SCHEMA;
     create table $SCHEMA.todos (
        id serial primary key,
        done boolean not null default false,
        task text not null,
        due timestamptz
     );
     create role $ANON nologin;
     create role $AUTHENTICATOR noinherit login password '$POSTGRES_PASSWORD';
     grant $ANON to $AUTHENTICATOR;
EOSQL