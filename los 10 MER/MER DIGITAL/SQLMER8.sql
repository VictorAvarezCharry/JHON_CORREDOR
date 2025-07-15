CREATE DATABASE VETERINARIA; 
USE VETERINARIA; 


CREATE TABLE Clinica (
    idClinica INT PRIMARY KEY,
    nombre VARCHAR(50),
    direccion VARCHAR(100)
);

CREATE TABLE Veterinario (
    idVeterinario INT PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(50),
    idClinica INT,
    FOREIGN KEY (idClinica) REFERENCES Clinica(idClinica)
);

CREATE TABLE Dueño (
    idDueno INT PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(20)
);

CREATE TABLE Mascota (
    idMascota INT PRIMARY KEY,
    nombre VARCHAR(50),
    especie VARCHAR(50),
    idDueno INT,
    FOREIGN KEY (idDueno) REFERENCES Dueño(idDueno)
);

CREATE TABLE Cita (
    idCita INT PRIMARY KEY,
    fecha DATE,
    motivo VARCHAR(100),
    idMascota INT,
    idVeterinario INT,
    FOREIGN KEY (idMascota) REFERENCES Mascota(idMascota),
    FOREIGN KEY (idVeterinario) REFERENCES Veterinario(idVeterinario)
);

CREATE TABLE Tratamiento (
    idTratamiento INT PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion VARCHAR(100)
);

CREATE TABLE Medicamento (
    idMedicamento INT PRIMARY KEY,
    nombre VARCHAR(50),
    dosis VARCHAR(50)
);

CREATE TABLE Tratamiento_Medicamento (
    idTratamiento INT,
    idMedicamento INT,
    PRIMARY KEY (idTratamiento, idMedicamento),
    FOREIGN KEY (idTratamiento) REFERENCES Tratamiento(idTratamiento),
    FOREIGN KEY (idMedicamento) REFERENCES Medicamento(idMedicamento)
);

CREATE TABLE Mascota_Tratamiento (
    idMascota INT,
    idTratamiento INT,
    PRIMARY KEY (idMascota, idTratamiento),
    FOREIGN KEY (idMascota) REFERENCES Mascota(idMascota),
    FOREIGN KEY (idTratamiento) REFERENCES Tratamiento(idTratamiento)
);

INSERT INTO Clinica VALUES (1, 'Animal Care Centro', 'Cra. 15 #45-22');
INSERT INTO Veterinario VALUES (1, 'Dr. Andrés Ruiz', 'Dermatología', 1);
INSERT INTO Dueño VALUES (1, 'Elena Vargas', '3125557788');
INSERT INTO Mascota VALUES (1, 'Max', 'Perro', 1);
INSERT INTO Cita VALUES (1, '2025-07-21', 'Chequeo anual', 1, 1);
INSERT INTO Tratamiento VALUES (1, 'Vacunación', 'Vacuna anual múltiple');
INSERT INTO Medicamento VALUES (1, 'Vacuna Rabia', '1 ml');
INSERT INTO Tratamiento_Medicamento VALUES (1, 1);
INSERT INTO Mascota_Tratamiento VALUES (1, 1);


SELECT nombre FROM Mascota;


DELETE FROM Dueño WHERE idDueno = 1;

CREATE FUNCTION TotalTratamientosPorMascota_Vet (@idMascota INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT;
    SELECT @total = COUNT(*) FROM Mascota_Tratamiento WHERE idMascota = @idMascota;
    RETURN ISNULL(@total, 0);
END;

CREATE PROCEDURE RegistrarMascotaTratamiento_Vet
    @idMascota INT,
    @idTratamiento INT
AS
BEGIN
    INSERT INTO Mascota_Tratamiento VALUES (@idMascota, @idTratamiento);
END;

SELECT nombre FROM Dueño WHERE idDueno IN (
    SELECT idDueno FROM Mascota
);

