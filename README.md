# Prometeo (en desarrollo)
Montar unidades remotas en IPs dinámicos
----------------------------------------

Monta en un sistema de archivos, una unidad remota de otra PC (servidor) 

ej : 213.180.159.210/media/USBnn ---> /mnt/USBnn
     remoto                           local

De esta manera podemos copiar o modificar por medio de cualquier navegador de archivos el contenido alojado en el servidor aunque este tenga una IP dinámica .

*Utiliza el servicio SSMTP para enviar la dirección de IP (en caso de actualización) a el o los clientes.

*Utiliza SSHFS para montar la partición.

*El SSH debe estar instalado y las llaves en clientes/servidor configuradas

Pretende ser una nube personal
Una nube nativa
Algo así 

Marcelo
