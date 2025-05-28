
connect sys/system1 as sysdba;
when sqlerror exit rollback;
set serveroutput on;

spool 8.1-carga-datos.log
alter session set container = tvac_modulo_1;
connect tvac_mod1_app/tvac_mod1_app@tvac_modulo_1;
prompt "8.1. Cargando datos para el modulo 1..."
@8.1-carga-datos-mod-1.sql


Prompt "8.2. Cargando datos para el modulo 2..."
alter session set container = tvac_modulo_2;
connect tvac_mod2_app/tvac_mod2_app@tvac_modulo_2;
@8.1-carga-datos-mod-2.sql

spool off;

