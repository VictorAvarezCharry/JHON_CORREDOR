CREATE DATABASE HOTEL;
USE HOTEL; 


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
    correo VARCHAR(100)
);

CREATE TABLE Habitacion (
    idHabitacion INT PRIMARY KEY,
    numero VARCHAR(10),
    tipo VARCHAR(50),
    precio DECIMAL(10,2),
    idSucursal INT,
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
);

CREATE TABLE Reserva (
    idReserva INT PRIMARY KEY,
    fechaInicio DATE,
    fechaFin DATE,
    idCliente INT,
    idHabitacion INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idHabitacion) REFERENCES Habitacion(idHabitacion)
);

CREATE TABLE Servicio (
    idServicio INT PRIMARY KEY,
    nombre VARCHAR(50),
    costo DECIMAL(10,2)
);

CREATE TABLE Restaurante (
    idRestaurante INT PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(50),
    idSucursal INT,
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
);

CREATE TABLE Reserva_Servicio (
    idReserva INT,
    idServicio INT,
    PRIMARY KEY (idReserva, idServicio),
    FOREIGN KEY (idReserva) REFERENCES Reserva(idReserva),
    FOREIGN KEY (idServicio) REFERENCES Servicio(idServicio)
);

CREATE TABLE Cliente_Restaurante (
    idCliente INT,
    idRestaurante INT,
    PRIMARY KEY (idCliente, idRestaurante),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idRestaurante) REFERENCES Restaurante(idRestaurante)
);

INSERT INTO Sucursal VALUES (1, 'Paradise Centro', 'Av. Libertad 456');
INSERT INTO Empleado VALUES (1, 'Carlos Gómez', 'Recepcionista', 1);
INSERT INTO Cliente VALUES (1, 'María Torres', 'maria@gmail.com');
INSERT INTO Habitacion VALUES (1, '101', 'Suite', 250.00, 1);
INSERT INTO Reserva VALUES (1, '2025-07-15', '2025-07-20', 1, 1);
INSERT INTO Servicio VALUES (1, 'Spa', 80.00);
INSERT INTO Restaurante VALUES (1, 'Gourmet Paradise', 'Internacional', 1);
INSERT INTO Reserva_Servicio VALUES (1, 1);
INSERT INTO Cliente_Restaurante VALUES (1, 1);

SELECT nombre FROM Cliente;

DELETE FROM Cliente WHERE idCliente = 1;

CREATE FUNCTION TotalServiciosPorReserva_Hotel (@idReserva INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT;
    SELECT @total = COUNT(*) FROM Reserva_Servicio WHERE idReserva = @idReserva;
    RETURN ISNULL(@total, 0);
END;

CREATE PROCEDURE RegistrarReservaServicio_Hotel
    @idReserva INT,
    @idServicio INT
AS
BEGIN
    INSERT INTO Reserva_Servicio VALUES (@idReserva, @idServicio);
END;

SELECT nombre FR
