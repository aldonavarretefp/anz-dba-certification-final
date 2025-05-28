
connect sys/system1 as sysdba;

whenever sqlerror exit rollback;

/*---------------------------------------------------------------
  Muestra:
    • GROUP#      → número del grupo
    • THREAD#     → hilo (útil en RAC)
    • STATUS      → CURRENT / INACTIVE / etc.
    • BYTES_MB    → tamaño del grupo
    • MEMBER      → ruta completa del archivo de redo
    • TYPE        → ONLINE (normal) u STANDBY
----------------------------------------------------------------*/
COLUMN group#      FORMAT 999
COLUMN thread#     FORMAT 99
COLUMN status      FORMAT A10
COLUMN bytes_mb    FORMAT 999,999
COLUMN member      FORMAT A60
COLUMN type        FORMAT A8

SELECT
       lf.group#,
       l.thread#,
       l.status,
       ROUND(l.bytes/1024/1024) AS bytes_mb,
       lf.member,
       lf.type
FROM   v$logfile lf
JOIN   v$log     l
       ON l.group# = lf.group#
ORDER  BY lf.group#, lf.member;

