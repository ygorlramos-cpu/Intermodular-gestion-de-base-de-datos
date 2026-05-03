-- ============================================================
--  FitLife Gym - Script de Inserción de Datos de Ejemplo
--  Módulo 0372 - Gestión de Bases de Datos
--  1º ASIR - Proyecto Intermodular
--  Fecha: 2025-05-03
-- ============================================================

USE fitlife_gym;

-- -----------------------------------------------------------
-- Membresías
-- -----------------------------------------------------------
INSERT INTO membresias (tipo, precio_mensual, descripcion) VALUES
  ('Basica',   29.90, 'Acceso sala de musculacion de lunes a viernes'),
  ('Premium',  49.90, 'Acceso ilimitado mas clases grupales incluidas'),
  ('Anual',   299.00, 'Pago unico anual con acceso completo a todas las instalaciones');

-- -----------------------------------------------------------
-- Empleados
-- -----------------------------------------------------------
INSERT INTO empleados (nombre, apellidos, puesto, especialidad, email, telefono, salario) VALUES
  ('Carlos', 'Garcia Ruiz',    'Instructor', 'Yoga y Pilates',    'carlos@fitlife.es', '611100001', 1800.00),
  ('Laura',  'Martinez Lopez', 'Instructor', 'CrossFit y HIIT',   'laura@fitlife.es',  '611100002', 1900.00),
  ('Marcos', 'Sanchez Vega',   'Recepcion',  NULL,                'marcos@fitlife.es', '611100003', 1400.00),
  ('Sofia',  'Perez Diaz',     'Instructor', 'Spinning y Cardio', 'sofia@fitlife.es',  '611100004', 1850.00);

-- -----------------------------------------------------------
-- Salas
-- -----------------------------------------------------------
INSERT INTO salas (nombre, capacidad, equipamiento) VALUES
  ('Sala Cardio',     30, 'Cintas de correr, bicicletas estaticas, elipticas'),
  ('Sala Grupal A',   20, 'Colchonetas, pesas ligeras, espejo de pared a pared'),
  ('Sala Spinning',   15, 'Bicicletas spinning, sistema de sonido profesional'),
  ('Sala Musculacion',40, 'Maquinaria de fuerza, pesas libres, racks de sentadilla');

-- -----------------------------------------------------------
-- Socios
-- -----------------------------------------------------------
INSERT INTO socios (nombre, apellidos, dni, email, telefono, fecha_alta, id_membresia) VALUES
  ('Ana',    'Fernandez Gil',  '12345678A', 'ana@email.com',    '600111222', '2024-09-01', 2),
  ('Pedro',  'Lopez Moreno',   '23456789B', 'pedro@email.com',  '600222333', '2024-10-15', 1),
  ('Lucia',  'Gomez Torres',   '34567890C', 'lucia@email.com',  '600333444', '2025-01-10', 3),
  ('Javier', 'Hernandez Ruiz', '45678901D', 'javier@email.com', '600444555', '2025-02-20', 2),
  ('Marta',  'Jimenez Vidal',  '56789012E', 'marta@email.com',  '600555666', '2025-03-05', 1);

-- -----------------------------------------------------------
-- Clases
-- -----------------------------------------------------------
INSERT INTO clases (nombre, descripcion, capacidad_max, horario_inicio, horario_fin, dia_semana, id_sala, id_empleado) VALUES
  ('Yoga Matutino',  'Clase de yoga para todos los niveles',          15, '09:00', '10:00', 'Lunes',    2, 1),
  ('HIIT Intensivo', 'Entrenamiento de alta intensidad por intervalos',12, '19:00', '20:00', 'Martes',   2, 2),
  ('Spinning',       'Ciclismo indoor con musica motivadora',          15, '18:00', '19:00', 'Miercoles',3, 4),
  ('Pilates',        'Fortalecimiento del core y flexibilidad',        15, '10:00', '11:00', 'Jueves',   2, 1),
  ('CrossFit',       'Entrenamiento funcional en equipo',              10, '07:00', '08:00', 'Viernes',  2, 2);

-- -----------------------------------------------------------
-- Reservas
-- -----------------------------------------------------------
INSERT INTO reservas (id_socio, id_clase, fecha_reserva, estado) VALUES
  (1, 1, '2025-05-05', 'confirmada'),
  (1, 3, '2025-05-07', 'confirmada'),
  (2, 2, '2025-05-06', 'confirmada'),
  (3, 1, '2025-05-05', 'confirmada'),
  (4, 5, '2025-05-09', 'confirmada'),
  (5, 2, '2025-05-06', 'cancelada'),
  (2, 4, '2025-05-08', 'confirmada');

-- -----------------------------------------------------------
-- Pagos
-- -----------------------------------------------------------
INSERT INTO pagos (id_socio, importe, fecha_pago, metodo_pago, concepto) VALUES
  (1, 49.90,  '2025-05-01', 'domiciliacion', 'Cuota Mayo - Premium'),
  (2, 29.90,  '2025-05-01', 'domiciliacion', 'Cuota Mayo - Basica'),
  (3, 299.00, '2025-01-10', 'tarjeta',       'Membresia Anual 2025'),
  (4, 49.90,  '2025-05-01', 'tarjeta',       'Cuota Mayo - Premium'),
  (5, 29.90,  '2025-05-02', 'efectivo',      'Cuota Mayo - Basica');
