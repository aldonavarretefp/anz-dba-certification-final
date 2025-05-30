/*=====================================================================
  export_all.sql
  ----------------
  Exporta **TODAS** las tablas de los dos módulos a CSV, sobrescribiendo
  archivos anteriores.  Uso recomendado con *sqlcl* (o SQL*Plus 19c+).

  $ sql -S user/password@TNS @export_all.sql
=====================================================================*/

------------------------------------------------------------------------
-- CONFIGURACIÓN GENERAL
------------------------------------------------------------------------
DEF base_dir  = '/tmp/exports'        -- directorio raíz en tu máquina
DEF mod1_dir  = '&base_dir/MOD1'
DEF mod2_dir  = '&base_dir/MOD2'

SET HEADING ON
SET FEEDBACK OFF
SET PAGESIZE 0
SET TRIMS ON
SET VERIFY OFF
SET ECHO OFF
SET MARKUP CSV ON

-- crea carpetas y limpia CSV anteriores
HOST mkdir -p &mod1_dir
HOST mkdir -p &mod2_dir
HOST rm -f  &mod1_dir/*.csv
HOST rm -f  &mod2_dir/*.csv

------------------------------------------------------------------------
-- LISTA DE TABLAS POR MÓDULO  (ajusta si cambiaste nombres)
------------------------------------------------------------------------
-- MÓDULO 1
COLUMN t1 NEW_VALUE tbl
DEFINE mod1_tables = '
ASOCIACION
CENTRO_VACACIONAL
EMPLEADO
LIDER
CENTRO_LIDER
CERTIFICACION
CERTIFICACION_VERSION
LIDER_CERTIFICACION
TIPO_DEPORTE
TIPO_JUEGO
ACTIVIDAD
IMAGEN_ACTIVIDAD
ACTIVIDAD_CAMPAMENTO
ACTIVIDAD_DEPORTE
ACTIVIDAD_JUEGO'

-- MÓDULO 2
DEFINE mod2_tables = '
CLIENTE
AUTO_CLIENTE
INVITADO
ESTADO_MEMBRESIA
TARJETA
CLIENTE_MEMBRESIA
HISTORIAL_MEMBRESIA
VISITA_CLIENTE
VISITA_INVITADO
ACTIVIDAD_PARTICIPACION'

------------------------------------------------------------------------
-- MACRO PARA SPOOL ⇒ CSV
------------------------------------------------------------------------
DEFINE spool_csv = "
SPOOL &1/&2..csv
SELECT * FROM &2;
SPOOL OFF
"

------------------------------------------------------------------------
-- ========== EXPORTAR MÓDULO 1 ==========
------------------------------------------------------------------------
PROMPT === Exportando MÓDULO 1 a &mod1_dir ===
BEGIN NULL; END; /
-- loop “manual” (sql*plus no tiene for-each, usamos sustituciones)
-- cada llamada:  &spool_csv  <dir>  <tabla>
@@?spool_csv &mod1_dir ASOCIACION
@@?spool_csv &mod1_dir CENTRO_VACACIONAL
@@?spool_csv &mod1_dir EMPLEADO
@@?spool_csv &mod1_dir LIDER
@@?spool_csv &mod1_dir CENTRO_LIDER
@@?spool_csv &mod1_dir CERTIFICACION
@@?spool_csv &mod1_dir CERTIFICACION_VERSION
@@?spool_csv &mod1_dir LIDER_CERTIFICACION
@@?spool_csv &mod1_dir TIPO_DEPORTE
@@?spool_csv &mod1_dir TIPO_JUEGO
@@?spool_csv &mod1_dir ACTIVIDAD
@@?spool_csv &mod1_dir IMAGEN_ACTIVIDAD
@@?spool_csv &mod1_dir ACTIVIDAD_CAMPAMENTO
@@?spool_csv &mod1_dir ACTIVIDAD_DEPORTE
@@?spool_csv &mod1_dir ACTIVIDAD_JUEGO

------------------------------------------------------------------------
-- ========== EXPORTAR MÓDULO 2 ==========
------------------------------------------------------------------------
PROMPT === Exportando MÓDULO 2 a &mod2_dir ===
BEGIN NULL; END; /
@@?spool_csv &mod2_dir CLIENTE
@@?spool_csv &mod2_dir AUTO_CLIENTE
@@?spool_csv &mod2_dir INVITADO
@@?spool_csv &mod2_dir ESTADO_MEMBRESIA
@@?spool_csv &mod2_dir TARJETA
@@?spool_csv &mod2_dir CLIENTE_MEMBRESIA
@@?spool_csv &mod2_dir HISTORIAL_MEMBRESIA
@@?spool_csv &mod2_dir VISITA_CLIENTE
@@?spool_csv &mod2_dir VISITA_INVITADO
@@?spool_csv &mod2_dir ACTIVIDAD_PARTICIPACION

PROMPT =============================
PROMPT ✅  Exportación completada.
PROMPT Archivos CSV en: &base_dir
PROMPT =============================
EXIT

