CREATE DATABASE BIBLIOTECA;
USE BIBLIOTECA;


CREATE TABLE Sala (
    idSala INT PRIMARY KEY,
    nombre VARCHAR(50),
    ubicacion VARCHAR(100)
);

CREATE TABLE Empleado (
    idEmpleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(50),
    idSala INT,
    FOREIGN KEY (idSala) REFERENCES Sala(idSala)
);

CREATE TABLE Socio (
    idSocio INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(100)
);

CREATE TABLE Libro (
    idLibro INT PRIMARY KEY,
    titulo VARCHAR(100),
    idEditorial INT
);

CREATE TABLE Editorial (
    idEditorial INT PRIMARY KEY,
    nombre VARCHAR(50),
    pais VARCHAR(50)
);

CREATE TABLE Autor (
    idAutor INT PRIMARY KEY,
    nombre VARCHAR(50),
    nacionalidad VARCHAR(50)
);

CREATE TABLE Prestamo (
    idPrestamo INT PRIMARY KEY,
    fecha DATE,
    idSocio INT,
    idLibro INT,
    FOREIGN KEY (idSocio) REFERENCES Socio(idSocio),
    FOREIGN KEY (idLibro) REFERENCES Libro(idLibro)
);

CREATE TABLE Libro_Autor (
    idLibro INT,
    idAutor INT,
    PRIMARY KEY (idLibro, idAutor),
    FOREIGN KEY (idLibro) REFERENCES Libro(idLibro),
    FOREIGN KEY (idAutor) REFERENCES Autor(idAutor)
);

CREATE TABLE Socio_Sala (
    idSocio INT,
    idSala INT,
    PRIMARY KEY (idSocio, idSala),
    FOREIGN KEY (idSocio) REFERENCES Socio(idSocio),
    FOREIGN KEY (idSala) REFERENCES Sala(idSala)
);

INSERT INTO Sala VALUES (1, 'Lectura General', 'Segundo Piso');
INSERT INTO Empleado VALUES (1, 'Marta López', 'Bibliotecaria', 1);
INSERT INTO Socio VALUES (1, 'Juan Pérez', 'juan@gmail.com');
INSERT INTO Editorial VALUES (1, 'Planeta', 'España');
INSERT INTO Libro VALUES (1, 'Cien Años de Soledad', 1);
INSERT INTO Autor VALUES (1, 'Gabriel García Márquez', 'Colombiana');
INSERT INTO Prestamo VALUES (1, '2025-07-22', 1, 1);
INSERT INTO Libro_Autor VALUES (1, 1);
INSERT INTO Socio_Sala VALUES (1, 1);

SELECT titulo FROM Libro;

DELETE FROM Socio WHERE idSocio = 1;

CREATE FUNCTION TotalPrestamosPorSocio_Biblioteca (@idSocio INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT;
    SELECT @total = COUNT(*) FROM Prestamo WHERE idSocio = @idSocio;
    RETURN ISNULL(@total, 0);
END;

CREATE PROCEDURE RegistrarLibroAutor_Biblioteca
    @idLibro INT,
    @idAutor INT
AS
BEGIN
    INSERT INTO Libro_Autor VALUES (@idLibro, @idAutor);
END;

SELECT nombre FROM Socio WHERE idSocio IN (
    SELECT idSocio FROM Prestamo
);

