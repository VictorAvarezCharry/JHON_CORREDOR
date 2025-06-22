CREATE DATABASE Bibloteca;
USE Bibloteca;
-- DDL: CREACIÓN DE TABLAS
CREATE TABLE Usuario (
  id_usuario INT PRIMARY KEY,
  nombre VARCHAR(100),
  correo VARCHAR(100) UNIQUE,
  contrasena VARCHAR(100)
);

CREATE TABLE Autor (
  id_autor INT PRIMARY KEY,
  nombre VARCHAR(100),
  nacionalidad VARCHAR(50)
);

CREATE TABLE Categoria (
  id_categoria INT PRIMARY KEY,
  nombre VARCHAR(50)
);

CREATE TABLE Libro (
  id_libro INT PRIMARY KEY,
  titulo VARCHAR(100),
  anio_publicacion INT,
  id_categoria INT,
  FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Libro_Autor (
  id_libro INT,
  id_autor INT,
  PRIMARY KEY (id_libro, id_autor),
  FOREIGN KEY (id_libro) REFERENCES Libro(id_libro),
  FOREIGN KEY (id_autor) REFERENCES Autor(id_autor)
);

CREATE TABLE Prestamo (
  id_prestamo INT PRIMARY KEY,
  id_usuario INT,
  id_libro INT,
  fecha_prestamo DATE,
  fecha_devolucion DATE,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_libro) REFERENCES Libro(id_libro)
);

CREATE TABLE Reseña (
  id_resena INT PRIMARY KEY,
  id_usuario INT,
  id_libro INT,
  comentario TEXT,
  calificacion INT,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_libro) REFERENCES Libro(id_libro)
);

CREATE TABLE Favorito (
  id_usuario INT,
  id_libro INT,
  fecha_agregado DATE,
  PRIMARY KEY (id_usuario, id_libro),
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_libro) REFERENCES Libro(id_libro)
);

-- INSERT (5 por tabla ejemplo con Categoria)
INSERT INTO Categoria VALUES (1, 'Ficción');
INSERT INTO Categoria VALUES (2, 'Historia');
INSERT INTO Categoria VALUES (3, 'Tecnología');
INSERT INTO Categoria VALUES (4, 'Ciencia');
INSERT INTO Categoria VALUES (5, 'Arte');

INSERT INTO Usuario VALUES (1, 'Carlos Ruiz', 'carlos@mail.com', 'clave123');
INSERT INTO Usuario VALUES (2, 'Ana Gómez', 'ana@mail.com', 'clave456');
INSERT INTO Usuario VALUES (3, 'Luis Pérez', 'luis@mail.com', 'clave789');
INSERT INTO Usuario VALUES (4, 'María Díaz', 'maria@mail.com', 'clave321');
INSERT INTO Usuario VALUES (5, 'Sofía Torres', 'sofia@mail.com', 'clave654');

INSERT INTO Autor VALUES (1, 'Gabriel García Márquez', 'Colombia');
INSERT INTO Autor VALUES (2, 'Stephen Hawking', 'Reino Unido');
INSERT INTO Autor VALUES (3, 'Isaac Asimov', 'Rusia');
INSERT INTO Autor VALUES (4, 'Umberto Eco', 'Italia');
INSERT INTO Autor VALUES (5, 'Carl Sagan', 'EEUU');

INSERT INTO Libro VALUES (1, 'Cien Años de Soledad', 1967, 1);
INSERT INTO Libro VALUES (2, 'Breve Historia del Tiempo', 1988, 4);
INSERT INTO Libro VALUES (3, 'Fundación', 1951, 1);
INSERT INTO Libro VALUES (4, 'El Nombre de la Rosa', 1980, 1);
INSERT INTO Libro VALUES (5, 'Cosmos', 1980, 4);

INSERT INTO Libro_Autor VALUES (1, 1);
INSERT INTO Libro_Autor VALUES (2, 2);
INSERT INTO Libro_Autor VALUES (3, 3);
INSERT INTO Libro_Autor VALUES (4, 4);
INSERT INTO Libro_Autor VALUES (5, 5);

INSERT INTO Prestamo VALUES (1, 1, 1, '2024-06-01', NULL);
INSERT INTO Prestamo VALUES (2, 2, 2, '2024-06-02', '2024-06-12');
INSERT INTO Prestamo VALUES (3, 3, 3, '2024-06-03', NULL);
INSERT INTO Prestamo VALUES (4, 4, 4, '2024-06-04', '2024-06-14');
INSERT INTO Prestamo VALUES (5, 5, 5, '2024-06-05', NULL);

