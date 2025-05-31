# Storytelling de Análisis de Clientes en Centros Vacacionales

## 1. Introducción y Anécdota

**Presentador:**  
Buenas tardes a todas y todos. Gracias por acompañarnos. Hoy quiero contarles una pequeña historia que dio origen a nuestra pregunta de investigación:

Hace unos meses, al diseñar promociones para nuestros centros vacacionales, notamos que algunos clientes recorrían varios complejos, mientras que otros solo visitaban uno o dos. Nos preguntamos:  
**¿Quiénes son esos “viajeros frecuentes” entre nuestros centros vacacionales? ¿Tendrán un perfil de edad distinto al común de nuestros clientes?**

Esta curiosidad nos llevó a formular una hipótesis antes de diseñar nuevas estrategias de marketing o tarifas especiales.

---

## 2. Planteamiento de la Pregunta Hipotética y las Hipótesis Estadísticas

**Pregunta:**  
¿Cuál es la edad promedio de los clientes que más veces han asistido a centros distintos?

**Hipótesis nula (H₀):**  
La edad promedio de los clientes que visitan múltiples centros (percentil superior de ‘centros_distintos’) no difiere de la edad promedio general.

**Hipótesis alternativa (Hₐ):**  
La edad promedio de esos “viajeros frecuentes” sí difiere de la edad promedio de todos los clientes.

**Ejemplo:**  
Si los clientes que van a 4 o 5 centros tienen edad promedio 28 años, y el promedio general es 42 años, podríamos rechazar H₀ y concluir que los “viajeros frecuentes” son más jóvenes (o más viejos, según los datos).

---

## 3. Descripción de los Datos y Proceso ETL (Migración a la Nube)

### Capa Bronze (Raw Data)
- **clientes_stagging:** Datos básicos del cliente.
- **visita_cliente_stagging:** Registro de cada visita.
- **actividad_participacion_stagging:** Participación en actividades.
- Otras tablas: membresía, historial, actividades.

**Objetivo:**  
Mantener los datos tal cual llegan del origen, con mínimas conversiones.

### Capa Silver (Limpieza y Atributos Calculados)
- Limpieza de texto, formatos y validaciones.
- Cálculo de atributos como `edad_rango`, `centros_distintos`, `total_visitas`, `promedio_acompanantes`, y `estado_actual_membresia`.
- Generación de vistas limpias y enriquecidas listas para análisis.

### Capa Gold (Modelo Dimensional Estrella)
- **dim_cliente:** Datos demográficos y estado de membresía.
- **dim_tiempo, dim_centro, dim_actividad:** Dimensiones para análisis.
- **fact_visita_cliente, fact_participacion:** Métricas agregadas.
- Atributo clave: `es_top_viajero` (clientes con ≥ percentil 80 de centros_distintos).

**Propósito:**  
Optimizar para consultas analíticas y visualizaciones en Looker Studio.

---

## 4. Visualizaciones en Looker Studio: Página 1

### 4.1 KPI Cards (Resumen Numérico)
- **Clientes Totales:** 1,200
- **Visitas Totales:** 3,450
- **Actividades Realizadas:** 1,800
- **Promedio de Acompañantes:** 2.7

### 4.2 Gráfico de Barras Apiladas
- **Clientes por Rango de Edad y Estado de Membresía**
- Ejemplo: En 36–50 años, 80% con membresía vigente.

### 4.3 Gráfico de Líneas
- **Visitas por Día y Rango de Edad**
- Picos de visitas los fines de semana, especialmente en 36–50 años.

### 4.4 Gráfico de Pastel: Estado de Membresía
- 70% Vigente, 15% Adeudo, 10% Suspendida, 5% Cancelada.

### 4.5 Gráfico de Pastel: Ocupación
- Ingenieros 30%, Médicos 20%, Docentes 15%, Estudiantes 20%, Otros 15%.

### 4.6 Bubble Chart: Visitas vs. Acompañantes vs. Centros Distintos
- Eje X: Total de visitas
- Eje Y: Promedio de acompañantes
- Tamaño: Centros distintos visitados
- Color: Estado de membresía
- **Insight:** Los “top viajeros” (burbujas grandes) son más jóvenes y visitan más centros.

### 4.7 Barra de “Clientes por Edad”
- Refuerza que el grupo 36–50 es el más numeroso.

---

## 5. Prueba de Hipótesis: Comparación de Edades

- **Edad Promedio TopViajeros:** 28.6 años
- **Edad Promedio Todos los Clientes:** 41.9 años
- **Conclusión:**  
  La diferencia es significativa. Rechazamos H₀: los “viajeros frecuentes” son más jóvenes.

---

## 6. Conclusión de la Página 1

- 1,200 clientes únicos, 3,450 visitas, 1,800 participaciones.
- Mayoría en el rango 36–50 años, 80% con membresía vigente.
- “Viajeros frecuentes” (≥4 centros) tienen edad promedio 28.6 años.
- **Acción recomendada:**  
  Paquetes multi-centro para menores de 30 años, campañas de retención para 36–50, y estrategias para recuperar clientes en adeudo.

---

## 7. Transición a Página 2: Membresías y Actividades

- Análisis de membresías mes a mes.
- Visitas por tipo de actividad.
- Participación de invitados y relación con edad.
- Ingresos potenciales por actividad.

---

## 8. Breve Mención de Página 3: Geoanálisis

- Mapa de centros y visitas.
- Evolución mensual de visitas por centro.
- Análisis de participación infantil en actividades.

---

## 9. Cierre y Recomendaciones

- Los “viajeros frecuentes” son más jóvenes.
- Ofertas dirigidas a menores de 30 años.
- Programas de fidelización para 36–50.
- Campañas de retención para clientes en adeudo.

---

## 10. Preguntas y Retroalimentación

- Espacio abierto para preguntas sobre el análisis, estadística o proceso ETL.
- Disponibilidad para compartir detalles técnicos y scripts SQL si se requiere.

---

**¡Gracias por su atención! Nos vemos en la siguiente sesión para profundizar en membresías y actividades.**