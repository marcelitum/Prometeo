#!/bin/bash
# Obtener IP externa y enviarla por email

usuario=$USER
horario=$(date +"%Y-%m-%d-%H-%M-%S")

declare -a arr=("ipecho.net/plain" "ident.me" "tnx.nl/ip" "ip.appspot.com" "https://shtuff.it/myip/short/" "whatismyip.akamai.com" "icanhazip.com" "wgetip.com" "ip.tyk.nu" "corz.org/ip" "bot.whatismyipaddress.com" "ipof.in/txt" "eth0.me/")
IP=$(curl -s --retry 3 --retry-delay 10 ipecho.net/plain)

while [ -z "$IP" ] # If no IP found yet, keep trying!
do
    sleep 30
    IP=$(curl -s --retry 3 --retry-delay 10 ${arr[$((  RANDOM % ${#arr[@]}  ))]})  
done

echo "$IP $usuario $horario"
echo "$IP $usuario $horario" > ProSerAct.txt
echo "$IP $usuario $horario" | mail -s "$IP $usuario $horario " marcelo_f@hotmail.com
echo "$IP $usuario $horario" | mail -s "$IP $usuario $horario " marcelitum3@gmail.com

exit 0
