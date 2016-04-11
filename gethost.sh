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
mv /etc/hosts /etc/hosts.old
mv /tmp/hostx /etc/hosts

#cat /tmp/hostx

exit 0
