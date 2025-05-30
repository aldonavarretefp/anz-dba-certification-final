--@Autor: Aldo Navarrete y Diego Nuñez
--@Fecha: 2024-12-1
--@Descripción: Script para mover los redo logs a la FRA

select * from v$controlfile;
select * from v$logfile;

alter database add logfile group 7 size 80M blocksize 512;
alter database add logfile group 8 size 80M blocksize 512;
alter database add logfile group 9 size 80M blocksize 512;

--miembros para el grupo 7
alter database add logfile member 
'/unam/diplo-bd/proyecto-final/disk/d01/app/oracle/oradata/FREE/redo07a.log' to group 7;
alter database add logfile member
'/unam/diplo-bd/proyecto-final/disk/d02/app/oracle/oradata/FREE/redo07b.log' to group 7;
--miembros para el grupo 8
alter database add logfile member
'/unam/diplo-bd/proyecto-final/disk/d01/app/oracle/oradata/FREE/redo08a.log' to group 8;
alter database add logfile member
'/unam/diplo-bd/proyecto-final/disk/d02/app/oracle/oradata/FREE/redo08b.log' to group 8;
--miembros para el grupo 9
alter database add logfile member
'/unam/diplo-bd/proyecto-final/disk/d01/app/oracle/oradata/FREE/redo09a.log' to group 9;
alter database add logfile member
'/unam/diplo-bd/proyecto-final/disk/d02/app/oracle/oradata/FREE/redo09b.log' to group 9;

select * from v$log;

alter system switch logfile;

alter system checkpoint;

alter database drop logfile group 1;
alter database drop logfile group 2;
alter database drop logfile group 3;

ALTER DATABASE DROP LOGFILE MEMBER '/unam/diplo-bd/proyecto-final/disk/d03/app/oracle/oradata/FREE/redo01c.log';
ALTER DATABASE DROP LOGFILE MEMBER '/unam/diplo-bd/proyecto-final/disk/d03/app/oracle/oradata/FREE/redo02c.log';
ALTER DATABASE DROP LOGFILE MEMBER '/unam/diplo-bd/proyecto-final/disk/d03/app/oracle/oradata/FREE/redo03c.log';
