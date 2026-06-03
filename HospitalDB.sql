CREATE DATABASE HospitalDB
GO

SELECT name, database_id, create_date, state_desc
FROM sys.databases
ORDER BY name;
GO

USE HospitalDB;
GO

CREATE TABLE Pacientes (
    paciente_id   INT           NOT NULL,
    nombre        VARCHAR(100)  NOT NULL,
    apellido      VARCHAR(100)  NOT NULL,
    edad          INT           NOT NULL,
    correo        VARCHAR(150)  NULL,
    fecha_registro DATETIME     NOT NULL
);
GO
 
CREATE TABLE Especialidades (
    especialidad_id INT          NOT NULL,
    nombre          VARCHAR(100) NOT NULL,
    descripcion     VARCHAR(255) NULL
);
GO
 
CREATE TABLE Medicos (
    medico_id       INT           NOT NULL,
    nombre          VARCHAR(100)  NOT NULL,
    apellido        VARCHAR(100)  NOT NULL,
    correo          VARCHAR(150)  NULL,
    salario         DECIMAL(10,2) NOT NULL,
    especialidad_id INT           NULL
);
GO
 
CREATE TABLE Citas (
    cita_id      INT      NOT NULL,
    paciente_id  INT      NOT NULL,
    medico_id    INT      NOT NULL,
    fecha_cita   DATETIME NOT NULL,
    motivo       VARCHAR(255) NULL
);
GO
 
CREATE TABLE Habitaciones (
    habitacion_id INT          NOT NULL,
    numero        VARCHAR(10)  NOT NULL,
    tipo          VARCHAR(50)  NULL,
    paciente_id   INT          NULL
);
GO
 
CREATE TABLE Tratamientos (
    tratamiento_id INT          NOT NULL,
    paciente_id    INT          NOT NULL,
    descripcion    VARCHAR(255) NULL,
    fecha_inicio   DATE         NOT NULL,
    fecha_fin      DATE         NULL
);
GO
 
CREATE TABLE Medicamentos (
    medicamento_id INT          NOT NULL,
    nombre         VARCHAR(100) NOT NULL,
    dosis          VARCHAR(100) NULL,
    tratamiento_id INT          NOT NULL,
    fecha_vencimiento DATE      NULL
);
GO

--Modulo 2
ALTER TABLE Pacientes
    ADD CONSTRAINT PK_Pacientes PRIMARY KEY (paciente_id);
GO
 
-- 2. Definir PRIMARY KEY en Médicos
ALTER TABLE Medicos
    ADD CONSTRAINT PK_Medicos PRIMARY KEY (medico_id);
GO
 
ALTER TABLE Especialidades
    ADD CONSTRAINT PK_Especialidades PRIMARY KEY (especialidad_id);
GO
 
ALTER TABLE Citas
    ADD CONSTRAINT PK_Citas PRIMARY KEY (cita_id);
GO
 
ALTER TABLE Habitaciones
    ADD CONSTRAINT PK_Habitaciones PRIMARY KEY (habitacion_id);
GO
 
ALTER TABLE Tratamientos
    ADD CONSTRAINT PK_Tratamientos PRIMARY KEY (tratamiento_id);
GO
 
ALTER TABLE Medicamentos
    ADD CONSTRAINT PK_Medicamentos PRIMARY KEY (medicamento_id);
GO
 
ALTER TABLE Pacientes
    ALTER COLUMN nombre VARCHAR(100) NOT NULL;
GO
 
ALTER TABLE Medicos
    ALTER COLUMN nombre VARCHAR(100) NOT NULL;
GO
 
ALTER TABLE Pacientes
    ADD CONSTRAINT UQ_Pacientes_Correo UNIQUE (correo);
GO
 
ALTER TABLE Medicos
    ADD CONSTRAINT UQ_Medicos_Correo UNIQUE (correo);
GO
 
ALTER TABLE Pacientes
    ADD CONSTRAINT CHK_Pacientes_Edad CHECK (edad >= 0);
GO
 
