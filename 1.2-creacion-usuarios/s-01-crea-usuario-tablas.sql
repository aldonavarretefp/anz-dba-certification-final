/*====================================================================
  CREACIÓN DE USUARIOS Y ASIGNACIÓN DE CUOTAS
  Proyecto    : Travesía Vacacional
  Autor       : Aldo Navarrete
  Fecha       : 28-may-2025
  Descripción : Dos usuarios por módulo, cada uno con cuota ilimitada
                en TODOS los tablespaces que le corresponden.
  ====================================================================*/

CONNECT sys/system1 AS SYSDBA;
WHENEVER SQLERROR EXIT ROLLBACK;
SET SERVEROUTPUT ON;

/*====================================================================
  MÓDULO 1  (CENTROS, EMPLEADOS, CERTIFICACIONES, ACTIVIDADES)
====================================================================*/
ALTER SESSION SET CONTAINER = tvac_modulo_1;  --  ← cambia al PDB real

PROMPT 1. Creando usuarios del MÓDULO 1
----------------------------------------
-- Usuario principal (lectura / escritura)
DROP USER IF EXISTS tvac_mod1_app CASCADE;
CREATE USER tvac_mod1_app
  IDENTIFIED BY tvac_mod1_app
  DEFAULT TABLESPACE TS_CENTROS_DATA
  QUOTA UNLIMITED ON users;

-- Usuario secundario (p.ej. reportes / mantenimiento)
DROP USER IF EXISTS tvac_mod1_rep CASCADE;
CREATE USER tvac_mod1_rep
  IDENTIFIED BY tvac_mod1_rep
  DEFAULT TABLESPACE TS_CENTROS_DATA
  QUOTA UNLIMITED ON users;

/*—  Cuotas para TODOS los tablespaces del Módulo 1 —*/
BEGIN
  FOR t IN (
    SELECT tablespace_name ts
      FROM dba_tablespaces
     WHERE tablespace_name IN (
            'TS_CENTROS_DATA','TS_CENTROS_IDX',
            'TS_EMPLEADOS_DATA','TS_EMPLEADOS_IDX',
            'TS_CERTIFICACIONES_DATA','TS_CERTIFICACIONES_IDX','TS_CERTIFICACIONES_BLOB',
            'TS_ACTIVIDADES_DATA','TS_ACTIVIDADES_IDX','TS_ACTIVIDADES_BLOB'
          )
  ) LOOP
    EXECUTE IMMEDIATE 'ALTER USER tvac_mod1_app QUOTA UNLIMITED ON '||t.ts;
    EXECUTE IMMEDIATE 'ALTER USER tvac_mod1_rep QUOTA UNLIMITED ON '||t.ts;
  END LOOP;
END;
/

/*—  Privilegios básicos —*/
GRANT CREATE SESSION,
      CREATE TABLE,
      CREATE SEQUENCE,
      CREATE PROCEDURE
TO tvac_mod1_app;

GRANT CREATE SESSION TO tvac_mod1_rep;     -- solo conecta
GRANT SELECT ANY DICTIONARY TO tvac_mod1_rep;  -- ejemplo de permisos de reporte


/*====================================================================
  MÓDULO 2  (CLIENTES, MEMBRESÍAS, VISITAS, ACTIVIDAD PARTIC.)
====================================================================*/
ALTER SESSION SET CONTAINER = tvac_modulo_2;  --  ← cambia al PDB real

PROMPT 2. Creando usuarios del MÓDULO 2
----------------------------------------
DROP USER IF EXISTS tvac_mod2_app CASCADE;
CREATE USER tvac_mod2_app
  IDENTIFIED BY tvac_mod2_app
  DEFAULT TABLESPACE TS_CLIENTES_DATA
  QUOTA UNLIMITED ON users;

DROP USER IF EXISTS tvac_mod2_rep CASCADE;
CREATE USER tvac_mod2_rep
  IDENTIFIED BY tvac_mod2_rep
  DEFAULT TABLESPACE TS_CLIENTES_DATA
  QUOTA UNLIMITED ON users;

/*—  Cuotas para TODOS los tablespaces del Módulo 2 —*/
BEGIN
  FOR t IN (
    SELECT tablespace_name ts
      FROM dba_tablespaces
     WHERE tablespace_name IN (
            'TS_CLIENTES_DATA','TS_CLIENTES_IDX',
            'TS_MEMBRESIAS_DATA','TS_MEMBRESIAS_IDX',
            'TS_VISITAS_DATA','TS_VISITAS_IDX',
            'TS_ACTPART_DATA','TS_ACTPART_IDX'
          )
  ) LOOP
    EXECUTE IMMEDIATE 'ALTER USER tvac_mod2_app QUOTA UNLIMITED ON '||t.ts;
    EXECUTE IMMEDIATE 'ALTER USER tvac_mod2_rep QUOTA UNLIMITED ON '||t.ts;
  END LOOP;
END;
/

/*—  Privilegios básicos —*/
GRANT CREATE SESSION,
      CREATE TABLE,
      CREATE SEQUENCE,
      CREATE PROCEDURE
TO tvac_mod2_app;

GRANT CREATE SESSION TO tvac_mod2_rep;
GRANT SELECT ANY DICTIONARY TO tvac_mod2_rep;  -- ejemplo de permisos de reporte

