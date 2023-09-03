#!/bin/sh

if [ "$(id -u)" = "0" ]; then
  CERT_PATH=/etc/ssl/postgres

  echo "Copying mounted certificate to ${CERT_PATH}..."
  mkdir -p ${CERT_PATH}
  cp /.ssl/fullchain.pem ${CERT_PATH}/fullchain.pem
  chown root:postgres ${CERT_PATH}/fullchain.pem
  chmod 640 ${CERT_PATH}/fullchain.pem

  cp /.ssl/privkey.pem ${CERT_PATH}/privkey.pem
  chown root:postgres ${CERT_PATH}/privkey.pem
  chmod 640 ${CERT_PATH}/privkey.pem
fi
