#!/bin/bash

# Colors
COLOR_OFF='\033[0m' # Text Reset
RED='\033[0;31m'    # Red
GREEN='\033[0;32m'  # Green
NC=$'\e[0m'         # No Color
BOLD=$(tput bold)

################################################################

echo ''
echo '8888888888 8888888b.  8888888 88888888888       888    888  .d88888b.   .d8888b.  88888888888  .d8888b.  '
echo '888        888  "Y88b   888       888           888    888 d88P" "Y88b d88P  Y88b     888     d88P  Y88b '
echo '888        888    888   888       888           888    888 888     888 Y88b.          888     Y88b.      '
echo '8888888    888    888   888       888           8888888888 888     888  "Y888b.       888      "Y888b.   '
echo '888        888    888   888       888           888    888 888     888     "Y88b.     888         "Y88b. '
echo '888        888    888   888       888           888    888 888     888       "888     888           "888 '
echo '888        888  .d88P   888       888           888    888 Y88b. .d88P Y88b  d88P     888     Y88b  d88P '
echo -e "8888888888 8888888P\"  8888888     888           888    888  \"Y88888P\"   \"Y8888P\"      888      \"Y8888P\"  ${RED}${BOLD}V 0.2 ${NC} \n\n"
echo "Github Repository https://github.com/ErvisTusha/Edit-hosts"
echo -e "Creator: ${RED}${BOLD} Ervis Tusha ${NC}  Contact : ${RED}${BOLD}https://twitter.com/ET ${NC} \n"

if [ "$IP" == "-h" ] || [ "$IP" == "--help" ] || [ ! -n "$1" ]; then
  echo -e "usage:\n"
  echo "rmhost IP or DOMAIN"
  echo "rmhost 1.1.1.1"
  echo "rmhost example.com"
  echo "rmhost 1.1.1.1 example.com"
  exit 1
fi

IP="$1"
DOMAIN="$2"

## check if user has permission to edit /etc/hosts

if [ ! -w "/etc/hosts" ]; then
  echo -e "${RED}${BOLD}Write permission is NOT granted on /etc/hosts \n\n"
  exit 1
fi

## Backup /etc/hosts to  hosts.timestamp.bak

TIMESTAMP=$(date +%s)

cp /etc/hosts /etc/hosts.$TIMESTAMP.bak

## remove IP or DOMAIN

if [ -n "$DOMAIN" ]; then
  sed "/$IP $DOMAIN /d" /etc/hosts >/tmp/hosts.$TIMESTAMP.bak

else
  VALID_IP=$(echo "$1" | awk -F '.' ' $0 ~ /^([0-9]{1,3}\.){3}[0-9]{1,3}$/ && $1 <=255 && $2 <= 255 && $3 <= 255 && $4 <= 255 ')
  if [ $VALID_IP ]; then
    #DELETE HOSTS IF ARG 1 is IP
    sed "/$1 /d" /etc/hosts >/tmp/hosts.$TIMESTAMP.bak
  else
    #DELETE HOSTS IF ARG 1 is DOMAIN

    sed "/ $1 /d" /etc/hosts >/tmp/hosts.$TIMESTAMP.bak
  fi

fi

## tmp hosts to etc dir
cp /tmp/hosts.$TIMESTAMP.bak /etc/hosts

## check cp
if [ $? -ne 0 ]; then
  echo -e "${RED}${BOLD}FAILED to delete $DOMAIN"
  exit 1
fi

cat /etc/hosts

exit 0