INSERT INTO Reseña VALUES (1, 1, 1, 'Excelente libro', 5);
INSERT INTO Reseña VALUES (2, 2, 2, 'Muy interesante', 4);
INSERT INTO Reseña VALUES (3, 3, 3, 'Fascinante', 5);
INSERT INTO Reseña VALUES (4, 4, 4, 'Un poco denso', 3);
INSERT INTO Reseña VALUES (5, 5, 5, 'Inspirador', 5);

INSERT INTO Favorito VALUES (1, 1, '2024-06-10');
INSERT INTO Favorito VALUES (2, 2, '2024-06-11');
INSERT INTO Favorito VALUES (3, 3, '2024-06-12');
INSERT INTO Favorito VALUES (4, 4, '2024-06-13');
INSERT INTO Favorito VALUES (5, 5, '2024-06-14');

-- SELECT (5 ejemplos)
SELECT l.titulo, c.nombre FROM Libro l JOIN Categoria c ON l.id_categoria = c.id_categoria;
SELECT u.nombre, l.titulo FROM Prestamo p JOIN Usuario u ON p.id_usuario = u.id_usuario JOIN Libro l ON p.id_libro = l.id_libro;
SELECT u.nombre, l.titulo FROM Favorito f JOIN Usuario u ON f.id_usuario = u.id_usuario JOIN Libro l ON f.id_libro = l.id_libro;
SELECT l.titulo, a.nombre FROM Libro_Autor la JOIN Libro l ON la.id_libro = l.id_libro JOIN Autor a ON la.id_autor = a.id_autor;
SELECT l.titulo, r.comentario FROM Reseña r JOIN Libro l ON r.id_libro = l.id_libro WHERE r.calificacion > 4;

-- DELETE (5 ejemplos)
DELETE FROM Favorito WHERE id_usuario = 1 AND id_libro = 3;
DELETE FROM Reseña WHERE id_resena = 2;
DELETE FROM Prestamo WHERE id_prestamo = 4;
DELETE FROM Libro_Autor WHERE id_libro = 2 AND id_autor = 3;
DELETE FROM Libro WHERE id_libro = 5;

-- FUNCIONES (10 ejemplos)
CREATE FUNCTION totalLibrosPorCategoria(cat_id INT) RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Libro WHERE id_categoria = cat_id;
  RETURN total;
END;

CREATE FUNCTION calificacionPromedio(libro_id INT) RETURNS FLOAT
BEGIN
  DECLARE promedio FLOAT;
  SELECT AVG(calificacion) INTO promedio FROM Reseña WHERE id_libro = libro_id;
  RETURN promedio;
END;

CREATE FUNCTION cantidadPrestamosUsuario(uid INT) RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Prestamo WHERE id_usuario = uid;
  RETURN total;
END;

CREATE FUNCTION cantidadFavoritosUsuario(uid INT) RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Favorito WHERE id_usuario = uid;
  RETURN total;
END;

CREATE FUNCTION existeLibroFavorito(uid INT, lid INT) RETURNS BOOLEAN
BEGIN
  DECLARE existe INT;
  SELECT COUNT(*) INTO existe FROM Favorito WHERE id_usuario = uid AND id_libro = lid;
  RETURN existe > 0;
END;

CREATE FUNCTION librosPorAutor(aid INT) RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Libro_Autor WHERE id_autor = aid;
  RETURN total;
END;

CREATE FUNCTION prestamosPorLibro(lid INT) RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Prestamo WHERE id_libro = lid;
  RETURN total;
END;

CREATE FUNCTION totalAutores() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Autor;
  RETURN total;
END;

CREATE FUNCTION totalUsuarios() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Usuario;
  RETURN total;
END;

CREATE FUNCTION librosConReseñas() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(DISTINCT id_libro) INTO total FROM Reseña;
  RETURN total;
END;

-- PROCEDIMIENTO (1 ejemplo)
CREATE PROCEDURE registrarPrestamo(
  IN pid_usuario INT,
  IN pid_libro INT,
  IN pfecha DATE
)
BEGIN
  INSERT INTO Prestamo (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion)
  VALUES (NULL, pid_usuario, pid_libro, pfecha, NULL);
END;

-- SUBCONSULTA
SELECT titulo FROM Libro
WHERE id_libro IN (
  SELECT id_libro FROM Libro_Autor
  GROUP BY id_libro
  HAVING COUNT(id_autor) > 2
);
