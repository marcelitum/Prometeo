#!/bin/bash
# Obtener IP externa y enviarla por email
usuario="Marcelo"
usuarioTwitter="@AAnimalMan"
horario=$(date +"%Y-%m-%d-%H-%M-%S")
maquina=$HOSTNAME
emailInforme="marcelo_f@hotmail.com"
NombreHost="myippublico"

declare -a arr=("ipecho.net/plain" "ident.me" "tnx.nl/ip" "ip.appspot.com" "https://shtuff.it/myip/short/" "whatismyip.akamai.com" "icanhazip.com" "wgetip.com" "ip.tyk.nu" "corz.org/ip" "bot.whatismyipaddress.com" "ipof.in/txt" "eth0.me/")
IP=$(curl -s --retry 3 --retry-delay 10 ipecho.net/plain)

while [ -z "$IP" ] # If no IP found yet, keep trying!
do
  sleep 10
  IP=$(curl -s --retry 3 --retry-delay 10 ${arr[$((  RANDOM % ${#arr[@]}  ))]})
done

# Enviar el reporte por e-mail
temp2="NombreHost="$NombreHost"_WanIP="$IP"_Hora="$horario"_Maquina="$HOSTNAME"_#ipdinamico"
echo "$temp2 " | mail -s "$IP" $emailInforme

echo "$IP $usuario $horario $maquina " | mail -s "$maquina titulo" marcelo_f@hotmail.com

temp2=" /dm "$usuarioTwitter" NombreHost="$NombreHost"_WanIP="$IP"_Hora="$horario"_Maquina="$HOSTNAME"_#ipdinamico"

echo $temp2 | ttytter -script

exit 0
