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

if [ "$IP" == "-h" ] || [ "$IP" == "--help" ] || [ ! -n "$IP" ]; then

  echo -e "usage:\n"
  echo "addhost IP DOMAIN"
  echo -e "addhost 1.1.1.1 example.com\n"
  exit 1
fi

IP="$1"
DOMAIN="$2"

## check if user has permission to edit /etc/hosts

if [ ! -w "/etc/hosts" ]; then
  echo -e "${RED}${BOLD}Write permission is NOT granted on /etc/hosts \n\n"
  exit 1
fi

## IP Validation

VALID_IP=$(echo "$IP" | awk -F '.' ' $0 ~ /^([0-9]{1,3}\.){3}[0-9]{1,3}$/ && $1 <=255 && $2 <= 255 && $3 <= 255 && $4 <= 255 ')
if [ -z $VALID_IP ]; then
  echo -e "${RED}${BOLD}Please enter a valid IP address\n\n"
  exit 1
fi

## check if Domain is set
if [ ! -n "$DOMAIN" ]; then
  echo -e "${RED}${BOLD}Domain parameter not supplied. \n\n"
  exit 1
fi

## Backup /etc/hosts to  hosts.timestamp.bak

TIMESTAMP=$(date +%s)

cp /etc/hosts /etc/hosts.$TIMESTAMP.bak

## output ip and domain to /etc/hosts/

echo "$IP $DOMAIN " >>/etc/hosts

## check echo exit code

if [ $? -ne 0 ]; then
  echo -e "${RED}${BOLD}FAILED to add Domain \n\n"
  exit 1
fi

cat /etc/hosts

echo -e "${GREEN}${BOLD}Domain add successfull"

exit 0
