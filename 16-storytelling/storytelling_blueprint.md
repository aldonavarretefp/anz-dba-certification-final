
# Storytelling Blueprint  
**Proyecto:** “¿Quiénes son nuestros viajeros estrella?”  

---

## ✅ Requisitos de la rúbrica ↔︎ dónde se cubren

| Requisito | Sección |
|-----------|---------|
| Anécdota que justifique el análisis | 1.1 |
| Pregunta hipotética | 1.2 |
| Datos que se toman en cuenta | 2.1 |
| Propósito & diseño (Migración a la nube + ETL + tablas) | 2.2 – 2.3 |
| Historia de puntos clave respaldados por visuales | 3 (look‐&‐feel DAR) |

---

## 1 · Storytelling

### 1.1 Anécdota disparadora  
> *“El gerente del Centro Valle vio al mismo cliente comprando gorras en Valle y, dos semanas después, escalando en Playa. Sin Data Lake, todo era corazonadas… ¿quiénes son esos nómadas y qué edad tienen?”*

### 1.2 Pregunta hipotética  
> **“¿Cuál es la edad promedio y la ocupación de los clientes que han visitado el mayor número de centros vacacionales distintos?”**

---

## 2 · Análisis y arquitectura

### 2.1 Datos tomados en cuenta  
| Tabla | Campo clave | Por qué se usa |
|-------|-------------|----------------|
| `CLIENTE`            | `EDAD_CLIENTE`, `OCUPACION_CLIENTE` | Segmentar perfiles |
| `VISITA_CLIENTE`     | `CLAVE_CLIENTE_ID`, `RCENTRO_ID`    | Contar centros distintos por cliente |
| `CENTRO_VACACIONAL`  | `CENTRO_ID`, geodatos               | Mapas de densidad |
| *(Opcional)* `ACTIVIDAD_PARTICIPACION` | tiempo en actividades | Enriquecimiento posterior |

### 2.2 Proceso de migración a la nube  
```mermaid
graph TD
  A[Oracle Dump ⇢ GCS<br>(Parquet)] --> B[Bronze<br>tvac_bronze]
  B --> C[Transform SQL<br>casts, dedup] --> D[Silver<br>tvac_silver]
  D -->|Star-schema CTAS| E[Gold<br>tvac_gold]
  E --> L[Looker Studio]
```

### 2.3 Estructura de las 3 capas

| Capa | Dataset | Estructura | Propósito |
|------|---------|-----------|-----------|
| **Bronze** | `tvac_bronze` | Tablas espejo (raw), tipos STRING | Ingesta rápida, auditoría |
| **Silver** | `tvac_silver` | Tipos nativos, FK validadas, fechas normalizadas | Datos confiables para modelos |
| **Gold** | `tvac_gold` | Esquema estrella ➊ `F_VISITA`, ➋ `D_CLIENTE`, ➌ `D_CENTRO`, ➍ `D_TIEMPO`, ➎ `D_OCUPACION` | Consumo BI / ML |

*ETL orquestado en Cloud Composer; refresco diario.*

---

## 3 · Visualización Looker Studio (modelo DAR)

| Página | Tipo | Visuales | Mensaje/story |
|--------|------|----------|---------------|
| **D — Dashboard** | KPI, mapa calor | % clientes multicentro, localización de visitas | *“Existe un 7 % de viajeros nómadas.”* |
| **A — Analysis** | Barras + tabla dinámica | `# Centros distintos ↔ Edad promedio`; detalle por ocupación | *“Top nómadas ≈ 31 años, ingenieros/arquitectos.”* |
| **R — Recommendation** | Funnel, tarjetas texto | Conversión piloto de campaña VIP | *“Propuesta: membresía cruzada para 25-40 años.”* |

Cada visual se alimenta de vistas Gold:

```sql
-- V_CLIENTE_CENTROS (centros distintos por cliente)
CREATE OR REPLACE MATERIALIZED VIEW tvac_gold.v_cliente_centros AS
SELECT  c.clave_cliente_id,
        COUNT(DISTINCT f.rcentro_id) AS centros_visitados
FROM    tvac_gold.f_visita   f,
        tvac_gold.d_cliente  c
WHERE   c.clave_cliente_id = f.clave_cliente_id
GROUP   BY c.clave_cliente_id;
```

---

## 4 · Secuencia de presentación (≈ 8 min)

1. **Hook (0:30)** — la anécdota del cliente “omnipresente”.  
2. **Problema (0:30)** — silos on-prem, sin perfiles.  
3. **Data Lake 3 capas (2:00)** — diagrama y por qué Bronze→Silver→Gold.  
4. **Insight (1:30)** — hallazgo de edad/ocupación vs #centros.  
5. **Looker demo (2:00)** — páginas DAR, hilo narrativo.  
6. **Acción (0:30)** — programa VIP Nómada.  
7. **Cierre (0:30)** — “de intuición a dato accionable en la nube”.

---

## 5 · Checklist de cumplimiento

- [x] Anecdota & problema claro  
- [x] Pregunta hipotética formulada  
- [x] Datos considerados explícitos  
- [x] Diseño 3 capas + ETL descrito  
- [x] Historia alineada a visuales Looker (DAR)  
- [x] Star schema en Gold  

> **Resultado esperado:** Una demo de Looker Studio con 3 páginas vivas, sustentada por un Data Lake en BigQuery, capaz de responder “quiénes son nuestros viajeros estrella” y guiar acciones de marketing basadas en datos.
