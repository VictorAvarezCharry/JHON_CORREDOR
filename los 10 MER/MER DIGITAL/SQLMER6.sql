CREATE DATABASE HOSPITAL;
USE HOSPITAL;


CREATE TABLE Area (
    idArea INT PRIMARY KEY,
    nombre VARCHAR(50),
    piso INT
);

CREATE TABLE Sala (
    idSala INT PRIMARY KEY,
    nombre VARCHAR(50),
    capacidad INT,
    idArea INT,
    FOREIGN KEY (idArea) REFERENCES Area(idArea)
);

CREATE TABLE Doctor (
    idDoctor INT PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(50),
    idSala INT,
    FOREIGN KEY (idSala) REFERENCES Sala(idSala)
);

CREATE TABLE Enfermera (
    idEnfermera INT PRIMARY KEY,
    nombre VARCHAR(50),
    turno VARCHAR(50),
    idSala INT,
    FOREIGN KEY (idSala) REFERENCES Sala(idSala)
);

CREATE TABLE Paciente (
    idPaciente INT PRIMARY KEY,
    nombre VARCHAR(50),
    edad INT
);

CREATE TABLE Examen (
    idExamen INT PRIMARY KEY,
    nombre VARCHAR(50),
    resultado VARCHAR(50)
);

CREATE TABLE Equipo (
    idEquipo INT PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion VARCHAR(100)
);

CREATE TABLE Paciente_Examen (
    idPaciente INT,
    idExamen INT,
    PRIMARY KEY (idPaciente, idExamen),
    FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente),
    FOREIGN KEY (idExamen) REFERENCES Examen(idExamen)
);

CREATE TABLE Sala_Equipo (
    idSala INT,
    idEquipo INT,
    PRIMARY KEY (idSala, idEquipo),
    FOREIGN KEY (idSala) REFERENCES Sala(idSala),
    FOREIGN KEY (idEquipo) REFERENCES Equipo(idEquipo)
);


INSERT INTO Area VALUES (1, 'Urgencias', 1);
INSERT INTO Sala VALUES (1, 'Sala A', 10, 1);
INSERT INTO Doctor VALUES (1, 'Dr. Ramírez', 'Cardiología', 1);
INSERT INTO Enfermera VALUES (1, 'Nancy Pérez', 'Noche', 1);
INSERT INTO Paciente VALUES (1, 'Luis Torres', 45);
INSERT INTO Examen VALUES (1, 'Electrocardiograma', 'Normal');
INSERT INTO Equipo VALUES (1, 'Desfibrilador', 'Uso en paro cardíaco');
INSERT INTO Paciente_Examen VALUES (1, 1);
INSERT INTO Sala_Equipo VALUES (1, 1);


SELECT nombre FROM Paciente;


DELETE FROM Paciente WHERE idPaciente = 1;

CREATE FUNCTION TotalExamenesPorPaciente_Hospital (@idPaciente INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT;
    SELECT @total = COUNT(*) FROM Paciente_Examen WHERE idPaciente = @idPaciente;
    RETURN ISNULL(@total, 0);
END;

CREATE PROCEDURE AsignarEquipoSala_Hospital
    @idSala INT,
    @idEquipo INT
AS
BEGIN
    INSERT INTO Sala_Equipo VALUES (@idSala, @idEquipo);
END;


SELECT nombre FROM Paciente WHERE idPaciente IN (
    SELECT idPaciente FROM Paciente_Examen
);


