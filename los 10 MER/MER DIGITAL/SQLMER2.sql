CREATE DATABASE AGENCIA DE VIAJES;
USE AGENCIA DE VIAJES;


CREATE TABLE Destino (
    idDestino INT PRIMARY KEY,
    nombre VARCHAR(50),
    pais VARCHAR(50)
);

CREATE TABLE Guia (
    idGuia INT PRIMARY KEY,
    nombre VARCHAR(50),
    idioma VARCHAR(50)
);

CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(100)
);

CREATE TABLE Paquete (
    idPaquete INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2)
);

CREATE TABLE Hotel (
    idHotel INT PRIMARY KEY,
    nombre VARCHAR(50),
    estrellas INT
);

CREATE TABLE Transporte (
    idTransporte INT PRIMARY KEY,
    tipo VARCHAR(50),
    capacidad INT
);

CREATE TABLE Reserva (
    idReserva INT PRIMARY KEY,
    fecha DATE,
    idCliente INT,
    idPaquete INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idPaquete) REFERENCES Paquete(idPaquete)
);

CREATE TABLE Paquete_Destino (
    idPaquete INT,
    idDestino INT,
    PRIMARY KEY (idPaquete, idDestino),
    FOREIGN KEY (idPaquete) REFERENCES Paquete(idPaquete),
    FOREIGN KEY (idDestino) REFERENCES Destino(idDestino)
);

CREATE TABLE Paquete_Guia (
    idPaquete INT,
    idGuia INT,
    PRIMARY KEY (idPaquete, idGuia),
    FOREIGN KEY (idPaquete) REFERENCES Paquete(idPaquete),
    FOREIGN KEY (idGuia) REFERENCES Guia(idGuia)
);

INSERT INTO Destino VALUES (1, 'París', 'Francia');
INSERT INTO Guia VALUES (1, 'Sofía Morales', 'Francés');
INSERT INTO Cliente VALUES (1, 'Laura Medina', 'laura@gmail.com');
INSERT INTO Paquete VALUES (1, 'Europa Express', 3200.00);
INSERT INTO Hotel VALUES (1, 'Hotel Ritz', 5);
INSERT INTO Transporte VALUES (1, 'Avión', 200);
INSERT INTO Reserva VALUES (1, '2025-08-01', 1, 1);
INSERT INTO Paquete_Destino VALUES (1, 1);
INSERT INTO Paquete_Guia VALUES (1, 1);

SELECT nombre FROM Paquete;

DELETE FROM Cliente WHERE idCliente = 1;

CREATE FUNCTION TotalDestinosPorPaquete_Agencia (@idPaquete INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT;
    SELECT @total = COUNT(*) FROM Paquete_Destino WHERE idPaquete = @idPaquete;
    RETURN ISNULL(@total, 0);
END;

CREATE PROCEDURE RegistrarGuiaPaquete_Agencia
    @idPaquete INT,
    @idGuia INT
AS
BEGIN
    INSERT INTO Paquete_Guia VALUES (@idPaquete, @idGuia);
END;

SELECT nombre FROM Cliente WHERE idCliente IN (
    SELECT idCliente FROM Reserva
);
