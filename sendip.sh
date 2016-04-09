#!/bin/bash
# Obtener IP externa y enviarla por email
usuario="Marcelo"
horario=$(date +"%Y-%m-%d-%H-%M-%S")
maquina=$HOSTNAME
llavePrivada="abcdefghijklmnopqrstuvwxyz012345" # <-------- modificar

emailInforme="xxxxxxx@somemail.com"

declare -a arr=("ipecho.net/plain" "ident.me" "tnx.nl/ip" "ip.appspot.com" "https://shtuff.it/myip/short/" "whatismyip.akamai.com" "icanhazip.com" "wgetip.com" "ip.tyk.nu" "corz.org/ip" "bot.whatismyipaddress.com" "ipof.in/txt" "eth0.me/")
IP=$(curl -s --retry 3 --retry-delay 10 ipecho.net/plain)

while [ -z "$IP" ] # If no IP found yet, keep trying!
do
  sleep 10
  IP=$(curl -s --retry 3 --retry-delay 10 ${arr[$((  RANDOM % ${#arr[@]}  ))]})
done

# Enviar el reporte por e-mail
echo "$IP $usuario $horario $maquina " | mail -s "$maquina" $emailInforme

# Obtener la temperatura del sensor temp1 en la linea 3

temp=""
sensors | while read line ; do
   read line
   read line
   temp=$(echo $line | cut  -b 8-12)
   #echo $temp
   t1="temp:"$temp

   curl "https://emoncms.org/input/post.json?node=1&apikey="$llavePrivada"&json="$t1 > /dev/null
   read line
   read line
done

exit 0
