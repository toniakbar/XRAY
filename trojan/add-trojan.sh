#!/bin/bash
NC='\033[0;37m'
DEFBOLD='\e[39;0m'
RB='\033[0;36m'
GB='\033[0;37m'
YB='\e[33;1m'
BB='\033[0;34m'
MB='\033[0;33m'
CB='\e[35;1m'
WB='\e[37;0m'
clear
domain=$(cat /usr/local/etc/xray/domain)
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m         ❇ TROJAN ACCOUNT ❇       \033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -rp "User: " -e user
user_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)
if [[ ${user_EXISTS} == '1' ]]; then
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m         ❇ TROJAN ACCOUNT ❇       \033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${GB}A client with the specified name was already created, please choose another name.${NC}"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m          ❇ Digital-Net ❇         \033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
add-trojan
fi
done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
sed -i '/#trojan$/a\#& '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#trojan-grpc$/a\#& '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
trojanlink1="trojan://$uuid@$domain:443?path=/trojan&security=tls&host=$domain&type=ws&sni=$domain#$user"
trojanlink2="trojan://${uuid}@$domain:80?path=/trojan&security=none&host=$domain&type=ws#$user"
trojanlink3="trojan://${uuid}@$domain:443?security=tls&encryption=none&type=grpc&serviceName=trojan-grpc&sni=$domain#$user"
cat > /var/www/html/trojan/trojan-$user.txt << END
==========================
Trojan WS (CDN) TLS
==========================
- name: Trojan-$user
server: $domain
port: 443
type: trojan
password: $uuid
network: ws
sni: $domain
skip-cert-verify: true
udp: true
ws-opts:
path: /trojan
headers:
Host: $domain
==========================
Trojan gRPC (CDN)
==========================
- name: Trojan-$user
server: $domain
port: 443
type: trojan
password: $uuid
network: grpc
sni: $domain
skip-cert-verify: true
udp: true
grpc-opts:
grpc-service-name: "trojan-grpc"
==========================
Link Trojan Account
==========================
Link TLS  : trojan://$uuid@$domain:443?path=/trojan&security=tls&host=$domain&type=ws&sni=$domain#$user
==========================
Link NTLS : trojan://${uuid}@$domain:80?path=/trojan&security=none&host=$domain&type=ws#$user
==========================
Link gRPC : trojan://${uuid}@$domain:443?security=tls&encryption=none&type=grpc&serviceName=trojan-grpc&sni=$domain#$user
==========================
END
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
systemctl restart xray
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-trojan-$user.txt
echo -e "\e[33m         ❇ TROJAN ACCOUNT ❇       \033[0m" | tee -a /user/log-trojan-$user.txt
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-trojan-$user.txt
echo -e "Remarks        : ${user}" | tee -a /user/log-trojan-$user.txt
echo -e "ISP            : $ISP" | tee -a /user/log-trojan-$user.txt
echo -e "City           : $CITY" | tee -a /user/log-trojan-$user.txt
echo -e "Host/IP        : ${domain}" | tee -a /user/log-trojan-$user.txt
echo -e "Wildcard       : (bug.com).${domain}" | tee -a /user/log-trojan-$user.txt
echo -e "Port TLS       : 443" | tee -a /user/log-trojan-$user.txt
echo -e "Port NTLS      : 80" | tee -a /user/log-trojan-$user.txt
echo -e "Port gRPC      : 443" | tee -a /user/log-trojan-$user.txt
echo -e "Alt Port TLS   : 2053, 2083, 2087, 2096, 8443" | tee -a /user/log-trojan-$user.txt
echo -e "Alt Port NTLS  : 8080, 8880, 2052, 2082, 2086, 2095" | tee -a /user/log-trojan-$user.txt
echo -e "Password       : ${uuid}" | tee -a /user/log-trojan-$user.txt
echo -e "Network        : Websocket, gRPC" | tee -a /user/log-trojan-$user.txt
echo -e "Path           : /trojan" | tee -a /user/log-trojan-$user.txt
echo -e "ServiceName    : trojan-grpc" | tee -a /user/log-trojan-$user.txt
echo -e "Alpn           : h2, http/1.1" | tee -a /user/log-trojan-$user.txt
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-trojan-$user.txt
echo -e "Link TLS       : ${trojanlink1}" | tee -a /user/log-trojan-$user.txt
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-trojan-$user.txt
echo -e "Link NTLS      : ${trojanlink2}" | tee -a /user/log-trojan-$user.txt
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-trojan-$user.txt
echo -e "Link gRPC      : ${trojanlink3}" | tee -a /user/log-trojan-$user.txt
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-trojan-$user.txt
echo -e "Format Clash   : http://$domain:8000/trojan/trojan-$user.txt" | tee -a /user/log-trojan-$user.txt
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-trojan-$user.txt
echo -e "Expired On     : $exp" | tee -a /user/log-trojan-$user.txt
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-trojan-$user.txt
echo " " | tee -a /user/log-trojan-$user.txt
echo " " | tee -a /user/log-trojan-$user.txt
echo " " | tee -a /user/log-trojan-$user.txt
read -n 1 -s -r -p "Press any key to back on menu"
clear
trojan