ALTER TABLE Medicos
    ADD CONSTRAINT CHK_Medicos_Salario CHECK (salario > 0);
GO
 
ALTER TABLE Pacientes
    ADD CONSTRAINT DF_Pacientes_FechaRegistro DEFAULT GETDATE() FOR fecha_registro;
GO
 
ALTER TABLE Medicos
    ADD CONSTRAINT FK_Medicos_Especialidades
    FOREIGN KEY (especialidad_id) REFERENCES Especialidades(especialidad_id);
GO
 
ALTER TABLE Citas
    ADD CONSTRAINT FK_Citas_Pacientes
    FOREIGN KEY (paciente_id) REFERENCES Pacientes(paciente_id);
GO
 
ALTER TABLE Citas
    ADD CONSTRAINT FK_Citas_Medicos
    FOREIGN KEY (medico_id) REFERENCES Medicos(medico_id);
GO
 
ALTER TABLE Tratamientos
    ADD CONSTRAINT FK_Tratamientos_Pacientes
    FOREIGN KEY (paciente_id) REFERENCES Pacientes(paciente_id);
GO
 
ALTER TABLE Medicamentos
    ADD CONSTRAINT FK_Medicamentos_Tratamientos
    FOREIGN KEY (tratamiento_id) REFERENCES Tratamientos(tratamiento_id);
GO
 
ALTER TABLE Habitaciones
    ADD CONSTRAINT FK_Habitaciones_Pacientes
    FOREIGN KEY (paciente_id) REFERENCES Pacientes(paciente_id);
GO

ALTER TABLE Pacientes
    ADD telefono VARCHAR(20) NULL;
GO
 
ALTER TABLE Pacientes
    ADD direccion VARCHAR(200) NULL;
GO
 
ALTER TABLE Pacientes
    ADD genero CHAR(1) NULL;
GO
 
ALTER TABLE Pacientes
    ADD tipo_sangre VARCHAR(5) NULL;
GO
 
ALTER TABLE Pacientes
    ADD fecha_nacimiento DATE NULL;
GO
 
ALTER TABLE Pacientes
    ALTER COLUMN nombre VARCHAR(150) NOT NULL;
GO
 
ALTER TABLE Pacientes
    ALTER COLUMN direccion VARCHAR(300) NULL;
GO
 
ALTER TABLE Medicos
    ADD experiencia INT NULL;
GO
 
ALTER TABLE Medicos
    ADD turno VARCHAR(20) NULL;
GO
 
ALTER TABLE Medicos
    ADD observaciones VARCHAR(500) NULL;
GO
 
ALTER TABLE Medicos
    DROP COLUMN observaciones;
GO
 
ALTER TABLE Citas
    ADD estado VARCHAR(20) NULL;
GO
 
ALTER TABLE Citas
    ADD costo_consulta FLOAT NULL;
GO
 
ALTER TABLE Citas
    ALTER COLUMN costo_consulta DECIMAL(10,2) NULL;
GO
 
ALTER TABLE Habitaciones
    ADD disponibilidad BIT NOT NULL DEFAULT 1;
GO
 
-- 1. Eliminar una tabla temporal
CREATE TABLE Temporal (
    id   INT          NOT NULL,
    dato VARCHAR(100) NULL
);
GO
 
DROP TABLE Temporal;
GO
 
-- 2. Eliminar una restricción CHECK
ALTER TABLE Pacientes
    ADD CONSTRAINT CHK_Pacientes_Genero CHECK (genero IN ('M', 'F', 'O'));
GO
 
ALTER TABLE Pacientes
    DROP CONSTRAINT CHK_Pacientes_Genero;
GO
 
-- 3. Eliminar una restricción UNIQUE
ALTER TABLE Pacientes
    ADD CONSTRAINT UQ_Pacientes_Telefono UNIQUE (telefono);
GO
 
ALTER TABLE Pacientes
    DROP CONSTRAINT UQ_Pacientes_Telefono;
GO
 
