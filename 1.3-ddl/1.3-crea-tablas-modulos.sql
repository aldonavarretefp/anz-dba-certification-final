
connect sys/system1 as sysdba;

whenever sqlerror exit rollback

set serveroutput on

Prompt "1.3. Creando usuarios para el modulo 1..."
alter session set container = tvac_modulo_1;
connect usermod1/usermod1@tvac_modulo_1;
@1.3.1-modulo-1-ddl.sql

Prompt "1.3. Creando usuarios para el modulo 2..."
alter session set container = tvac_modulo_2;
connect usermod2/usermod2@tvac_modulo_2;
@1.3.2-modulo-2-ddl.sql

spool off
exit

