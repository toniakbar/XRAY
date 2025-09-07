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
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$y         \e[33m❇ DNS CHANGER ❇\033[0m         $wh"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
udns=$(cat /user/current)
echo -e ""
echo -e "  ${YB}Current DNS${NC} : ${GB}$udns${WB}"
echo -e ""
echo -e " [\e[36m•1\e[0m] Google DNS"
echo -e " [\e[36m•2\e[0m] Cloudflare DNS"
echo -e " [\e[36m•3\e[0m] Custom DNS"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " [\e[31m•0\e[0m] \e[31mBACK TO MENU\033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -p "Select From Options [ 1 - 3 ] : " dns
echo -e ""
case $dns in
     1)
          clear
          echo -e " "
          echo -e "${GB}Setup Google DNS${NC}"
          cat > /etc/systemd/resolved.conf << END
[Resolve]
DNS=8.8.8.8 8.8.4.4
Domains=~.
ReadEtcHosts=yes
END
          systemctl restart resolvconf
          systemctl restart systemd-resolved
          systemctl restart NetworkManager
          echo "Google DNS" > /user/current
          echo -e "${GB}Setup Completed${NC}"
          sleep 1.5
          clear
          changer
          ;;
     2)
          clear
          echo -e " "
          echo -e "${GB}Setup Cloudflare DNS${NC}"
          cat > /etc/systemd/resolved.conf << END
[Resolve]
DNS=1.1.1.1 1.0.0.1
Domains=~.
ReadEtcHosts=yes
END
          systemctl restart resolvconf
          systemctl restart systemd-resolved
          systemctl restart NetworkManager
          echo "Cloudflare DNS" > /user/current
          echo -e "${GB}Setup Completed${NC}"
          sleep 1.5
          clear
          changer
          ;;
     3)
          clear
          echo -e " "
          read -p "Please Insert Custom DNS (IPv4 Only): " custom
          if [ -z $custom ]; then
               echo " "
               echo "Please Insert Custom DNS !!!"
               sleep 1
               clear
               changer
          fi
          echo -e "${YB}Setup Custom DNS${NC}"
          cat > /etc/systemd/resolved.conf << END
[Resolve]
DNS=$custom
Domains=~.
ReadEtcHosts=yes
END
          systemctl restart resolvconf
          systemctl restart systemd-resolved
          systemctl restart NetworkManager
          echo "Custom DNS" > /user/current
          echo -e "${GB}Setup Completed${NC}"
          sleep 1.5
          clear
          changer
          ;;
     0)
          clear
          menu
          ;;
     *)
          echo -e "${GB}Please enter an correct number${NC}"
          sleep 1
          changer
          ;;
esac
