#@Autor: <Nombre del autor o autores> 
#@Fecha creación: <Fecha de creación> 
#@Descripción: Crear las 10 carpetas que se van a utilizar para la simulación de los 10 discos duros

# Whenever this scripts fail it will stop
set -e

#!/bin/bash
dba_proyecto_final_dir="/unam/diplo-bd/proyecto-final"

echo "1. Creando los 10 directorios de los discos duros..."  

for i in {1..10}
do
    mkdir -p "${dba_proyecto_final_dir}/d$i"
done

echo "listando"

ls -lh "${dba_proyecto_final_dir}"

echo '1.1. Cambiando los permisos para que se pueda acceder a los directorios'
chmod 777 "${dba_proyecto_final_dir}/d*"

echo "2. Mostrando la creación de los directorios"
ls -l "${dba_proyecto_final_dir}"

