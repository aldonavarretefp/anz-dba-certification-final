i/*--------------------------------------------------------------
  MOSTRAR ARCHIVOS ARCHIVADOS
  • DEST_ID       → destino lógico configurado
  • THREAD#       → hilo de redo (RAC)
  • SEQUENCE#     → secuencia del redo archivado
  • APPLIED       → YES/NO para Data Guard
  • COMPLETION    → fecha/hora cuando se archivó
  • NAME          → ruta completa del archivo .ARC / .LOG
----------------------------------------------------------------*/
COLUMN dest_id         FORMAT 99
COLUMN thread#         FORMAT 99
COLUMN sequence#       FORMAT 999999
COLUMN applied         FORMAT A7
COLUMN completion_time FORMAT A20
COLUMN name            FORMAT A80

SELECT dest_id,
       thread#,
       sequence#,
       applied,
       TO_CHAR(completion_time,'YYYY-MM-DD HH24:MI:SS') AS completion_time,
       name
FROM   v$archived_log
ORDER  BY dest_id, thread#, sequence#;


/*----------------------------------------------------------------
  DEVUELVE UN DISTINTO DE LOS DIRECTORIOS DE ARCHIVOS ARCHIVADOS
  REGEXP_REPLACE extrae todo hasta el último “/”.
----------------------------------------------------------------*/
COLUMN archive_dir FORMAT A80

SELECT DISTINCT
       REGEXP_REPLACE(name,'[^/]+$','') AS archive_dir
FROM   v$archived_log
ORDER  BY archive_dir;



/*----------------------------------------------------------------
  MUESTRA LOS DESTINOS CONFIGURADOS EN LA INSTANCIA
----------------------------------------------------------------*/
COLUMN dest_id     FORMAT 99
COLUMN status      FORMAT A10
COLUMN destination FORMAT A80
COLUMN target      FORMAT A8

SELECT dest_id,
       status,
       destination,
       target
FROM   v$archive_dest
WHERE  status = 'VALID'
ORDER  BY dest_id;
