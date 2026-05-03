-- ============================================================
--  FitLife Gym - Gestión de Usuarios y Administración Básica
--  Módulo 0372 - Gestión de Bases de Datos
--  1º ASIR - Proyecto Intermodular
--  Fecha: 2025-05-03
-- ============================================================

USE fitlife_gym;

-- ============================================================
-- 1. CREACIÓN DE USUARIOS
-- Se definen tres niveles de acceso según el rol en el sistema
-- ============================================================

-- Usuario para la aplicación web (acceso limitado, operativa diaria)
CREATE USER IF NOT EXISTS 'fitlife_app'@'localhost' IDENTIFIED BY 'App_S3cure!2025';
GRANT SELECT, INSERT, UPDATE ON fitlife_gym.socios    TO 'fitlife_app'@'localhost';
GRANT SELECT, INSERT         ON fitlife_gym.reservas  TO 'fitlife_app'@'localhost';
GRANT SELECT                 ON fitlife_gym.clases    TO 'fitlife_app'@'localhost';
GRANT SELECT                 ON fitlife_gym.membresias TO 'fitlife_app'@'localhost';
GRANT SELECT                 ON fitlife_gym.salas     TO 'fitlife_app'@'localhost';
GRANT INSERT                 ON fitlife_gym.pagos     TO 'fitlife_app'@'localhost';

-- Usuario para el administrador del sistema (control total)
CREATE USER IF NOT EXISTS 'fitlife_admin'@'localhost' IDENTIFIED BY 'Admin_S3cure!2025';
GRANT ALL PRIVILEGES ON fitlife_gym.* TO 'fitlife_admin'@'localhost';

-- Usuario de solo lectura para generación de informes
CREATE USER IF NOT EXISTS 'fitlife_reportes'@'localhost' IDENTIFIED BY 'Report_S3cure!2025';
GRANT SELECT ON fitlife_gym.* TO 'fitlife_reportes'@'localhost';

-- Aplicar cambios de privilegios
FLUSH PRIVILEGES;


-- ============================================================
-- 2. VERIFICAR PRIVILEGIOS DE UN USUARIO
-- ============================================================
SHOW GRANTS FOR 'fitlife_app'@'localhost';
SHOW GRANTS FOR 'fitlife_admin'@'localhost';
SHOW GRANTS FOR 'fitlife_reportes'@'localhost';


-- ============================================================
-- 3. REVOCAR PRIVILEGIOS (ejemplo)
-- Útil si un empleado cambia de rol o causa de baja
-- ============================================================
-- REVOKE INSERT ON fitlife_gym.pagos FROM 'fitlife_app'@'localhost';
-- DROP USER IF EXISTS 'fitlife_reportes'@'localhost';


-- ============================================================
-- 4. COPIAS DE SEGURIDAD (ejecutar desde la terminal del SO)
-- ============================================================

-- Backup completo de la base de datos (estructura + datos)
-- mysqldump -u fitlife_admin -p fitlife_gym > backup_fitlife_$(date +%Y%m%d).sql

-- Backup solo de la estructura sin datos
-- mysqldump -u fitlife_admin -p --no-data fitlife_gym > estructura_fitlife.sql

-- Backup de una tabla concreta
-- mysqldump -u fitlife_admin -p fitlife_gym socios > backup_socios.sql

-- Restaurar desde backup
-- mysql -u fitlife_admin -p fitlife_gym < backup_fitlife_20250503.sql

-- Automatización diaria con cron (Linux) - ejecutar a las 2:00 AM cada día:
-- 0 2 * * * mysqldump -u fitlife_admin -pAdmin_S3cure!2025 fitlife_gym > /backups/fitlife_$(date +\%Y\%m\%d).sql


-- ============================================================
-- 5. EXPORTACIÓN DE DATOS A CSV
-- ============================================================

-- Exportar tabla de socios a CSV (requiere permisos FILE en MySQL)
-- SELECT s.nombre, s.apellidos, s.email, m.tipo
-- INTO OUTFILE '/tmp/socios_fitlife.csv'
--   FIELDS TERMINATED BY ',' ENCLOSED BY '"'
--   LINES TERMINATED BY '\n'
-- FROM socios s JOIN membresias m ON s.id_membresia = m.id_membresia;

-- Alternativa con mysqldump en formato CSV:
-- mysqldump -u fitlife_admin -p --tab=/tmp --fields-terminated-by=',' fitlife_gym socios


-- ============================================================
-- 6. MANTENIMIENTO DE TABLAS
-- ============================================================

-- Analizar estadísticas de tablas (mejora el rendimiento de consultas)
ANALYZE TABLE socios;
ANALYZE TABLE reservas;
ANALYZE TABLE pagos;

-- Optimizar tablas (elimina espacio fragmentado)
OPTIMIZE TABLE socios;
OPTIMIZE TABLE reservas;

-- Ver el tamaño de las tablas en la base de datos
SELECT
  table_name      AS tabla,
  table_rows      AS filas_estimadas,
  ROUND((data_length + index_length) / 1024, 2) AS tamano_kb
FROM information_schema.tables
WHERE table_schema = 'fitlife_gym'
ORDER BY tamano_kb DESC;
