--@Autor: Aldo Navarrete y Diego Nuñez
--@Fecha: 2024-12-1
--@Descripción: Script para mover los redo logs a la FRA


define fra_path='/unam/diplo-bd/proyecto-final/fast-recovery-area'

select * from v$controlfile;
select * from v$logfile;

alter database add logfile group 7 size 80M blocksize 512;
alter database add logfile group 8 size 80M blocksize 512;
alter database add logfile group 9 size 80M blocksize 512;
-- Use the substitution variable
alter database add logfile member 
'&fra_path/FREE/redo01d.log' to group 1;

alter database add logfile member
'&fra_path/FREE/redo02d.log' to group 2;

alter database add logfile member
'&fra_path/FREE/redo03d.log' to group 3;

select * from v$log;

alter system switch logfile;

alter system checkpoint;

alter database drop logfile group 1;
alter database drop logfile group 2;
alter database drop logfile group 3;