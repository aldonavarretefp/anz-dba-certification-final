

connect sys/system1 as sysdba;

spool s-01-crea-tablespaces.log
alter session set container=tvac_modulo_1;
Prompt Creando tablespaces para modulo 1
@s-01-crea-tablespaces-mod-1.sql

alter session set container=tvac_modulo_2;
Prompt Creando tablespaces para modulo 2
@s-01-crea-tablespaces-mod-2.sql
spool off;
exit;