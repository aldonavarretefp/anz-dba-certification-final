#@Autor: Aldo Yael Navarrete Zamora
#@Fecha creación: 24/11/2024
#@Descripción: Creación de directorios para data files, control files y Redo Logs

#!/bin/bash
set -e

echo "Verificando existencia de directorio para data files"

diplo_proyecto_final_dir="/unam/diplo-bd/proyecto-final"

if [ -d "/opt/oracle/oradata/${ORACLE_SID^^}" ]; then
  echo "Directorio para data files ya existe, se omite creación"
else
  echo "1. Creando directorios para data files de cdb$root"  
  cd /opt/oracle
  mkdir -p oradata/${ORACLE_SID^^}
  chown -R oracle:oinstall oradata
  chmod -R 750 oradata  
fi;

echo "Verificando existencia de directorio para pdb$seed"
#--TODO
if [ -d "/opt/oracle/oradata/${ORACLE_SID^^}/pdbseed" ]; then
  echo "Directorio para pdb$seed ya existe, se omite creación"
else
  echo "2. Creando directorios para pdb$seed"
  cd /opt/oracle/oradata/${ORACLE_SID^^}
  mkdir -p pdbseed
  chown -R oracle:oinstall pdbseed
  chmod -R 750 pdbseed
fi;
#TODO--

echo "3. Creando directorios para Redo Logs y control files"
#--TODO
for i in $(seq 1 3); do
  if [ -d "${diplo_proyecto_final_dir}/disk/d0${i}/app/oracle/oradata/${ORACLE_SID^^}" ]; then
    echo "Directorio para control files y Redo Logs ya existe, se omite creación"
  else
    echo "Creando directorios para control files y Redo Logs"
    cd ${diplo_proyecto_final_dir}/disk/d0${i}
    mkdir -p app/oracle/oradata/${ORACLE_SID^^}
    chown -R oracle:oinstall app
    chmod -R 750 app
  fi;
done
#TODO--

#--TODO
# rm -f /opt/oracle/oradata/${ORACLE_SID^^}/*.dbf
# rm -f /opt/oracle/oradata/${ORACLE_SID^^}/control*.ctl
# rm -f /opt/oracle/oradata/${ORACLE_SID^^}/redo*.log

# rm -f /opt/oracle/oradata/${ORACLE_SID^^}/pdbseed/*.dbf
# rm -f /opt/oracle/oradata/${ORACLE_SID^^}/pdbseed/control*.ctl
# rm -f /opt/oracle/oradata/${ORACLE_SID^^}/pdbseed/redo*.log

# rm -f ${diplo_proyecto_final_dir}/disk/d0*/app/oracle/oradata/${ORACLE_SID^^}/control*.ctl
# rm -f ${diplo_proyecto_final_dir}/disk/d0*/app/oracle/oradata/${ORACLE_SID^^}/redo*.log
# rm -f ${diplo_proyecto_final_dir}/disk/d0*/app/oracle/oradata/${ORACLE_SID^^}/*.dbf

# rm -f ${diplo_proyecto_final_dir}/disk/d0*/app/oracle/oradata/${ORACLE_SID^^}/pdbseed/*.dbf
# rm -f ${diplo_proyecto_final_dir}/disk/d0*/app/oracle/oradata/${ORACLE_SID^^}/pdbseed/control*.ctl
# rm -f ${diplo_proyecto_final_dir}/disk/d0*/app/oracle/oradata/${ORACLE_SID^^}/pdbseed/redo*.log
#TODO--

echo "5. Mostrando directorio de data files"
ls -l /opt/oracle/oradata

echo "Mostrando directorios para control files y Redo Logs"
ls -l ${diplo_proyecto_final_dir}/disk/d0*/app/oracle/oradata