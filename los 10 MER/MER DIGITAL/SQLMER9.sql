CREATE DATABASE CINE;
USE CINE;


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

CREATE TABLE Pelicula (
    idPelicula INT PRIMARY KEY,
    titulo VARCHAR(100),
    genero VARCHAR(50)
);

CREATE TABLE Sala (
    idSala INT PRIMARY KEY,
    nombre VARCHAR(50),
    capacidad INT,
    idSucursal INT,
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
);

CREATE TABLE Funcion (
    idFuncion INT PRIMARY KEY,
    fecha DATE,
    hora VARCHAR(10),
    idPelicula INT,
    idSala INT,
    FOREIGN KEY (idPelicula) REFERENCES Pelicula(idPelicula),
    FOREIGN KEY (idSala) REFERENCES Sala(idSala)
);

CREATE TABLE Snack (
    idSnack INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2)
);

CREATE TABLE Cliente_Funcion (
    idCliente INT,
    idFuncion INT,
    PRIMARY KEY (idCliente, idFuncion),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idFuncion) REFERENCES Funcion(idFuncion)
);

CREATE TABLE Funcion_Snack (
    idFuncion INT,
    idSnack INT,
    PRIMARY KEY (idFuncion, idSnack),
    FOREIGN KEY (idFuncion) REFERENCES Funcion(idFuncion),
    FOREIGN KEY (idSnack) REFERENCES Snack(idSnack)
);

INSERT INTO Sucursal VALUES (1, 'Centro', 'Calle 10 #5-15');
INSERT INTO Empleado VALUES (1, 'Laura Ríos', 'Taquillera', 1);
INSERT INTO Cliente VALUES (1, 'Pedro Martínez', 'pedro@gmail.com');
INSERT INTO Pelicula VALUES (1, 'Inception', 'Ciencia Ficción');
INSERT INTO Sala VALUES (1, 'Sala 1', 100, 1);
INSERT INTO Funcion VALUES (1, '2025-07-10', '20:00', 1, 1);
INSERT INTO Snack VALUES (1, 'Palomitas', 15.00);
INSERT INTO Cliente_Funcion VALUES (1, 1);
INSERT INTO Funcion_Snack VALUES (1, 1);

SELECT titulo FROM Pelicula;

DELETE FROM Cliente WHERE idCliente = 1;

CREATE FUNCTION TotalSnacksPorFuncion_Cine (@idFuncion INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT;
    SELECT @total = COUNT(*) FROM Funcion_Snack WHERE idFuncion = @idFuncion;
    RETURN ISNULL(@total, 0);
END;

CREATE PROCEDURE RegistrarClienteFuncion_Cine
    @idCliente INT,
    @idFuncion INT
AS
BEGIN
    INSERT INTO Cliente_Funcion VALU_
