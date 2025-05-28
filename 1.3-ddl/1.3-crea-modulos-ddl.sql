
connect sys/system1 as sysdba;

whenever sqlerror exit rollback

set serveroutput on


Prompt "1.3. Creando usuarios para los modulos del proyecto..."

spool 1.3-crea-modulos-ddl.log
@1.3.1-modulo-1-ddl.sql
@1.3.2-modulo-2-ddl.sql
spool off

exit

