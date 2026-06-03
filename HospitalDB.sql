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
 
