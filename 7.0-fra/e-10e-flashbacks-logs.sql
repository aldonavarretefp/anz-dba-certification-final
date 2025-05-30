--@Autor: Aldo Navarrete y Diego Nuñez
--@Fecha: 2024-12-1
--@Descripción: Script para habilitar Flashback y configurar el tiempo de retención de los datos en la FRA

connect sys/system1 as sysdba;


alter database flashback on;

/*

DB_FLASHBACK_RETENTION_TARGET specifies the upper limit (in minutes) on how far back in time the database may be flashed back.

Property          Description
------------------ -------------------------------------------------
Parameter type    Integer
Default value     1440 (minutes)
Modifiable        ALTER SYSTEM ... SID='*'
Modifiable in a PDB No
Range of values   0 to 231 - 1
Basic             No

How far back one can flashback a database depends on how much flashback data Oracle has kept in the fast recovery area.
*/

alter system set db_flashback_retention_target=4320 scope=both;

exit