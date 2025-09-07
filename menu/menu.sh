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
xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray_service == "running" ]]; then
     status_xray="${GREEN}[ ON ]${NC}"
else
     status_xray="${RED}[ OFF ]${NC}"
fi
if [[ $nginx_service == "running" ]]; then
     status_nginx="${GREEN}[ ON ]${NC}"
else
     status_nginx="${RED}[ OFF ]${NC}"
fi
domain=$(cat /usr/local/etc/xray/domain)
ISP=$(cat /usr/local/etc/xray/org)
WKT=$(cat /usr/local/etc/xray/timezone)
DATE=$(date -R | cut -d " " -f -4)
MYIP=$(curl -sS ipv4.icanhazip.com)
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
clear
echo -e "\e[33m┌─────────────────────────────────────────────────┐${NC}"
echo -e "\e[33m│ ██████╗ ██╗ ██████╗ ██╗████████╗ █████╗ ██╗			\033[0m"
echo -e "\e[33m│ ██╔══██╗██║██╔════╝ ██║╚══██╔══╝██╔══██╗██║		\033[0m"
echo -e "\e[33m│ ██║  ██║██║██║  ███╗██║   ██║   ███████║██║			\033[0m"
echo -e "\e[33m│ ██║  ██║██║██║   ██║██║   ██║   ██╔══██║██║			\033[0m"
echo -e "\e[33m│ ██████╔╝██║╚██████╔╝██║   ██║   ██║  ██║███████╗	\033[0m"
echo -e "\e[33m│ ╚═════╝ ╚═╝ ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝		\033[0m"
echo -e "\e[33m│	 C\033[0m \e[31mE\033[0m \e[33mL\033[0m \e[34mL\033[0m \e[35mU\033[0m \e[36mL\033[0m \e[32mA\033[0m \e[31mR\033[0m   \e[33mF\033[0m \e[34mR\033[0m \e[35mE\033[0m \e[36mE\033[0m \e[32mD\033[0m O\033[0m \e[32mM\033[0m "
echo -e "\e[33m└─────────────────────────────────────────────────┘${NC}"
echo -e "\e[32m ❇\033[0m  NGINX STATUS $status_nginx    \e[32m ❇\033[0m  XRAY STATUS $status_xray   "
echo -e "\e[33m┌─────────────────────────────────────────────────┐${NC}"
echo -e "\e[32m ❇\033[0m  Operating System \e[31m:\033[0m "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
echo -e "\e[32m ❇\033[0m  RAM Used         \e[31m:\033[0m $uram MB"	
echo -e "\e[32m ❇\033[0m  RAM Total        \e[31m:\033[0m $tram MB"
echo -e "\e[32m ❇\033[0m  Public IP        \e[31m:\033[0m $MYIP"
echo -e "\e[32m ❇\033[0m  Service Provider \e[31m:\033[0m $ISP"
echo -e "\e[32m ❇\033[0m  Timezone         \e[31m:\033[0m $WKT"
echo -e "\e[32m ❇\033[0m  Date             \e[31m:\033[0m $DATE"
echo -e "\e[32m ❇\033[0m  Domain           \e[31m:\033[0m $domain"
echo -e "\e[33m└─────────────────────────────────────────────────┘${NC}" 
echo -e "\e[32m                   ❇  \e[31mM\033[0m\e[33m-\033[0m\e[34mE\033[0m\e[35m-\033[0m\e[36mN\033[0m\e[37m-\033[0m\e[31mU\033[0m\e[32m ❇                   \033[0m"
echo -e "\e[33m┌─────────────────────────────────────────────────┐${NC}"
echo -e "\e[33m│\e[32m[1]\033[0m Trojan Menu                    Renew Cert \e[32m[4]\033[0m\e[33m│\033[0m"
echo -e "\e[33m│\e[32m[2]\033[0m Speedtest                     DNS Setting \e[32m[5]\033[0m\e[33m│\033[0m"
echo -e "\e[33m│\e[32m[3]\033[0m Change Domain                  DNS Status \e[32m[6]\033[0m\e[33m│\033[0m"
echo -e "\e[33m└─────────────────────────────────────────────────┘${NC}"
echo -e "\e[32m [x]\033[0m Exit                      Clear RAM Cache\e[32m [c]\033"
echo -e "\e[33m ─────────────────────────────────────────────────${NC}"
echo -e "\e[33m┌─────────────────────────────────────────────────┐${NC}"
echo -e "\e[32m            ❇ \e[34mD\033[0m \e[32mI\033[0m \e[33mG\033[0m \e[31mI\033[0m \e[32mT\033[0m \e[35mA\033[0m \e[36mL\033[0m \e[37m-\033[0m \e[34mN\033[0m \e[33mE\033[0m \e[31mT\033[0m \e[32m❇              \033[0m"
echo -e "\e[33m└─────────────────────────────────────────────────┘${NC}"""
DATE=$(date +'%d %B %Y')
datediff() {
     d1=$(date -d "$1" +%s)
     d2=$(date -d "$2" +%s)
     echo -e " ${BB}│${ICyan}  Expiry In     : ${NC}$(((d1 - d2) / 86400)) ${ORANGE}Days $NC"
}
mai="datediff "$Exp" "$DATE""
read -p " Select Menu :  " opt
echo -e ""
case $opt in
     1)
          clear
          trojan
          ;;
     2)
          clear
          speedtest
          ;;
     3)
          clear
          dns
          ;;
     4)
          clear
          certxray
          ;;
     5)
          clear
          changer
          ;;
     6)
          clear
          resolvectl status
          echo ""
          echo ""
          read -n 1 -s -r -p "Press any key to back on menu"
          echo ""
          echo ""
          menu
          ;;
     c)
          clear 
          clearcache
          ;;
     x)
          clear
          exit
          ;;
     *)
          echo -e "${RB}salah input${NC}"
          sleep 1
          menu
          ;;
esac
