#!/bin/bash

# Colors
COLOR_OFF='\033[0m'       # Text Reset
RED='\033[0;31m'          # Red
GREEN='\033[0;32m'        # Green
NC=$'\e[0m'               # No Color 
BOLD=$(tput bold)


echo ''
echo '8888888888 8888888b.  8888888 88888888888       888    888  .d88888b.   .d8888b.  88888888888  .d8888b.  '
echo '888        888  "Y88b   888       888           888    888 d88P" "Y88b d88P  Y88b     888     d88P  Y88b '
echo '888        888    888   888       888           888    888 888     888 Y88b.          888     Y88b.      '
echo '8888888    888    888   888       888           8888888888 888     888  "Y888b.       888      "Y888b.   '
echo '888        888    888   888       888           888    888 888     888     "Y88b.     888         "Y88b. '
echo '888        888    888   888       888           888    888 888     888       "888     888           "888 '
echo '888        888  .d88P   888       888           888    888 Y88b. .d88P Y88b  d88P     888     Y88b  d88P '
echo -e "8888888888 8888888P\"  8888888     888           888    888  \"Y88888P\"   \"Y8888P\"      888      \"Y8888P\"  ${RED}${BOLD}V 0.1 ${NC} \n\n"                                                                       
echo "Github Repository https://github.com/ErvisTusha/Edit-hosts"
echo -e "Creator: ${RED}${BOLD} Ervis Tusha ${NC}  Contact : ${RED}${BOLD}https://twitter.com/ET ${NC} \n"
echo -e "usage:\n"
echo "addhost IP DOMAIN"
echo -e "addhost 1.1.1.1 example.com\n"
echo "rmhost IP or DOMAIN"
echo "rmhost 1.1.1.1"
echo "rmhost example.com"
echo "rmhost 1.1.1.1 example.com"
echo -e "\n\n\n\n${RED}${BOLD}"
## check if user has root permission

if [ $EUID -ne 0 ] 
then
   echo "You must have root permission to install."
   echo -e "\n\n\n\n"
   exit 1
fi


cp addhost.sh /usr/local/bin/addhost
#chmod +x /usr/local/bin/addhost

cp rmhost.sh /usr/local/bin/rmhost
#chmod +x /usr/local/bin/rmhost


if [ ! -f "/usr/local/bin/addhost" ]; then
    echo "Failed to copy addhost to /usr/local/bin/addhost ."
    echo -e "\n\n\n\n"
    exit 1
fi

if [ ! -f "/usr/local/bin/rmhost" ]; then
    echo "Failed to copy rmhost to /usr/local/bin/rmhost ."
    echo -e "\n\n\n\n"
    exit 1
fi

echo "Installaion finished successfully"
echo -e "\n\n\n\n"
exit 0