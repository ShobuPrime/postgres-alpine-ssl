#!/bin/sh

CERT_PATH=/etc/ssl/postgres

echo "Initializing Postgres with SSL"
echo "Updating PostgreSQL configuration..."

# Using `~` as delimiter instead of `/` so variable interpolations work better
sed -i "s/^#ssl = off/ssl = on/" $PGDATA/postgresql.conf
sed -i "s~^#ssl_cert_file = 'server.crt'~ssl_cert_file = '$CERT_PATH/fullchain.pem'~" $PGDATA/postgresql.conf
sed -i "s~^#ssl_key_file = 'server.key'~ssl_key_file = '$CERT_PATH/privkey.pem'~" $PGDATA/postgresql.conf

pg_ctl -D $PGDATA reload
pg_ctl -D $PGDATA restart -m smart
pg_ctl -D $PGDATA status
