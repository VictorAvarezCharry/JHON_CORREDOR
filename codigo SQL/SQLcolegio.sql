CREATE DATABASE Colegio;
USE Colegio;

-- DDL: CREACI�N DE TABLAS
CREATE TABLE Estudiante (
  id_estudiante INT PRIMARY KEY,
  nombre VARCHAR(100),
  correo VARCHAR(100),
  carrera VARCHAR(100)
);

CREATE TABLE Profesor (
  id_profesor INT PRIMARY KEY,
  nombre VARCHAR(100),
  especialidad VARCHAR(100)
);

CREATE TABLE Curso (
  id_curso INT PRIMARY KEY,
  nombre VARCHAR(100),
  creditos INT
);

CREATE TABLE Inscripcion (
  id_estudiante INT,
  id_curso INT,
  semestre VARCHAR(10),
  PRIMARY KEY (id_estudiante, id_curso),
  FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
  FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Curso_Profesor (
  id_curso INT,
  id_profesor INT,
  PRIMARY KEY (id_curso, id_profesor),
  FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
  FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor)
);

CREATE TABLE Nota (
  id_estudiante INT,
  id_curso INT,
  nota DECIMAL(3,1),
  PRIMARY KEY (id_estudiante, id_curso),
  FOREIGN KEY (id_estudiante, id_curso) REFERENCES Inscripcion(id_estudiante, id_curso)
);

CREATE TABLE Facultad (
  id_facultad INT PRIMARY KEY,
  nombre VARCHAR(100)
);

-- INSERT (5 por tabla)
INSERT INTO Facultad VALUES (1, 'Ingenier�a'), (2, 'Medicina'), (3, 'Derecho'), (4, 'Ciencias'), (5, 'Humanidades');

INSERT INTO Estudiante VALUES (1, 'Laura Ramos', 'laura@mail.com', 'Ingenier�a'), (2, 'Mario D�az', 'mario@mail.com', 'Medicina'), (3, 'Ana P�rez', 'ana@mail.com', 'Derecho'), (4, 'Luis Torres', 'luis@mail.com', 'Ciencias'), (5, 'Sof�a G�mez', 'sofia@mail.com', 'Humanidades');

INSERT INTO Profesor VALUES (1, 'Dr. Andrade', 'F�sica'), (2, 'Dra. Rivera', 'Biolog�a'), (3, 'Dr. Morales', 'Programaci�n'), (4, 'Dra. Mej�a', 'Psicolog�a'), (5, 'Dr. Castro', 'Derecho Penal');

INSERT INTO Curso VALUES (1, 'F�sica 1', 3), (2, 'Biolog�a General', 4), (3, 'Estructuras de Datos', 4), (4, 'Psicolog�a Social', 3), (5, 'Derecho Civil', 4);

INSERT INTO Curso_Profesor VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

INSERT INTO Inscripcion VALUES (1, 1, '2024-1'), (2, 2, '2024-1'), (3, 3, '2024-1'), (4, 4, '2024-1'), (5, 5, '2024-1');

INSERT INTO Nota VALUES (1, 1, 4.5), (2, 2, 3.8), (3, 3, 4.2), (4, 4, 4.9), (5, 5, 3.5);

-- SELECT (5 ejemplos)
SELECT e.nombre, c.nombre FROM Inscripcion i JOIN Estudiante e ON i.id_estudiante = e.id_estudiante JOIN Curso c ON i.id_curso = c.id_curso;
SELECT p.nombre, c.nombre FROM Curso_Profesor cp JOIN Profesor p ON cp.id_profesor = p.id_profesor JOIN Curso c ON cp.id_curso = c.id_curso;
SELECT e.nombre, n.nota FROM Nota n JOIN Estudiante e ON n.id_estudiante = e.id_estudiante;
SELECT nombre FROM Curso WHERE creditos > 3;
SELECT COUNT(*) AS total_estudiantes FROM Estudiante;

-- DELETE (5 ejemplos)
DELETE FROM Nota WHERE id_estudiante = 1 AND id_curso = 1;
DELETE FROM Inscripcion WHERE id_estudiante = 2 AND id_curso = 2;
DELETE FROM Curso_Profesor WHERE id_curso = 3 AND id_profesor = 3;
DELETE FROM Curso WHERE id_curso = 4;
DELETE FROM Profesor WHERE id_profesor = 5;

-- FUNCIONES (10)
CREATE FUNCTION promedioEstudiante(eid INT) RETURNS DECIMAL(3,1)
BEGIN DECLARE p DECIMAL(3,1);
SELECT AVG(nota) INTO p FROM Nota WHERE id_estudiante = eid;
RETURN p;
END;

CREATE FUNCTION cursosInscritos(eid INT) RETURNS INT
BEGIN DECLARE c INT;
SELECT COUNT(*) INTO c FROM Inscripcion WHERE id_estudiante = eid;
RETURN c;
END;

CREATE FUNCTION totalCursos() RETURNS INT
BEGIN DECLARE c INT;
SELECT COUNT(*) INTO c FROM Curso;
RETURN c;
END;

CREATE FUNCTION totalProfesores() RETURNS INT
BEGIN DECLARE c INT;
SELECT COUNT(*) INTO c FROM Profesor;
RETURN c;
END;

CREATE FUNCTION estudiantesPorCurso(cid INT) RETURNS INT
BEGIN DECLARE c INT;
SELECT COUNT(*) INTO c FROM Inscripcion WHERE id_curso = cid;
RETURN c;
END;

CREATE FUNCTION promedioCurso(cid INT) RETURNS DECIMAL(3,1)
BEGIN DECLARE p DECIMAL(3,1);
SELECT AVG(nota) INTO p FROM Nota WHERE id_curso = cid;
RETURN p;
END;

CREATE FUNCTION cantidadFacultades() RETURNS INT
BEGIN DECLARE c INT;
SELECT COUNT(*) INTO c FROM Facultad;
RETURN c;
END;

CREATE FUNCTION estudiantesPorFacultad(fac VARCHAR(100)) RETURNS INT
BEGIN DECLARE c INT;
SELECT COUNT(*) INTO c FROM Estudiante WHERE carrera = fac;
RETURN c;
END;

CREATE FUNCTION cursosPorProfesor(pid INT) RETURNS INT
BEGIN DECLARE c INT;
SELECT COUNT(*) INTO c FROM Curso_Profesor WHERE id_profesor = pid;
RETURN c;
END;

CREATE FUNCTION aprobadosCurso(cid INT) RETURNS INT
BEGIN DECLARE c INT;
SELECT COUNT(*) INTO c FROM Nota WHERE id_curso = cid AND nota >= 3.0;
RETURN c;
END;

-- PROCEDIMIENTO
CREATE PROCEDURE registrarNota(IN eid INT, IN cid INT, IN nota DECIMAL(3,1))
BEGIN INSERT INTO Nota (id_estudiante, id_curso, nota) VALUES (eid, cid, nota); END;

-- SUBCONSULTA
SELECT nombre FROM Curso WHERE id_curso IN (
  SELECT id_curso FROM Nota GROUP BY id_curso HAVING AVG(nota) > 4.0
);
