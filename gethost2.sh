#!/bin/bash

# NombreHosts es el nombre del servidor tal cual aparece en /etc/hosts
NombreHost="myippublico"
# Cuenta de Twitter de la que se obtienen las direcciones
NombreTwitter="aanimalman"

# Listar a /tmp/twits.txt los twits
echo "/again "$NombreTwitter | ttytter -script > /tmp/twits.txt

# Recorrer el archivo linea por linea buscando el host NombreHost
cat /tmp/twits.txt | while read linea
do
   NombreHostTW=$(echo $linea | cut -d'=' -f 2 | cut -d'_' -f 1)
   if [[ $NombreHostTW == $NombreHost ]]
   then
     echo $(echo $linea | cut -d'=' -f 3 | cut -d'_' -f 1) > /tmp/iphost.txt     # Guardar IP Publiacado en /tmp/iphosts.txt
   fi                                                                            # Si hay mas de un IP para NombreHost permanece el ultimo
done

read -r IPPU < /tmp/iphost.txt                                                   # Leer ip desde /tmp/iphosts.txt

# Crea arch. temporal de trabajo
if [ -f /tmp/hostx ]
then
  rm /tmp/hostx
  touch /tmp/hostx
else
  touch /tmp/hostx
fi

# Lee linea por linea el arch /etc/hosts buscando NombreHosts
# para reemplazar la IP guardada en /tmp/hostx
cat /etc/hosts | while read line
do
  nameTemp=$(echo $line | cut  -d' ' -f 2)
  if [[ $nameTemp == $NombreHost ]]
  then
    echo $IPPU "	" $NombreHost  >> /tmp/hostx
  else
    echo $line  >> /tmp/hostx
  fi
done

# Resguarda /etc/hosts y lo actualiza 
#rm /etc/hosts.old -y
mv /etc/hosts /etc/hosts.old
mv /tmp/hostx /etc/hosts

#cat /tmp/hostx

# Crear /tablero/index.html

comilla="\""
menor="<"
mayor=">"
dividir="/"
exclamacion="!"

cat /home/marcelo/prometeo/cabeza.html > /var/www/html/tablero/index.html

linea="<a target="$comilla"_blank"$comilla ; echo $linea >> /var/www/html/tablero/index.html
linea=" href="$comilla"http://"$IPPU":9091"$comilla" "$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea="  <img src="$comilla"torrent.png"$comilla; echo $linea >> /var/www/html/tablero/index.html
linea="  style="$comilla"width:84px;height:84px;"; echo $linea >> /var/www/html/tablero/index.html
linea="  border:0"$comilla$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=$menor$exclamacion"--  Torents  --"$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=" "$menor$dividir"a"$mayor; echo $linea >> /var/www/html/tablero/index.html

linea="<a target="$comilla"_blank"$comilla ; echo $linea >> /var/www/html/tablero/index.html
linea=" href="$comilla"http://"$IPPU"/owncloud"$comilla" "$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea="  <img src="$comilla"owncloud.png"$comilla; echo $linea >> /var/www/html/tablero/index.html
linea="  style="$comilla"width:84px;height:84px;"; echo $linea >> /var/www/html/tablero/index.html
linea="  border:0"$comilla$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=$menor$exclamacion"--  OwnCloud  --"$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=" "$menor$dividir"a"$mayor; echo $linea >> /var/www/html/tablero/index.html

linea="<a target="$comilla"_blank"$comilla ; echo $linea >> /var/www/html/tablero/index.html
linea=" href="$comilla"ftp://"$IPPU$comilla" "$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea="  <img src="$comilla"ftp.png"$comilla; echo $linea >> /var/www/html/tablero/index.html
linea="  style="$comilla"width:84px;height:84px;"; echo $linea >> /var/www/html/tablero/index.html
linea="  border:0"$comilla$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=$menor$exclamacion"--  FTP  --"$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=" "$menor$dividir"a"$mayor; echo $linea >> /var/www/html/tablero/index.html

linea="<a target="$comilla"_blank"$comilla ; echo $linea >> /var/www/html/tablero/index.html
linea=" href="$comilla"http://"$IPPU":8080"$comilla" "$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea="  <img src="$comilla"wifi.png"$comilla; echo $linea >> /var/www/html/tablero/index.html
linea="  style="$comilla"width:84px;height:84px;"; echo $linea >> /var/www/html/tablero/index.html
linea="  border:0"$comilla$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=$menor$exclamacion"--  Wi-Fi  --"$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=" "$menor$dividir"a"$mayor; echo $linea >> /var/www/html/tablero/index.html

linea="<a target="$comilla"_blank"$comilla ; echo $linea >> /var/www/html/tablero/index.html
linea=" href="$comilla"http://"$IPPU":80"$comilla" "$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea="  <img src="$comilla"apache-logo.png"$comilla; echo $linea >> /var/www/html/tablero/index.html
linea="  style="$comilla"width:84px;height:84px;"; echo $linea >> /var/www/html/tablero/index.html
linea="  border:0"$comilla$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=$menor$exclamacion"--  Apache2  --"$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=" "$menor$dividir"a"$mayor; echo $linea >> /var/www/html/tablero/index.html

linea="<a target="$comilla"_blank"$comilla ; echo $linea >> /var/www/html/tablero/index.html
linea=" href="$comilla"http://google.com.ar"$comilla" "$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea="  <img src="$comilla"google.png"$comilla; echo $linea >> /var/www/html/tablero/index.html
linea="  style="$comilla"width:84px;height:84px;"; echo $linea >> /var/www/html/tablero/index.html
linea="  border:0"$comilla$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=$menor$exclamacion"--  Google  --"$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=" "$menor$dividir"a"$mayor; echo $linea >> /var/www/html/tablero/index.html

linea="<a target="$comilla"_blank"$comilla ; echo $linea >> /var/www/html/tablero/index.html
linea=" href="$comilla"http://"$IPPU"/yoga"$comilla" "$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea="  <img src="$comilla"www.png"$comilla; echo $linea >> /var/www/html/tablero/index.html
linea="  style="$comilla"width:84px;height:84px;"; echo $linea >> /var/www/html/tablero/index.html
linea="  border:0"$comilla$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=$menor$exclamacion"-- WWW yoga  --"$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=" "$menor$dividir"a"$mayor; echo $linea >> /var/www/html/tablero/index.html

linea="<a target="$comilla"_blank"$comilla ; echo $linea >> /var/www/html/tablero/index.html
linea=" href="$comilla"http://"$IPPU"/luis"$comilla" "$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea="  <img src="$comilla"www.png"$comilla; echo $linea >> /var/www/html/tablero/index.html
linea="  style="$comilla"width:84px;height:84px;"; echo $linea >> /var/www/html/tablero/index.html
linea="  border:0"$comilla$dividir$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=$menor$exclamacion"-- WWW Luis --"$mayor; echo $linea >> /var/www/html/tablero/index.html
linea=" "$menor$dividir"a"$mayor; echo $linea >> /var/www/html/tablero/index.html

cat /home/marcelo/prometeo/cola.html >> /var/www/html/tablero/index.html
