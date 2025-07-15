
 CREATE DATABASE GIMNASIO ;
 USE GIMNASIO ;

CREATE TABLE Sucursal (
    idSucursal INT PRIMARY KEY,
    nombre VARCHAR(50),
    direccion VARCHAR(100)
);

CREATE TABLE Empleado (
    idEmpleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(50),
    idSucursal INT,
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
);

CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(100),
    telefono VARCHAR(15)
);

CREATE TABLE Membresia (
    idMembresia INT PRIMARY KEY,
    tipo VARCHAR(20),
    precio DECIMAL(8,2)
);

CREATE TABLE Clase (
    idClase INT PRIMARY KEY,
    nombre VARCHAR(50),
    horario VARCHAR(20),
    idSucursal INT,
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
);

CREATE TABLE Entrenador (
    idEntrenador INT PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(50),
    idSucursal INT,
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
);

CREATE TABLE Equipo (
    idEquipo INT PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion VARCHAR(100),
    idSucursal INT,
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
);

CREATE TABLE Cliente_Clase (
    idCliente INT,
    idClase INT,
    fechaInscripcion DATE,
    PRIMARY KEY (idCliente, idClase),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idClase) REFERENCES Clase(idClase)
);

CREATE TABLE Entrenador_Clase (
    idEntrenador INT,
    idClase INT,
    PRIMARY KEY (idEntrenador, idClase),
    FOREIGN KEY (idEntrenador) REFERENCES Entrenador(idEntrenador),
    FOREIGN KEY (idClase) REFERENCES Clase(idClase)
);

INSERT INTO Sucursal VALUES (1, 'Centro', 'Cra 10 #20-30');
INSERT INTO Empleado VALUES (1, 'Ana Pérez', 'Recepcionista', 1);
INSERT INTO Cliente VALUES (1, 'Laura Torres', 'laura@gmail.com', '3124567890');
INSERT INTO Membresia VALUES (1, 'Básica', 100000);
INSERT INTO Clase VALUES (1, 'Yoga', '08:00', 1);
INSERT INTO Entrenador VALUES (1, 'Mario Ruiz', 'Yoga', 1);
INSERT INTO Equipo VALUES (1, 'Bicicleta', 'Bicicleta estática', 1);
INSERT INTO Cliente_Clase VALUES (1, 1, '2025-07-01');
INSERT INTO Entrenador_Clase VALUES (1, 1);

SELECT nombre, telefono FROM Cliente;

DELETE FROM Cliente WHERE idCliente = 1;

CREATE FUNCTION PrecioConDescuento_Gimnasio (@idMembresia INT, @porcentaje DECIMAL(5,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @precio DECIMAL(10,2);
    SELECT @precio = precio FROM Membresia WHERE idMembresia = @idMembresia;
    RETURN @precio - (@precio * @porcentaje / 100);
END;

CREATE PROCEDURE InscribirClienteClase_Gimnasio
    @idCliente INT,
    @idClase INT,
    @fecha DATE
AS
BEGIN
    INSERT INTO Cliente_Clase VALUES (@idCliente, @idClase, @fecha);
END;

SELECT nombre FROM Cliente WHERE idCliente IN (
    SELECT idCliente FROM Cliente_Clase
);



