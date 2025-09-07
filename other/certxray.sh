#!/bin/bash
DEFBOLD='\e[39;1m'
RB='\033[0;36m'
GB='\033[0;32m'
YB='\e[33;1m'
BB='\033[0;34m'
MB='\033[0;33m'
CB='\e[35;1m'
WB='\e[37;1m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0;37m'
RED='\033[0;31m'
green='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
NC='\033[0;37m'
KN='\033[0;33m'
ORANGE='\033[0;33m'
PINK='\033[0;35m'
clear
echo -e "${GB}[ INFO ]${NC} ${YB}Start${NC} "
sleep 0.5
systemctl stop nginx
domain=$(cat /var/lib/dnsvps.conf | cut -d'=' -f2)
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ -n $Cek ]]; then
     sleep 1
     echo -e "${RB}[ WARNING ]${NC} ${YB}Detected port 80 used by $Cek${NC} "
     systemctl stop $Cek
     sleep 2
     echo -e "${GB}[ INFO ]${NC} ${YB}Processing to stop $Cek${NC} "
     sleep 1
fi
echo -e "${GB}[ INFO ]${NC} ${YB}Starting renew cert...${NC} "
sleep 2
cd .acme.sh
bash acme.sh --issue -d $domain --server letsencrypt --keylength ec-256 --fullchain-file /usr/local/etc/xray/fullchain.crt --key-file /usr/local/etc/xray/private.key --standalone --force
echo -e "${GB}[ INFO ]${NC} ${YB}Renew cert done...${NC} "
sleep 2
echo -e "${GB}[ INFO ]${NC} ${YB}Starting service $Cek${NC} "
sleep 2
echo "$domain" > /usr/local/etc/xray/domain
systemctl restart $Cek
systemctl restart nginx
echo -e "${GB}[ INFO ]${NC} ${YB}All finished...${NC} "
sleep 0.5
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
