
CREATE DATABASE UNIVERSIDAD ;
USE UNIVERSIDAD ;

CREATE TABLE Facultad (
    idFacultad INT PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE Profesor (
    idProfesor INT PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(50),
    idFacultad INT,
    FOREIGN KEY (idFacultad) REFERENCES Facultad(idFacultad)
);

CREATE TABLE Estudiante (
    idEstudiante INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(100)
);

CREATE TABLE Carrera (
    idCarrera INT PRIMARY KEY,
    nombre VARCHAR(50),
    duracion INT
);

CREATE TABLE Curso (
    idCurso INT PRIMARY KEY,
    nombre VARCHAR(50),
    idCarrera INT,
    FOREIGN KEY (idCarrera) REFERENCES Carrera(idCarrera)
);

CREATE TABLE Aula (
    idAula INT PRIMARY KEY,
    nombre VARCHAR(50),
    capacidad INT
);

CREATE TABLE Biblioteca (
    idBiblioteca INT PRIMARY KEY,
    nombre VARCHAR(50),
    direccion VARCHAR(100)
);

CREATE TABLE Estudiante_Curso (
    idEstudiante INT,
    idCurso INT,
    nota DECIMAL(5,2),
    PRIMARY KEY (idEstudiante, idCurso),
    FOREIGN KEY (idEstudiante) REFERENCES Estudiante(idEstudiante),
    FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Profesor_Curso (
    idProfesor INT,
    idCurso INT,
    PRIMARY KEY (idProfesor, idCurso),
    FOREIGN KEY (idProfesor) REFERENCES Profesor(idProfesor),
    FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);

INSERT INTO Facultad VALUES (1, 'Ingeniería');
INSERT INTO Profesor VALUES (1, 'Julio Rojas', 'Programación', 1);
INSERT INTO Estudiante VALUES (1, 'Carla López', 'carla@gmail.com');
INSERT INTO Carrera VALUES (1, 'Sistemas', 5);
INSERT INTO Curso VALUES (1, 'Bases de Datos', 1);
INSERT INTO Aula VALUES (1, 'Aula 101', 40);
INSERT INTO Biblioteca VALUES (1, 'Central', 'Calle 20 #5-10');
INSERT INTO Estudiante_Curso VALUES (1, 1, 4.5);
INSERT INTO Profesor_Curso VALUES (1, 1);

SELECT nombre FROM Estudiante;

DELETE FROM Estudiante WHERE idEstudiante = 1;

CREATE FUNCTION PromedioNotas_Universidad (@idEstudiante INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @promedio DECIMAL(5,2);
    SELECT @promedio = AVG(nota) FROM Estudiante_Curso WHERE idEstudiante = @idEstudiante;
    RETURN @promedio;
END;

CREATE PROCEDURE InscribirEstudianteCurso_Universidad
    @idEstudiante INT,
    @idCurso INT,
    @nota DECIMAL(5,2)
AS
BEGIN
    INSERT INTO Estudiante_Curso VALUES (@idEstudiante, @idCurso, @nota);
END;

SELECT nombre FROM Estudiante WHERE idEstudiante IN (
    SELECT idEstudiante FROM Estudiante_Curso
);


