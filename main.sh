
#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
BRed='\e[1;31m'
BGreen='\e[1;32m'
BYellow='\e[1;33m'
BBlue='\e[1;34m'
NC='\e[0m'
BGreen='\e[1;32m'
NC='\033[0;37m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\033[0;32m'
YB='\033[0;32m'
BB='\033[0;34m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
clear
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install socat netfilter-persistent -y
apt install vnstat lsof fail2ban -y
apt install curl sudo -y
apt install screen cron screenfetch -y
mkdir /backup >> /dev/null 2>&1
mkdir /user >> /dev/null 2>&1
mkdir /tmp >> /dev/null 2>&1
apt install resolvconf network-manager dnsutils bind9 -y
cat > /etc/systemd/resolved.conf << END
[Resolve]
DNS=8.8.8.8
ReadEtcHosts=yes
END
systemctl enable resolvconf
systemctl enable systemd-resolved
systemctl enable NetworkManager
rm -rf /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf
systemctl restart resolvconf
systemctl restart systemd-resolved
systemctl restart NetworkManager
echo "Google DNS" > /user/current
rm /usr/local/etc/xray/city >> /dev/null 2>&1
rm /usr/local/etc/xray/org >> /dev/null 2>&1
rm /usr/local/etc/xray/timezone >> /dev/null 2>&1
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" - install --beta
cp /usr/local/bin/xray /backup/xray.official.backup
curl -s ipinfo.io/city >> /usr/local/etc/xray/city
curl -s ipinfo.io/org | cut -d " " -f 2-10 >> /usr/local/etc/xray/org
curl -s ipinfo.io/timezone >> /usr/local/etc/xray/timezone
clear
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest
clear
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt install nginx -y
cd
rm /var/www/html/*.html
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mkdir -p /var/www/html/trojan
systemctl restart nginx
clear
touch /usr/local/etc/xray/domain
echo -e "\e[33m┌─────────────────────────────────────────────────┐${NC}"
echo -e "\e[33m│ ██████╗ ██╗ ██████╗ ██╗████████╗ █████╗ ██╗	  \033[0m"
echo -e "\e[33m│ ██╔══██╗██║██╔════╝ ██║╚══██╔══╝██╔══██╗██║	  \033[0m"
echo -e "\e[33m│ ██║  ██║██║██║  ███╗██║   ██║   ███████║██║	  \033[0m"
echo -e "\e[33m│ ██║  ██║██║██║   ██║██║   ██║   ██╔══██║██║	  \033[0m"
echo -e "\e[33m│ ██████╔╝██║╚██████╔╝██║   ██║   ██║  ██║███████╗ \033[0m"
echo -e "\e[33m│ ╚═════╝ ╚═╝ ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝ \033[0m"
echo -e "\e[33m│         C\033[0m \e[31mE\033[0m \e[33mL\033[0m \e[34mL\033[0m \e[35mU\033[0m \e[36mL\033[0m \e[32mA\033[0m \e[31mR\033[0m   \e[33mF\033[0m \e[34mR\033[0m \e[35mE\033[0m \e[36mE\033[0m \e[32mD\033[0m O\033[0m \e[32mM\033[0m "
echo -e "\e[33m└─────────────────────────────────────────────────┘${NC}"
echo -e "\e[32m    ❇   Pointing Dulu Domain Di Cloudflare   ❇    ${C}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
echo " "
read -rp "Masukin domain kamu : " -e dns
if [ -z $dns ]; then
echo -e "Nothing input for domain!"
else
echo "$dns" > /usr/local/etc/xray/domain
echo "DNS=$dns" > /var/lib/dnsvps.conf
fi
clear
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
echo -e "\e[32m          ❇  ❇  ❇  Domain Done ❇  ❇  ❇          ${C}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
sleep 0.5
clear
systemctl stop nginx
systemctl stop xray
domain=$(cat /usr/local/etc/xray/domain)
curl https://get.acme.sh | sh
source ~/.bashrc
cd .acme.sh
bash acme.sh --issue -d $domain --server letsencrypt --keylength ec-256 --fullchain-file /usr/local/etc/xray/fullchain.crt --key-file /usr/local/etc/xray/private.key --standalone --force
clear
echo -e "\e[33m┌─────────────────────────────────────────────────┐${NC}"
echo -e "\e[33m│ ██████╗ ██╗ ██████╗ ██╗████████╗ █████╗ ██╗	  \033[0m"
echo -e "\e[33m│ ██╔══██╗██║██╔════╝ ██║╚══██╔══╝██╔══██╗██║	  \033[0m"
echo -e "\e[33m│ ██║  ██║██║██║  ███╗██║   ██║   ███████║██║	  \033[0m"
echo -e "\e[33m│ ██║  ██║██║██║   ██║██║   ██║   ██╔══██║██║	  \033[0m"
echo -e "\e[33m│ ██████╔╝██║╚██████╔╝██║   ██║   ██║  ██║███████╗ \033[0m"
echo -e "\e[33m│ ╚═════╝ ╚═╝ ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝ \033[0m"
echo -e "\e[33m│         C\033[0m \e[31mE\033[0m \e[33mL\033[0m \e[34mL\033[0m \e[35mU\033[0m \e[36mL\033[0m \e[32mA\033[0m \e[31mR\033[0m   \e[33mF\033[0m \e[34mR\033[0m \e[35mE\033[0m \e[36mE\033[0m \e[32mD\033[0m O\033[0m \e[32mM\033[0m "
echo -e "\e[33m└─────────────────────────────────────────────────┘${NC}"
echo -e "\e[32m    ❇  ❇  ❇  Setup Nginx & Xray Conf ❇  ❇  ❇    ${C}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
clear
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
echo -e "\e[32m ❇  ❇  ❇  Setup Nginx & Xray Conf Done ❇  ❇  ❇  ${C}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
sleep 0.5
clear
echo "UQ3w2q98BItd3DPgyctdoJw4cqQFmY59ppiDQdqMKbw=" > /usr/local/etc/xray/serverpsk
wget -q -O /usr/local/etc/xray/config.json https://raw.githubusercontent.com/toniakbar/XRAY/lite/other/config.json
wget -q -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/toniakbar/XRAY/lite/other/nginx.conf
rm -rf /etc/nginx/conf.d/xray.conf
wget -q -O /etc/nginx/conf.d/xray.conf https://raw.githubusercontent.com/toniakbar/XRAY/lite/other/xray.conf
systemctl restart nginx
systemctl restart xray
clear
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
echo -e "\e[32m          ❇  ❇  ❇  Setup Done ❇  ❇  ❇           ${C}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
sleep 0.5
clear
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
cd /usr/bin
clear
echo -e "\e[33m┌─────────────────────────────────────────────────┐${NC}"
echo -e "\e[33m│ ██████╗ ██╗ ██████╗ ██╗████████╗ █████╗ ██╗	  \033[0m"
echo -e "\e[33m│ ██╔══██╗██║██╔════╝ ██║╚══██╔══╝██╔══██╗██║	  \033[0m"
echo -e "\e[33m│ ██║  ██║██║██║  ███╗██║   ██║   ███████║██║	  \033[0m"
echo -e "\e[33m│ ██║  ██║██║██║   ██║██║   ██║   ██╔══██║██║	  \033[0m"
echo -e "\e[33m│ ██████╔╝██║╚██████╔╝██║   ██║   ██║  ██║███████╗ \033[0m"
echo -e "\e[33m│ ╚═════╝ ╚═╝ ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝ \033[0m"
echo -e "\e[33m│         C\033[0m \e[31mE\033[0m \e[33mL\033[0m \e[34mL\033[0m \e[35mU\033[0m \e[36mL\033[0m \e[32mA\033[0m \e[31mR\033[0m   \e[33mF\033[0m \e[34mR\033[0m \e[35mE\033[0m \e[36mE\033[0m \e[32mD\033[0m O\033[0m \e[32mM\033[0m "
echo -e "\e[33m└─────────────────────────────────────────────────┘${NC}"
echo -e "\e[32m    ❇  ❇  ❇  Downloading Main Menu  ❇  ❇  ❇      ${C}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
wget -q -O menu "https://raw.githubusercontent.com/toniakbar/XRAY/lite/menu/menu.sh"
wget -q -O trojan "https://raw.githubusercontent.com/toniakbar/XRAY/lite/menu/trojan.sh"
clear
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
echo -e "\e[32m  ❇  ❇  ❇  Downloading Main Menu Done ❇  ❇  ❇   ${C}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
sleep 0.5
clear
echo -e "\e[33m┌─────────────────────────────────────────────────┐${NC}"
echo -e "\e[33m│ ██████╗ ██╗ ██████╗ ██╗████████╗ █████╗ ██╗	  \033[0m"
echo -e "\e[33m│ ██╔══██╗██║██╔════╝ ██║╚══██╔══╝██╔══██╗██║	  \033[0m"
echo -e "\e[33m│ ██║  ██║██║██║  ███╗██║   ██║   ███████║██║	  \033[0m"
echo -e "\e[33m│ ██║  ██║██║██║   ██║██║   ██║   ██╔══██║██║	  \033[0m"
echo -e "\e[33m│ ██████╔╝██║╚██████╔╝██║   ██║   ██║  ██║███████╗ \033[0m"
echo -e "\e[33m│ ╚═════╝ ╚═╝ ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝ \033[0m"
echo -e "\e[33m│         C\033[0m \e[31mE\033[0m \e[33mL\033[0m \e[34mL\033[0m \e[35mU\033[0m \e[36mL\033[0m \e[32mA\033[0m \e[31mR\033[0m   \e[33mF\033[0m \e[34mR\033[0m \e[35mE\033[0m \e[36mE\033[0m \e[32mD\033[0m O\033[0m \e[32mM\033[0m "
echo -e "\e[33m└─────────────────────────────────────────────────┘${NC}"
echo -e "\e[32m   ❇  ❇  ❇  Downloading Menu Trojan  ❇  ❇  ❇     ${NC}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
wget -q -O add-trojan "https://raw.githubusercontent.com/toniakbar/XRAY/lite/trojan/add-trojan.sh"
wget -q -O del-trojan "https://raw.githubusercontent.com/toniakbar/XRAY/lite/trojan/del-trojan.sh"
wget -q -O extend-trojan "https://raw.githubusercontent.com/toniakbar/XRAY/lite/trojan/extend-trojan.sh"
wget -q -O trialtrojan "https://raw.githubusercontent.com/toniakbar/XRAY/lite/trojan/trialtrojan.sh"
wget -q -O cek-trojan "https://raw.githubusercontent.com/toniakbar/XRAY/lite/trojan/cek-trojan.sh"
clear
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
echo -e "\e[32m ❇  ❇  ❇  Downloading Menu Trojan Done ❇  ❇  ❇  ${C}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
sleep 0.5
clear
echo -e "\e[33m┌─────────────────────────────────────────────────┐${NC}"
echo -e "\e[33m│ ██████╗ ██╗ ██████╗ ██╗████████╗ █████╗ ██╗	  \033[0m"
echo -e "\e[33m│ ██╔══██╗██║██╔════╝ ██║╚══██╔══╝██╔══██╗██║	  \033[0m"
echo -e "\e[33m│ ██║  ██║██║██║  ███╗██║   ██║   ███████║██║	  \033[0m"
echo -e "\e[33m│ ██║  ██║██║██║   ██║██║   ██║   ██╔══██║██║	  \033[0m"
echo -e "\e[33m│ ██████╔╝██║╚██████╔╝██║   ██║   ██║  ██║███████╗ \033[0m"
echo -e "\e[33m│ ╚═════╝ ╚═╝ ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝ \033[0m"
echo -e "\e[33m│         C\033[0m \e[31mE\033[0m \e[33mL\033[0m \e[34mL\033[0m \e[35mU\033[0m \e[36mL\033[0m \e[32mA\033[0m \e[31mR\033[0m   \e[33mF\033[0m \e[34mR\033[0m \e[35mE\033[0m \e[36mE\033[0m \e[32mD\033[0m O\033[0m \e[32mM\033[0m "
echo -e "\e[33m└─────────────────────────────────────────────────┘${NC}"
echo -e "\e[32m   ❇  ❇  ❇  Downloading Other Menu  ❇  ❇  ❇      ${C}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
wget -q -O xp "https://raw.githubusercontent.com/toniakbar/XRAY/lite/other/xp.sh"
wget -q -O dns "https://raw.githubusercontent.com/toniakbar/XRAY/lite/other/dns.sh"
wget -q -O certxray "https://raw.githubusercontent.com/toniakbar/XRAY/lite/other/certxray.sh"
wget -q -O changer "https://raw.githubusercontent.com/toniakbar/XRAY/lite/other/changer.sh"
wget -q -O clearcache "https://raw.githubusercontent.com/toniakbar/XRAY/lite/other/clearcache.sh"
clear
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
echo -e "\e[32m    ❇  ❇  ❇  Downloading Other Done ❇  ❇  ❇     ${C}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
sleep 0.5
clear
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
echo -e "\e[32m   ❇  ❇  ❇  Download All Menu Done  ❇  ❇  ❇      ${C}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
sleep 0.5
clear
chmod +x add-trojan
chmod +x del-trojan
chmod +x extend-trojan
chmod +x trialtrojan
chmod +x cek-trojan
chmod +x menu
chmod +x trojan
chmod +x xp
chmod +x dns
chmod +x certxray
chmod +x changer
chmod +x clearcache
cd
echo "0 0 * * * root xp" >> /etc/crontab
echo "*/3 * * * * root clear-log" >> /etc/crontab
systemctl restart cron
cat > /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile
if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-ssh.log" ]; then
echo "Log SSH Account " > /etc/log-create-ssh.log
fi
if [ ! -f "/etc/log-create-trojan.log" ]; then
echo "Log Trojan Account " > /etc/log-create-trojan.log
fi
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
curl -sS ipv4.icanhazip.com > /etc/myipvps
echo ""
echo -e "\e[33m┌─────────────────────────────────────────────────┐${NC}"
echo -e "\e[33m│ ██████╗ ██╗ ██████╗ ██╗████████╗ █████╗ ██╗	  \033[0m"
echo -e "\e[33m│ ██╔══██╗██║██╔════╝ ██║╚══██╔══╝██╔══██╗██║	  \033[0m"
echo -e "\e[33m│ ██║  ██║██║██║  ███╗██║   ██║   ███████║██║	  \033[0m"
echo -e "\e[33m│ ██║  ██║██║██║   ██║██║   ██║   ██╔══██║██║	  \033[0m"
echo -e "\e[33m│ ██████╔╝██║╚██████╔╝██║   ██║   ██║  ██║███████╗ \033[0m"
echo -e "\e[33m│ ╚═════╝ ╚═╝ ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝ \033[0m"
echo -e "\e[33m│         C\033[0m \e[31mE\033[0m \e[33mL\033[0m \e[34mL\033[0m \e[35mU\033[0m \e[36mL\033[0m \e[32mA\033[0m \e[31mR\033[0m   \e[33mF\033[0m \e[34mR\033[0m \e[35mE\033[0m \e[36mE\033[0m \e[32mD\033[0m O\033[0m \e[32mM\033[0m "
echo -e "\e[33m└─────────────────────────────────────────────────┘${NC}"
echo -e "\e[32m m»»» Protocol Service «««»»» Network Protocol «««  ${C}"
echo -e "\e[33m┌─────────────────────────────────────────────────┐${NC}"
echo -e "\e[32m         ❇  ❇  ❇  Service & Port ❇  ❇  ❇        ${C}"
echo -e "\e[33m ───────────────────────────────────────────────── ${NC}"
echo -e "\e[32m  - SSL Websocket         ««« »»»          : 443    ${C}"
echo -e "\e[32m  - Nginx                 ««« »»»          : 81     ${C}"
echo -e "\e[32m  - Trojan WS none TLS    ««« »»»          : 80     ${C}"
echo -e "\e[32m  - Trojan WS TLS         ««« »»»          : 443    ${C}"
echo -e "\e[32m  - Trojan gRPC           ««« »»»          : 443    ${C}"
echo -e ""
echo -e "\e[33m└─────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -ne "[ ${yell}WARNING${NC} ] reboot now ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
