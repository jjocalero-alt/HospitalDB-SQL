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