-- 4. Eliminar una columna
ALTER TABLE Pacientes
    ADD columna_prueba VARCHAR(50) NULL;
GO
 
ALTER TABLE Pacientes
    DROP COLUMN columna_prueba;
GO
 
-- 5. Eliminar una tabla de pruebas
CREATE TABLE TablaPrueba (
    id          INT          NOT NULL,
    descripcion VARCHAR(100) NULL
);
GO
 
DROP TABLE TablaPrueba;
GO
 
-- 6. Crear y eliminar una tabla Auditoria
CREATE TABLE Auditoria (
    auditoria_id INT          NOT NULL,
    accion       VARCHAR(100) NULL,
    fecha        DATETIME     NULL
);
GO
 
DROP TABLE Auditoria;
GO
 
-- 7. Crear y eliminar una tabla Logs
CREATE TABLE Logs (
    log_id   INT          NOT NULL,
    mensaje  VARCHAR(255) NULL,
    fecha    DATETIME     NULL
);
GO
 
DROP TABLE Logs;
GO
 
-- 8. Eliminar una FOREIGN KEY
ALTER TABLE Habitaciones
    ADD CONSTRAINT FK_Habitaciones_Prueba
    FOREIGN KEY (paciente_id) REFERENCES Pacientes(paciente_id);
GO
 
ALTER TABLE Habitaciones
    DROP CONSTRAINT FK_Habitaciones_Prueba;
GO
 
ALTER TABLE Habitaciones
    ADD CONSTRAINT FK_Habitaciones_Pacientes
    FOREIGN KEY (paciente_id) REFERENCES Pacientes(paciente_id);
GO
 
-- 9. Eliminar una tabla MedicamentosPrueba
CREATE TABLE MedicamentosPrueba (
    medicamento_id INT          NOT NULL,
    nombre         VARCHAR(100) NULL
);
GO
 
DROP TABLE MedicamentosPrueba;
GO
 
-- 10. Eliminar una base de datos de pruebas
CREATE DATABASE HospitalDB_Prueba;
GO
 
USE HospitalDB;
GO
 
DROP DATABASE HospitalDB_Prueba;
GO


-- 1. Insertar 5 especialidades médicas
INSERT INTO Especialidades (especialidad_id, nombre, descripcion) VALUES
(1, 'Cardiología',     'Diagnóstico y tratamiento de enfermedades del corazón'),
(2, 'Neurología',      'Diagnóstico y tratamiento de enfermedades del sistema nervioso'),
(3, 'Pediatría',       'Atención médica de niños y adolescentes'),
(4, 'Ortopedia',       'Diagnóstico y tratamiento del sistema musculoesquelético'),
(5, 'Dermatología',    'Diagnóstico y tratamiento de enfermedades de la piel');
GO
 
-- 2. Insertar 10 médicos
INSERT INTO Medicos (medico_id, nombre, apellido, correo, salario, especialidad_id, experiencia, turno) VALUES
(1,  'Carlos',    'Pérez',      'carlos.perez@hospital.com',    75000.00, 1, 10, 'Mañana'),
(2,  'Ana',       'Gómez',      'ana.gomez@hospital.com',       80000.00, 2, 15, 'Tarde'),
(3,  'Luis',      'Martínez',   'luis.martinez@hospital.com',   70000.00, 3, 8,  'Mañana'),
(4,  'María',     'López',      'maria.lopez@hospital.com',     85000.00, 4, 12, 'Noche'),
(5,  'Jorge',     'Rodríguez',  'jorge.rodriguez@hospital.com', 78000.00, 5, 9,  'Tarde'),
(6,  'Sofía',     'Hernández',  'sofia.hernandez@hospital.com', 72000.00, 1, 6,  'Mañana'),
(7,  'Miguel',    'García',     'miguel.garcia@hospital.com',   90000.00, 2, 20, 'Tarde'),
(8,  'Laura',     'Torres',     'laura.torres@hospital.com',    68000.00, 3, 5,  'Noche'),
(9,  'Roberto',   'Ramírez',    'roberto.ramirez@hospital.com', 82000.00, 4, 14, 'Mañana'),
(10, 'Patricia',  'Flores',     'patricia.flores@hospital.com', 76000.00, 5, 11, 'Tarde');
GO
 
