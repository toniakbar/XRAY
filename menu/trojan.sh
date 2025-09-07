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
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m          ❇ TROJAN MENU ❇         \033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " [\e[36m•1\e[0m] Create Account Trojan "
echo -e " [\e[36m•2\e[0m] Trial Account Trojan "
echo -e " [\e[36m•3\e[0m] Extending Account Trojan "
echo -e " [\e[36m•4\e[0m] Delete Account Trojan "
echo -e " [\e[36m•5\e[0m] Check User Login Trojan "
echo -e ""
echo -e " [\e[31m•0\e[0m] \e[31mBACK TO MENU\033[0m"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m          ❇ Digital-Net ❇         \033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu :  " opt
echo -e ""
case $opt in
     1)
          clear
          add-trojan
          exit
          ;;
     2)
          clear
          trialtrojan
          exit
          ;;
     3)
          clear
          extend-trojan
          exit
          ;;
     4)
          clear
          del-trojan
          exit
          ;;
     5)
          clear
          cek-trojan
          exit
          ;;
     0)
          clear
          menu
          exit
          ;;
     x) exit ;;
     *)
          echo -e "salah tekan "
          sleep 1
          trojan
          ;;
esac
