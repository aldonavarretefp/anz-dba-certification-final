# Autor: Navarrete Zamora Aldo Yael
# Fecha: 
# Descripción: Script para crear un contenedor con la imagen de Oracle Linux 7.9 y Oracle Database 19c

#!/bin/bash

echo "Creando contenedor"

docker run -i -t -v /tmp/.X11-unix:/tmp/.X11-unix -v /unam:/unam -v /mnt/disco-aldo-mint/unam/diplo-bd:/unam/diplo-bd --name c8-diplo-anz --hostname d6-diplo-anz.fi.unam --expose 1521 --expose 5500 --shm-size=2g -e DISPLAY=$DISPLAY ol-anz:1.0 bash
