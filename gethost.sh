#!/bin/bash
# Este archivo contiene la clabe de actualizacion
# El los permisos deben ser : chmod  700

# Llavepublica es read API key que aparece en https://emoncms.org/user/view
# es necezario registrarse 
LlavePublica="123456789abcdefghijklmnñopqrstuv" # < ------------------------- modificar

# NombreHosts es el nombre del servidor tal cual aparece en /etc/hosts
NombreHost="myippublico"

#Consulta en la pagina de emoncms.org el IP del ultimo ingreso de datos
IPPU=$(curl https://emoncms.org/myip/set.json?apikey=$LlavePublica)
IPPU=$(echo $IPPU| cut -b 20-35)
IPPU=$(echo $IPPU| cut -d'"' -f 1)

# Crea arch. temporal de trabajo
if [ -f /tmp/hostx ]
then
  rm /tmp/hostx
  touch /tmp/hostx
else 
  touch /tmp/hostx
fi

# Lee linea por linea el arch /etc/hosts buscando NombreHosts  
# para reemplazar la IP publicada en  emoncms.org
cat /etc/hosts | while read line 
do
  nameTemp=$(echo $line | cut  -d' ' -f 2)
  if [[ $nameTemp == $NombreHost ]]; then
    nameTemp=$(echo $line | cut  -d' ' -f 2)
    echo $IPPU "        " $nameTemp >> /tmp/hostx
  else
    echo $line  >> /tmp/hostx
  fi
done

# Resguarda /etc/hosts y lo actualiza 
mv /etc/hosts /etc/hosts.old
mv /tmp/hostx /etc/hosts

exit 0
