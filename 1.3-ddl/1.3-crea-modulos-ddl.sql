
connect sys/system1 as sysdba;

whenever sqlerror exit rollback

set serveroutput on


Prompt "1.3. Creando usuarios para el modulo 1...2"

spool 1.3-crea-modulos-ddl.log

alter session set container = tvac_modulo_1;
connect usermod1/usermod1@tvac_modulo_1;


Prompt "1.3. Creando usuarios para el modulo 2...2"

@1.3.1-modulo-1-ddl.sql

alter session set container = tvac_modulo_2;
connect usermod2/usermod2@tvac_modulo_2;

@1.3.2-modulo-2-ddl.sql


spool off

exit