-- 3. Insertar 20 pacientes
INSERT INTO Pacientes (paciente_id, nombre, apellido, edad, correo, fecha_registro) VALUES
(1,  'Juan',      'Álvarez',    35, 'juan.alvarez@email.com',    '2024-01-10'),
(2,  'María',     'Castillo',   28, 'maria.castillo@email.com',  '2024-01-15'),
(3,  'Pedro',     'Jiménez',    45, 'pedro.jimenez@email.com',   '2024-02-03'),
(4,  'Lucía',     'Vargas',     32, 'lucia.vargas@email.com',    '2024-02-20'),
(5,  'Andrés',    'Moreno',     50, 'andres.moreno@email.com',   '2024-03-05'),
(6,  'Carmen',    'Ruiz',       23, 'carmen.ruiz@email.com',     '2024-03-18'),
(7,  'Felipe',    'Núñez',      60, 'felipe.nunez@email.com',    '2024-04-01'),
(8,  'Isabel',    'Ortega',     41, 'isabel.ortega@email.com',   '2024-04-12'),
(9,  'Diego',     'Soto',       29, 'diego.soto@email.com',      '2024-04-25'),
(10, 'Valentina', 'Rojas',      37, 'valentina.rojas@email.com', '2024-05-08'),
(11, 'Sebastián', 'Mendoza',    55, 'sebastian.mendoza@email.com','2024-05-20'),
(12, 'Daniela',   'Ríos',       26, 'daniela.rios@email.com',    '2024-06-02'),
(13, 'Gabriel',   'Pena',       48, 'gabriel.pena@email.com',    '2024-06-14'),
(14, 'Natalia',   'Herrera',    33, 'natalia.herrera@email.com', '2024-07-01'),
(15, 'Ricardo',   'Aguilar',    44, 'ricardo.aguilar@email.com', '2024-07-15'),
(16, 'Paola',     'Vega',       31, 'paola.vega@email.com',      '2024-08-03'),
(17, 'Esteban',   'Guzmán',     58, 'esteban.guzman@email.com',  '2024-08-19'),
(18, 'Camila',    'Delgado',    22, 'camila.delgado@email.com',  '2024-09-07'),
(19, 'Héctor',    'Reyes',      39, 'hector.reyes@email.com',    '2024-09-22'),
(20, 'Adriana',   'Medina',     46, 'adriana.medina@email.com',  '2024-10-10');
GO
 
-- 4. Insertar 15 citas
INSERT INTO Citas (cita_id, paciente_id, medico_id, fecha_cita, motivo, estado, costo_consulta) VALUES
(1,  1,  1,  '2024-11-01 08:00:00', 'Control cardiológico',        'Completada', 500.00),
(2,  2,  2,  '2024-11-02 09:00:00', 'Dolor de cabeza frecuente',   'Completada', 600.00),
(3,  3,  3,  '2024-11-03 10:00:00', 'Control pediátrico',          'Completada', 400.00),
(4,  4,  4,  '2024-11-05 11:00:00', 'Dolor en rodilla',            'Completada', 550.00),
(5,  5,  5,  '2024-11-07 08:30:00', 'Revisión piel',               'Completada', 450.00),
(6,  6,  1,  '2024-11-10 09:30:00', 'Palpitaciones',               'Cancelada',  500.00),
(7,  7,  2,  '2024-11-12 10:30:00', 'Mareos constantes',           'Completada', 600.00),
(8,  8,  6,  '2024-11-14 11:30:00', 'Arritmia',                    'Completada', 500.00),
(9,  9,  7,  '2024-11-15 08:00:00', 'Migraña crónica',             'Cancelada',  600.00),
(10, 10, 3,  '2024-11-18 09:00:00', 'Vacunación infantil',         'Completada', 400.00),
(11, 11, 8,  '2024-11-20 10:00:00', 'Fiebre persistente',          'Completada', 400.00),
(12, 12, 4,  '2024-11-22 11:00:00', 'Fractura de tobillo',         'Completada', 700.00),
(13, 13, 9,  '2024-11-25 08:30:00', 'Rehabilitación hombro',       'Completada', 550.00),
(14, 14, 5,  '2024-11-27 09:30:00', 'Dermatitis',                  'Cancelada',  450.00),
(15, 15, 10, '2024-11-29 10:30:00', 'Acné severo',                 'Completada', 450.00);
GO
 
