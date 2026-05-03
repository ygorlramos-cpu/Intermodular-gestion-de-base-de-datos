-- ============================================================
--  FitLife Gym - Script de Consultas
--  Módulo 0372 - Gestión de Bases de Datos
--  1º ASIR - Proyecto Intermodular
--  Fecha: 2025-05-03
-- ============================================================

USE fitlife_gym;

-- ============================================================
-- CONSULTA 1: Listado completo de socios con su membresía
-- Propósito: Ver todos los clientes y qué tarifa tienen contratada
-- ============================================================
SELECT
  s.id_socio,
  s.nombre,
  s.apellidos,
  s.dni,
  s.email,
  m.tipo        AS membresia,
  m.precio_mensual
FROM socios s
JOIN membresias m ON s.id_membresia = m.id_membresia
ORDER BY s.apellidos, s.nombre;


-- ============================================================
-- CONSULTA 2: Reservas de un socio concreto con datos de clase
-- Propósito: Historial de actividad de un socio específico
-- Cambiar el valor de id_socio según el socio consultado
-- ============================================================
SELECT
  r.id_reserva,
  r.fecha_reserva,
  r.estado,
  c.nombre        AS clase,
  c.dia_semana,
  c.horario_inicio,
  e.nombre        AS instructor,
  e.apellidos     AS apellidos_instructor
FROM reservas r
JOIN clases    c ON r.id_clase    = c.id_clase
JOIN empleados e ON c.id_empleado = e.id_empleado
WHERE r.id_socio = 1
ORDER BY r.fecha_reserva;


-- ============================================================
-- CONSULTA 3: Ocupación actual de cada clase
-- Propósito: Control de aforo en tiempo real
-- ============================================================
SELECT
  c.nombre        AS clase,
  c.dia_semana,
  c.horario_inicio,
  c.capacidad_max,
  COUNT(r.id_reserva)                          AS plazas_ocupadas,
  (c.capacidad_max - COUNT(r.id_reserva))      AS plazas_libres
FROM clases c
LEFT JOIN reservas r ON c.id_clase = r.id_clase
                     AND r.estado  = 'confirmada'
GROUP BY c.id_clase
ORDER BY plazas_libres ASC;


-- ============================================================
-- CONSULTA 4: Ingresos del mes actual agrupados por método de pago
-- Propósito: Resumen financiero mensual
-- ============================================================
SELECT
  metodo_pago,
  COUNT(*)       AS num_pagos,
  SUM(importe)   AS total_euros
FROM pagos
WHERE MONTH(fecha_pago) = MONTH(CURDATE())
  AND YEAR(fecha_pago)  = YEAR(CURDATE())
GROUP BY metodo_pago
ORDER BY total_euros DESC;


-- ============================================================
-- CONSULTA 5: Socios Premium con reservas confirmadas esta semana
-- Propósito: Identificar socios activos para acciones de fidelización
-- ============================================================
SELECT DISTINCT
  s.nombre,
  s.apellidos,
  s.email,
  m.tipo AS membresia
FROM socios s
JOIN membresias m ON s.id_membresia = m.id_membresia
JOIN reservas   r ON s.id_socio     = r.id_socio
WHERE m.tipo    = 'Premium'
  AND r.estado  = 'confirmada'
  AND WEEK(r.fecha_reserva) = WEEK(CURDATE())
ORDER BY s.apellidos;


-- ============================================================
-- CONSULTA 6 (EXTRA): Clases por instructor con número de alumnos
-- Propósito: Carga de trabajo de cada empleado
-- ============================================================
SELECT
  e.nombre        AS instructor,
  e.apellidos,
  e.especialidad,
  COUNT(c.id_clase) AS num_clases,
  SUM(
    (SELECT COUNT(*) FROM reservas r
     WHERE r.id_clase = c.id_clase AND r.estado = 'confirmada')
  ) AS total_alumnos
FROM empleados e
LEFT JOIN clases c ON e.id_empleado = c.id_empleado
WHERE e.puesto = 'Instructor'
GROUP BY e.id_empleado
ORDER BY total_alumnos DESC;


-- ============================================================
-- CONSULTA 7 (EXTRA): Socios sin ninguna reserva activa
-- Propósito: Detectar socios inactivos para reactivación
-- ============================================================
SELECT
  s.id_socio,
  s.nombre,
  s.apellidos,
  s.email,
  s.fecha_alta,
  m.tipo AS membresia
FROM socios s
JOIN membresias m ON s.id_membresia = m.id_membresia
WHERE s.id_socio NOT IN (
  SELECT DISTINCT id_socio
  FROM reservas
  WHERE estado = 'confirmada'
)
ORDER BY s.fecha_alta;
