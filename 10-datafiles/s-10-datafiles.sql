/*==============================================================
  DISTRIBUCIÓN DE DATAFILES POR MÓDULO
  - Incluye tamaño actual y tamaño máximo
  - Separa los módulos con base en el prefijo de tablespace
==============================================================*/


connect sys/system1 as sysdba;

SET LINESIZE 200
SET PAGESIZE 100

COLUMN modulo            FORMAT A10
COLUMN tablespace_name   FORMAT A25
COLUMN file_name         FORMAT A60
COLUMN tamaño_mb         FORMAT 999,999,999
COLUMN max_mb            FORMAT 999,999,999
COLUMN autoextensible    FORMAT A3

SELECT
    /* -----------------------------------------
       REGRA DE CLASIFICACIÓN POR MÓDULOS
       (ajusta la lista según tus TS)
       ----------------------------------------- */
    CASE
        WHEN tablespace_name IN (
             'TS_CENTROS_DATA','TS_CENTROS_IDX',
             'TS_EMPLEADOS_DATA','TS_EMPLEADOS_IDX',
             'TS_CERTIFICACIONES_DATA','TS_CERTIFICACIONES_IDX','TS_CERTIFICACIONES_BLOB',
             'TS_ACTIVIDADES_DATA','TS_ACTIVIDADES_IDX','TS_ACTIVIDADES_BLOB'
        ) THEN 'MOD 1'
        WHEN tablespace_name IN (
             'TS_CLIENTES_DATA','TS_CLIENTES_IDX',
             'TS_MEMBRESIAS_DATA','TS_MEMBRESIAS_IDX',
             'TS_VISITAS_DATA','TS_VISITAS_IDX',
             'TS_ACTPART_DATA','TS_ACTPART_IDX'
        ) THEN 'MOD 2'
        ELSE 'OTRO'
    END                                   AS MODULO,
    tablespace_name,
    file_id,
    file_name,
    ROUND(bytes/1024/1024)                AS TAMAÑO_MB,
    DECODE(autoextensible,'YES',
           ROUND(maxbytes/1024/1024),
           ROUND(bytes/1024/1024))        AS MAX_MB,
    autoextensible
FROM   dba_data_files
WHERE  tablespace_name LIKE 'TS_%'
ORDER  BY modulo, tablespace_name, file_id;