-- 5. Insertar 10 habitaciones
INSERT INTO Habitaciones (habitacion_id, numero, tipo, paciente_id, disponibilidad) VALUES
(1,  '101', 'Individual',   1,    0),
(2,  '102', 'Individual',   2,    0),
(3,  '103', 'Doble',        3,    0),
(4,  '104', 'Doble',        NULL, 1),
(5,  '105', 'UCI',          4,    0),
(6,  '106', 'UCI',          NULL, 1),
(7,  '201', 'Individual',   5,    0),
(8,  '202', 'Individual',   NULL, 1),
(9,  '203', 'Suite',        6,    0),
(10, '204', 'Suite',        NULL, 1);
GO
 
-- 6. Insertar 10 tratamientos
INSERT INTO Tratamientos (tratamiento_id, paciente_id, descripcion, fecha_inicio, fecha_fin) VALUES
(1,  1,  'Terapia antihipertensiva',      '2024-11-01', NULL),
(2,  2,  'Terapia antimigrañosa',         '2024-11-02', NULL),
(3,  3,  'Plan de vacunación completo',   '2024-11-03', '2024-12-03'),
(4,  4,  'Fisioterapia de rodilla',       '2024-11-05', NULL),
(5,  5,  'Tratamiento dermatológico',     '2024-11-07', '2024-12-07'),
(6,  6,  'Control de arritmia',           '2024-11-10', NULL),
(7,  7,  'Neurorrehabilitación',          '2024-11-12', '2025-01-12'),
(8,  8,  'Terapia cardiaca integral',     '2024-11-14', NULL),
(9,  9,  'Manejo de migraña crónica',     '2024-11-15', '2025-02-15'),
(10, 10, 'Esquema de vacunación adulto',  '2024-11-18', '2024-12-18');
GO
 
-- 7. Insertar 20 medicamentos
INSERT INTO Medicamentos (medicamento_id, nombre, dosis, tratamiento_id, fecha_vencimiento) VALUES
(1,  'Enalapril',       '10mg cada 12h',     1, '2026-06-01'),
(2,  'Amlodipino',      '5mg cada 24h',      1, '2026-08-01'),
(3,  'Sumatriptán',     '50mg al inicio',    2, '2026-07-01'),
(4,  'Valproato',       '500mg cada 12h',    2, '2026-09-01'),
(5,  'Vacuna DPT',      '0.5ml IM',          3, '2025-03-01'),
(6,  'Vacuna MMR',      '0.5ml SC',          3, '2025-04-01'),
(7,  'Ibuprofeno',      '400mg cada 8h',     4, '2026-05-01'),
(8,  'Diclofenaco gel', 'Aplicar 3 veces/día',4,'2025-12-01'),
(9,  'Tretinoína',      '0.025% cada noche', 5, '2026-01-01'),
(10, 'Clindamicina',    '1% cada 12h',       5, '2026-02-01'),
(11, 'Metoprolol',      '50mg cada 12h',     6, '2026-10-01'),
(12, 'Amiodarona',      '200mg cada 24h',    6, '2026-11-01'),
(13, 'Levetiracetam',   '500mg cada 12h',    7, '2025-08-01'),
(14, 'Pregabalina',     '75mg cada 12h',     7, '2025-09-01'),
(15, 'Bisoprolol',      '5mg cada 24h',      8, '2026-03-01'),
(16, 'Furosemida',      '40mg cada 24h',     8, '2026-04-01'),
(17, 'Rizatriptán',     '10mg al inicio',    9, '2025-06-01'),
(18, 'Topiramato',      '100mg cada 12h',    9, '2025-07-01'),
(19, 'Vacuna Hepatitis B','1ml IM',          10,'2025-10-01'),
(20, 'Vacuna Influenza', '0.5ml IM',         10,'2025-11-01');
GO
 
