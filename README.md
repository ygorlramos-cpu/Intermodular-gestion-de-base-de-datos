# 🏋️ FitLife Gym — Gestión de Bases de Datos

**Módulo:** — Gestión de Bases de Datos  
**Ciclo:** 1º ASIR — Administración de Sistemas Informáticos en Red  
**Proyecto:** Intermodular

---

## 📋 Descripción del proyecto

FitLife Gym es un gimnasio moderno que necesita gestionar de forma centralizada toda su información: socios, membresías, clases grupales, reservas, empleados, salas y pagos.

Este proyecto diseña, implementa y administra la base de datos que daría soporte al sistema de gestión del gimnasio, demostrando el ciclo completo de trabajo de un administrador de bases de datos en un entorno real.

---

## 🗂️ Estructura del repositorio

```
fitlife-gym-bd/
│
├── README.md                        ← Este archivo
│
├── docs/
│   ├── fitlife_gestion_bd.docx      ← Documentación principal (Word)
│   └── diagrama_er_fitlife.drawio   ← Diagrama E/R editable
│
└── sql/
    ├── 01_create.sql                ← Creación de tablas
    ├── 02_insert.sql                ← Datos de ejemplo
    ├── 03_queries.sql               ← Consultas útiles
    └── 04_users.sql                 ← Usuarios y administración
```

---

## 🗃️ Diseño de la base de datos

### Entidades principales

| Tabla | Descripción |
|---|---|
| `membresias` | Tipos de tarifa disponibles (Básica, Premium, Anual) |
| `socios` | Clientes del gimnasio con sus datos personales |
| `empleados` | Instructores y personal del centro |
| `salas` | Espacios físicos donde se imparten las clases |
| `clases` | Clases grupales con horario, sala e instructor asignado |
| `reservas` | Inscripciones de socios a clases grupales |
| `pagos` | Registro de todos los cobros realizados |

### Relaciones

```
MEMBRESIAS  (1) ──── (N)  SOCIOS
SOCIOS      (1) ──── (N)  RESERVAS
CLASES      (1) ──── (N)  RESERVAS
EMPLEADOS   (1) ──── (N)  CLASES
SALAS       (1) ──── (N)  CLASES
SOCIOS      (1) ──── (N)  PAGOS
```

### Modelo relacional

```
membresias  (id_membresia PK, tipo, precio_mensual, descripcion)
socios      (id_socio PK, nombre, apellidos, dni, email, telefono, fecha_alta, id_membresia FK)
empleados   (id_empleado PK, nombre, apellidos, puesto, especialidad, email, telefono, salario)
salas       (id_sala PK, nombre, capacidad, equipamiento)
clases      (id_clase PK, nombre, descripcion, capacidad_max, horario_inicio, horario_fin, dia_semana, id_sala FK, id_empleado FK)
reservas    (id_reserva PK, id_socio FK, id_clase FK, fecha_reserva, estado)
pagos       (id_pago PK, id_socio FK, importe, fecha_pago, metodo_pago, concepto)
```

---

## 🚀 Instrucciones de uso

### Requisitos
- MySQL 8.0+ o MariaDB 10.6+

### Ejecutar los scripts en orden

```bash
# 1. Crear la base de datos y tablas
mysql -u root -p < sql/01_create.sql

# 2. Insertar datos de ejemplo
mysql -u root -p fitlife_gym < sql/02_insert.sql

# 3. Ejecutar consultas (desde MySQL Workbench o terminal)
mysql -u root -p fitlife_gym < sql/03_queries.sql

# 4. Crear usuarios y tareas de administración
mysql -u root -p fitlife_gym < sql/04_users.sql
```

---

## 🔑 Usuarios del sistema

| Usuario | Nivel de acceso |
|---|---|
| `fitlife_app` | Operativa diaria (SELECT, INSERT, UPDATE en tablas clave) |
| `fitlife_admin` | Control total sobre la base de datos |
| `fitlife_reportes` | Solo lectura para informes |

---

## 💾 Copias de seguridad

```bash
# Backup completo
mysqldump -u fitlife_admin -p fitlife_gym > backup_fitlife_$(date +%Y%m%d).sql

# Restaurar
mysql -u fitlife_admin -p fitlife_gym < backup_fitlife_20250503.sql


---

*Proyecto realizado como parte del Proyecto Intermodular de 1º de ASIR
