-- ============================================================
--  FitLife Gym - Script de Creación de Base de Datos
--  Módulo 0372 - Gestión de Bases de Datos
--  1º ASIR - Proyecto Intermodular
--  Fecha: 2025-05-03
-- ============================================================

CREATE DATABASE IF NOT EXISTS fitlife_gym
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE fitlife_gym;

-- -----------------------------------------------------------
-- Tabla: membresias
-- Almacena los tipos de membresía disponibles en el gimnasio
-- -----------------------------------------------------------
CREATE TABLE membresias (
  id_membresia   INT            AUTO_INCREMENT PRIMARY KEY,
  tipo           VARCHAR(50)    NOT NULL,
  precio_mensual DECIMAL(8,2)   NOT NULL,
  descripcion    TEXT
);

-- -----------------------------------------------------------
-- Tabla: socios
-- Almacena los datos de los clientes del gimnasio
-- -----------------------------------------------------------
CREATE TABLE socios (
  id_socio     INT          AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL,
  apellidos    VARCHAR(150) NOT NULL,
  dni          VARCHAR(9)   UNIQUE NOT NULL,
  email        VARCHAR(150) UNIQUE NOT NULL,
  telefono     VARCHAR(15),
  fecha_alta   DATE         NOT NULL DEFAULT (CURDATE()),
  id_membresia INT          NOT NULL,
  FOREIGN KEY (id_membresia) REFERENCES membresias(id_membresia)
);

-- -----------------------------------------------------------
-- Tabla: empleados
-- Almacena instructores y personal del gimnasio
-- -----------------------------------------------------------
CREATE TABLE empleados (
  id_empleado  INT           AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(100)  NOT NULL,
  apellidos    VARCHAR(150)  NOT NULL,
  puesto       VARCHAR(80)   NOT NULL,
  especialidad VARCHAR(100),
  email        VARCHAR(150)  UNIQUE,
  telefono     VARCHAR(15),
  salario      DECIMAL(10,2)
);

-- -----------------------------------------------------------
-- Tabla: salas
-- Espacios físicos del gimnasio donde se imparten clases
-- -----------------------------------------------------------
CREATE TABLE salas (
  id_sala      INT          AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(80)  NOT NULL,
  capacidad    INT          NOT NULL,
  equipamiento TEXT
);

-- -----------------------------------------------------------
-- Tabla: clases
-- Clases grupales ofertadas por el gimnasio
-- -----------------------------------------------------------
CREATE TABLE clases (
  id_clase      INT          AUTO_INCREMENT PRIMARY KEY,
  nombre        VARCHAR(100) NOT NULL,
  descripcion   TEXT,
  capacidad_max INT          NOT NULL,
  horario_inicio TIME        NOT NULL,
  horario_fin   TIME         NOT NULL,
  dia_semana    ENUM('Lunes','Martes','Miercoles','Jueves',
                     'Viernes','Sabado','Domingo') NOT NULL,
  id_sala       INT          NOT NULL,
  id_empleado   INT          NOT NULL,
  FOREIGN KEY (id_sala)     REFERENCES salas(id_sala),
  FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- -----------------------------------------------------------
-- Tabla: reservas
-- Registro de inscripciones de socios a clases
-- -----------------------------------------------------------
CREATE TABLE reservas (
  id_reserva    INT  AUTO_INCREMENT PRIMARY KEY,
  id_socio      INT  NOT NULL,
  id_clase      INT  NOT NULL,
  fecha_reserva DATE NOT NULL DEFAULT (CURDATE()),
  estado        ENUM('confirmada','cancelada','pendiente')
                     NOT NULL DEFAULT 'confirmada',
  FOREIGN KEY (id_socio) REFERENCES socios(id_socio),
  FOREIGN KEY (id_clase) REFERENCES clases(id_clase),
  UNIQUE KEY uq_reserva (id_socio, id_clase, fecha_reserva)
);

-- -----------------------------------------------------------
-- Tabla: pagos
-- Registro de todos los cobros realizados a socios
-- -----------------------------------------------------------
CREATE TABLE pagos (
  id_pago     INT           AUTO_INCREMENT PRIMARY KEY,
  id_socio    INT           NOT NULL,
  importe     DECIMAL(8,2)  NOT NULL,
  fecha_pago  DATE          NOT NULL DEFAULT (CURDATE()),
  metodo_pago ENUM('efectivo','tarjeta','transferencia','domiciliacion')
                            NOT NULL,
  concepto    VARCHAR(200),
  FOREIGN KEY (id_socio) REFERENCES socios(id_socio)
);