-- 8. Insertar pacientes con todos los campos
INSERT INTO Pacientes (paciente_id, nombre, apellido, edad, correo, fecha_registro, telefono, direccion, genero, tipo_sangre, fecha_nacimiento) VALUES
(21, 'Fernando', 'Blanco',   40, 'fernando.blanco@email.com', '2024-11-01', '8888-0001', 'Calle 1, Ciudad',   'M', 'O+', '1984-03-15'),
(22, 'Gabriela', 'Serrano',  27, 'gabriela.serrano@email.com','2024-11-02', '8888-0002', 'Av. Central 22',    'F', 'A+', '1997-07-20'),
(23, 'Tomás',    'Cano',     52, 'tomas.cano@email.com',      '2024-11-03', '8888-0003', 'Barrio Norte 5',    'M', 'B-', '1972-11-08');
GO
 
-- 9. Insertar médicos especialistas
INSERT INTO Medicos (medico_id, nombre, apellido, correo, salario, especialidad_id, experiencia, turno) VALUES
(11, 'Ramón',    'Espinoza',  'ramon.espinoza@hospital.com',  95000.00, 1, 25, 'Mañana'),
(12, 'Verónica', 'Paredes',   'veronica.paredes@hospital.com',88000.00, 2, 18, 'Tarde');
GO
 
-- 10. Insertar citas con fecha actual
INSERT INTO Citas (cita_id, paciente_id, medico_id, fecha_cita, motivo, estado, costo_consulta) VALUES
(16, 16, 1, GETDATE(), 'Consulta general cardiología',   'Pendiente', 500.00),
(17, 17, 2, GETDATE(), 'Evaluación neurológica urgente', 'Pendiente', 600.00);
GO
 
-- 11. Insertar citas futuras
INSERT INTO Citas (cita_id, paciente_id, medico_id, fecha_cita, motivo, estado, costo_consulta) VALUES
(18, 18,  3, DATEADD(DAY, 7,  GETDATE()), 'Control pediátrico programado', 'Pendiente', 400.00),
(19, 19,  4, DATEADD(DAY, 14, GETDATE()), 'Revisión ortopédica',           'Pendiente', 550.00),
(20, 20,  5, DATEADD(DAY, 30, GETDATE()), 'Seguimiento dermatológico',     'Pendiente', 450.00);
GO
 
-- 12. Insertar habitaciones ocupadas
INSERT INTO Habitaciones (habitacion_id, numero, tipo, paciente_id, disponibilidad) VALUES
(11, '301', 'Individual', 7,  0),
(12, '302', 'Doble',      8,  0);
GO
 
-- 13. Insertar habitaciones disponibles
INSERT INTO Habitaciones (habitacion_id, numero, tipo, paciente_id, disponibilidad) VALUES
(13, '303', 'Individual', NULL, 1),
(14, '304', 'Suite',      NULL, 1);
GO
 
-- 14. Insertar tratamientos activos
INSERT INTO Tratamientos (tratamiento_id, paciente_id, descripcion, fecha_inicio, fecha_fin) VALUES
(11, 11, 'Tratamiento antibiótico activo',    '2024-11-20', NULL),
(12, 12, 'Rehabilitación post-fractura',      '2024-11-22', NULL);
GO
 
-- 15. Insertar tratamientos finalizados
INSERT INTO Tratamientos (tratamiento_id, paciente_id, descripcion, fecha_inicio, fecha_fin) VALUES
(13, 13, 'Terapia de rehabilitación hombro', '2024-08-01', '2024-11-25'),
(14, 14, 'Tratamiento dermatitis leve',      '2024-09-01', '2024-11-27');
GO
