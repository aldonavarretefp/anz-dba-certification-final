/* ===================================================================
   export_every_table.sql
   -------------------------------------------------------------------
   Ejecuta así (ejemplo módulo 1):
     sqlplus -S tvac_mod1_app/mypwd@TVAC_MOD1 @export_every_table.sql

   Vuelve a ejecutarlo con tvac_mod2_app para el Módulo 2.
   El directorio /tmp/exports/<schema> se crea y se sobreescribe
   cada archivo .csv si ya existía.
   ===================================================================*/

-- 0) AJUSTAR: destino raíz
DEFINE BASE_DIR = '/tmp/exports'

-- 1) Obtener el nombre del esquema actual
COLUMN user_name NEW_VALUE SCHEMA
SELECT LOWER(USER) AS user_name FROM dual;

-- 2) Crear carpeta y limpiar CSV anteriores
HOST mkdir -p &BASE_DIR/&SCHEMA
HOST rm -f  &BASE_DIR/&SCHEMA/*.csv

-- 3) Configuración CSV
SET HEADING ON
SET FEEDBACK OFF
SET PAGESIZE 0
SET TRIMS ON
SET VERIFY   OFF
SET MARKUP CSV ON

PROMPT === Exportando tablas del esquema &SCHEMA ===

-- 4) Generar dinámicamente un bloque spool por tabla
SET TERMOUT OFF
SPOOL gen_spool.sql
SELECT
      'SPOOL &BASE_DIR/&SCHEMA/'||LOWER(table_name)||'.csv'            ||CHR(10)||
      'SELECT * FROM '||table_name||';'                                ||CHR(10)||
      'SPOOL OFF'                                                      ||CHR(10)
FROM   user_tables
ORDER  BY table_name;
SPOOL OFF
SET TERMOUT ON

-- 5) Ejecutar los spools generados
@@gen_spool.sql
HOST rm -f gen_spool.sql   -- limpia archivo temporal

PROMPT === CSV listos en &BASE_DIR/&SCHEMA ===
EXIT

