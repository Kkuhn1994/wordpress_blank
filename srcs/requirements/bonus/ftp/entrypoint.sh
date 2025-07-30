#!/bin/bash

export ROOT_PASSWORD=$(cat /run/secrets/root_password)

useradd -m ftpuser
echo "${ROOT_PASSWORD}"
echo "ftpuser:${ROOT_PASSWORD}" | chpasswd

exec pure-ftpd -P 0.0.0.0 -j -l unix -p 30000:30010
