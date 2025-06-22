CREATE DATABASE Hospital;
USE Hospital;
-- DDL: CREACI�N DE TABLAS
CREATE TABLE Paciente (
  id_paciente INT PRIMARY KEY,
  nombre VARCHAR(100),
  fecha_nacimiento DATE,
  sexo CHAR(1)
);

CREATE TABLE Medico (
  id_medico INT PRIMARY KEY,
  nombre VARCHAR(100),
  especialidad VARCHAR(50)
);

CREATE TABLE Departamento (
  id_departamento INT PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE Cita (
  id_cita INT PRIMARY KEY,
  id_paciente INT,
  id_medico INT,
  fecha DATE,
  motivo TEXT,
  FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
  FOREIGN KEY (id_medico) REFERENCES Medico(id_medico)
);

CREATE TABLE Hospitalizacion (
  id_hosp INT PRIMARY KEY,
  id_paciente INT,
  id_departamento INT,
  fecha_ingreso DATE,
  fecha_salida DATE,
  FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
  FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

CREATE TABLE Medicamento (
  id_medicamento INT PRIMARY KEY,
  nombre VARCHAR(100),
  descripcion TEXT
);

CREATE TABLE Receta (
  id_cita INT,
  id_medicamento INT,
  dosis VARCHAR(50),
  PRIMARY KEY (id_cita, id_medicamento),
  FOREIGN KEY (id_cita) REFERENCES Cita(id_cita),
  FOREIGN KEY (id_medicamento) REFERENCES Medicamento(id_medicamento)
);

-- INSERT (5 por tabla)
INSERT INTO Departamento VALUES (1, 'Cardiolog�a');
INSERT INTO Departamento VALUES (2, 'Neurolog�a');
INSERT INTO Departamento VALUES (3, 'Pediatr�a');
INSERT INTO Departamento VALUES (4, 'Urgencias');
INSERT INTO Departamento VALUES (5, 'Cirug�a');

INSERT INTO Paciente VALUES (1, 'Juan P�rez', '1990-05-20', 'M');
INSERT INTO Paciente VALUES (2, 'Ana Torres', '1985-11-13', 'F');
INSERT INTO Paciente VALUES (3, 'Luis Ram�rez', '2000-08-09', 'M');
INSERT INTO Paciente VALUES (4, 'Sof�a G�mez', '1995-02-27', 'F');
INSERT INTO Paciente VALUES (5, 'Carlos D�az', '1988-01-30', 'M');

INSERT INTO Medico VALUES (1, 'Dr. Herrera', 'Cardiolog�a');
INSERT INTO Medico VALUES (2, 'Dra. Su�rez', 'Neurolog�a');
INSERT INTO Medico VALUES (3, 'Dr. Acosta', 'Pediatr�a');
INSERT INTO Medico VALUES (4, 'Dr. R�os', 'Urgencias');
INSERT INTO Medico VALUES (5, 'Dra. Casta�o', 'Cirug�a');

INSERT INTO Cita VALUES (1, 1, 1, '2024-06-10', 'Chequeo general');
INSERT INTO Cita VALUES (2, 2, 2, '2024-06-11', 'Dolor de cabeza');
INSERT INTO Cita VALUES (3, 3, 3, '2024-06-12', 'Revisi�n pedi�trica');
INSERT INTO Cita VALUES (4, 4, 4, '2024-06-13', 'Golpe leve');
INSERT INTO Cita VALUES (5, 5, 5, '2024-06-14', 'Consulta quir�rgica');

INSERT INTO Hospitalizacion VALUES (1, 1, 1, '2024-06-10', NULL);
INSERT INTO Hospitalizacion VALUES (2, 2, 2, '2024-06-11', '2024-06-13');
INSERT INTO Hospitalizacion VALUES (3, 3, 3, '2024-06-12', NULL);
INSERT INTO Hospitalizacion VALUES (4, 4, 4, '2024-06-13', NULL);
INSERT INTO Hospitalizacion VALUES (5, 5, 5, '2024-06-14', '2024-06-18');

INSERT INTO Medicamento VALUES (1, ' ', 'Analg�sico y antipir�tico');
INSERT INTO Medicamento VALUES (2, 'Ibuprofeno', 'Antiinflamatorio no esteroideo');
INSERT INTO Medicamento VALUES (3, 'Amoxicilina', 'Antibi�tico de amplio espectro');
INSERT INTO Medicamento VALUES (4, 'Omeprazol', 'Inhibidor de bomba de protones');
INSERT INTO Medicamento VALUES (5, 'Salbutamol', 'Broncodilatador');

INSERT INTO Receta VALUES (1, 1, '500mg cada 8 horas');
INSERT INTO Receta VALUES (2, 2, '400mg cada 12 horas');
INSERT INTO Receta VALUES (3, 3, '500mg cada 8 horas');
INSERT INTO Receta VALUES (4, 4, '20mg diario');
INSERT INTO Receta VALUES (5, 5, '2 inhalaciones cada 6 horas');

-- SELECT (5 ejemplos)
SELECT p.nombre, c.fecha, c.motivo FROM Cita c JOIN Paciente p ON c.id_paciente = p.id_paciente;
SELECT h.id_hosp, p.nombre, d.nombre FROM Hospitalizacion h JOIN Paciente p ON h.id_paciente = p.id_paciente JOIN Departamento d ON h.id_departamento = d.id_departamento;
SELECT m.nombre, r.dosis FROM Receta r JOIN Medicamento m ON r.id_medicamento = m.id_medicamento;
SELECT c.fecha, med.nombre FROM Cita c JOIN Medico med ON c.id_medico = med.id_medico;
SELECT COUNT(*) AS total_pacientes FROM Paciente;

-- DELETE (5 ejemplos)
DELETE FROM Receta WHERE id_cita = 1 AND id_medicamento = 1;
DELETE FROM Hospitalizacion WHERE id_hosp = 2;
DELETE FROM Cita WHERE id_cita = 5;
DELETE FROM Paciente WHERE id_paciente = 5;
DELETE FROM Medico WHERE id_medico = 5;

-- FUNCIONES (10 ejemplos)
CREATE FUNCTION totalPacientes() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Paciente;
  RETURN total;
END;

CREATE FUNCTION citasPorMedico(mid INT) RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Cita WHERE id_medico = mid;
  RETURN total;
END;

CREATE FUNCTION hospitalizacionesActivas() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Hospitalizacion WHERE fecha_salida IS NULL;
  RETURN total;
END;

CREATE FUNCTION medicamentosPorCita(cid INT) RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Receta WHERE id_cita = cid;
  RETURN total;
END;

CREATE FUNCTION edadPaciente(pid INT) RETURNS INT
BEGIN
  DECLARE edad INT;
  SELECT TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) INTO edad FROM Paciente WHERE id_paciente = pid;
  RETURN edad;
END;

CREATE FUNCTION totalMedicos() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Medico;
  RETURN total;
END;

CREATE FUNCTION citasPorPaciente(pid INT) RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Cita WHERE id_paciente = pid;
  RETURN total;
END;

CREATE FUNCTION estaHospitalizado(pid INT) RETURNS BOOLEAN
BEGIN
  DECLARE existe INT;
  SELECT COUNT(*) INTO existe FROM Hospitalizacion WHERE id_paciente = pid AND fecha_salida IS NULL;
  RETURN existe > 0;
END;

CREATE FUNCTION medicamentosTotales() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Medicamento;
  RETURN total;
END;

CREATE FUNCTION citasHoy() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Cita WHERE fecha = CURDATE();
  RETURN total;
END;

-- PROCEDIMIENTO (1 ejemplo)
CREATE PROCEDURE registrarCita(
  IN pid_paciente INT,
  IN pid_medico INT,
  IN pfecha DATE,
  IN pmotivo TEXT
)
BEGIN
  INSERT INTO Cita (id_cita, id_paciente, id_medico, fecha, motivo)
  VALUES (NULL, pid_paciente, pid_medico, pfecha, pmotivo);
END;

-- SUBCONSULTA (1 ejemplo)
SELECT nombre FROM Paciente
WHERE id_paciente IN (
  SELECT id_paciente FROM Cita
  GROUP BY id_paciente
  HAVING COUNT(id_cita) > 1
);
