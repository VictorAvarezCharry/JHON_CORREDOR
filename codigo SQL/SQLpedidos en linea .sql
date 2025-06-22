CREATE DATABASE pedidos;
USE pedidos ;

CREATE TABLE Cliente (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(100),
  correo VARCHAR(100),
  direccion VARCHAR(255)
);

CREATE TABLE Producto (
  id_producto INT PRIMARY KEY,
  nombre VARCHAR(100),
  precio DECIMAL(10,2),
  stock INT
);

CREATE TABLE Categoria (
  id_categoria INT PRIMARY KEY,
  nombre VARCHAR(50)
);

CREATE TABLE Pedido (
  id_pedido INT PRIMARY KEY,
  id_cliente INT,
  fecha DATE,
  total DECIMAL(10,2),
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE DetallePedido (
  id_pedido INT,
  id_producto INT,
  cantidad INT,
  precio_unitario DECIMAL(10,2),
  PRIMARY KEY (id_pedido, id_producto),
  FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Producto_Categoria (
  id_producto INT,
  id_categoria INT,
  PRIMARY KEY (id_producto, id_categoria),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
  FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Reseña (
  id_reseña INT PRIMARY KEY,
  id_cliente INT,
  id_producto INT,
  calificacion INT,
  comentario TEXT,
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- INSERT (5 por tabla)
INSERT INTO Categoria VALUES (1, 'Electrónica');
INSERT INTO Categoria VALUES (2, 'Ropa');
INSERT INTO Categoria VALUES (3, 'Hogar');
INSERT INTO Categoria VALUES (4, 'Deportes');
INSERT INTO Categoria VALUES (5, 'Libros');

INSERT INTO Cliente VALUES (1, 'Laura Ríos', 'laura@mail.com', 'Cra 1 #10-20');
INSERT INTO Cliente VALUES (2, 'Mario Díaz', 'mario@mail.com', 'Calle 5 #22-30');
INSERT INTO Cliente VALUES (3, 'Elena Pérez', 'elena@mail.com', 'Av 7 #40-12');
INSERT INTO Cliente VALUES (4, 'Andrés Gómez', 'andres@mail.com', 'Calle 8 #12-34');
INSERT INTO Cliente VALUES (5, 'Lucía Torres', 'lucia@mail.com', 'Cra 3 #11-56');

INSERT INTO Producto VALUES (1, 'Audífonos', 150000, 50);
INSERT INTO Producto VALUES (2, 'Camiseta', 40000, 100);
INSERT INTO Producto VALUES (3, 'Silla', 250000, 30);
INSERT INTO Producto VALUES (4, 'Balón', 60000, 80);
INSERT INTO Producto VALUES (5, 'Novela', 35000, 200);

INSERT INTO Pedido VALUES (1, 1, '2024-06-01', 190000);
INSERT INTO Pedido VALUES (2, 2, '2024-06-02', 80000);
INSERT INTO Pedido VALUES (3, 3, '2024-06-03', 285000);
INSERT INTO Pedido VALUES (4, 4, '2024-06-04', 60000);
INSERT INTO Pedido VALUES (5, 5, '2024-06-05', 70000);

INSERT INTO DetallePedido VALUES (1, 1, 1, 150000);
INSERT INTO DetallePedido VALUES (1, 2, 1, 40000);
INSERT INTO DetallePedido VALUES (2, 2, 2, 40000);
INSERT INTO DetallePedido VALUES (3, 3, 1, 250000);
INSERT INTO DetallePedido VALUES (3, 5, 1, 35000);

INSERT INTO Producto_Categoria VALUES (1, 1);
INSERT INTO Producto_Categoria VALUES (2, 2);
INSERT INTO Producto_Categoria VALUES (3, 3);
INSERT INTO Producto_Categoria VALUES (4, 4);
INSERT INTO Producto_Categoria VALUES (5, 5);

INSERT INTO Reseña VALUES (1, 1, 1, 5, 'Excelente calidad');
INSERT INTO Reseña VALUES (2, 2, 2, 4, 'Muy cómodo');
INSERT INTO Reseña VALUES (3, 3, 3, 5, 'Muy útil');
INSERT INTO Reseña VALUES (4, 4, 4, 3, 'Regular');
INSERT INTO Reseña VALUES (5, 5, 5, 5, 'Muy interesante');

-- SELECT (5 ejemplos)
SELECT c.nombre, p.fecha, p.total FROM Pedido p JOIN Cliente c ON p.id_cliente = c.id_cliente;
SELECT pr.nombre, dp.cantidad FROM DetallePedido dp JOIN Producto pr ON dp.id_producto = pr.id_producto;
SELECT pr.nombre, r.calificacion, r.comentario FROM Reseña r JOIN Producto pr ON r.id_producto = pr.id_producto;
SELECT pr.nombre, cat.nombre FROM Producto_Categoria pc JOIN Producto pr ON pc.id_producto = pr.id_producto JOIN Categoria cat ON pc.id_categoria = cat.id_categoria;
SELECT COUNT(*) AS total_pedidos FROM Pedido;

-- DELETE (5 ejemplos)
DELETE FROM Reseña WHERE id_reseña = 1;
DELETE FROM DetallePedido WHERE id_pedido = 1 AND id_producto = 1;
DELETE FROM Pedido WHERE id_pedido = 5;
DELETE FROM Cliente WHERE id_cliente = 5;
DELETE FROM Producto WHERE id_producto = 5;

-- FUNCIONES (10 ejemplos)
CREATE FUNCTION totalClientes() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Cliente;
  RETURN total;
END;

CREATE FUNCTION totalProductos() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Producto;
  RETURN total;
END;

CREATE FUNCTION productosPorCategoria(cat_id INT) RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Producto_Categoria WHERE id_categoria = cat_id;
  RETURN total;
END;

CREATE FUNCTION productosEnStock() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Producto WHERE stock > 0;
  RETURN total;
END;

CREATE FUNCTION pedidosPorCliente(cid INT) RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Pedido WHERE id_cliente = cid;
  RETURN total;
END;

CREATE FUNCTION calificacionPromedio(pid INT) RETURNS FLOAT
BEGIN
  DECLARE promedio FLOAT;
  SELECT AVG(calificacion) INTO promedio FROM Reseña WHERE id_producto = pid;
  RETURN promedio;
END;

CREATE FUNCTION totalPedidos() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Pedido;
  RETURN total;
END;

CREATE FUNCTION totalGanancias() RETURNS DECIMAL(10,2)
BEGIN
  DECLARE suma DECIMAL(10,2);
  SELECT SUM(total) INTO suma FROM Pedido;
  RETURN suma;
END;

CREATE FUNCTION productosSinStock() RETURNS INT
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Producto WHERE stock = 0;
  RETURN total;
END;

CREATE FUNCTION cantidadProductoEnPedido(pid INT, prod INT) RETURNS INT
BEGIN
  DECLARE cant INT;
  SELECT cantidad INTO cant FROM DetallePedido WHERE id_pedido = pid AND id_producto = prod;
  RETURN cant;
END;

-- PROCEDIMIENTO (1 ejemplo)
CREATE PROCEDURE registrarPedido(
  IN cid INT,
  IN fecha DATE,
  IN total DECIMAL(10,2)
)
BEGIN
  INSERT INTO Pedido (id_pedido, id_cliente, fecha, total)
  VALUES (NULL, cid, fecha, total);
END;

-- SUBCONSULTA (1 ejemplo)
SELECT nombre FROM Producto
WHERE id_producto IN (
  SELECT id_producto FROM DetallePedido
  GROUP BY id_producto
  HAVING SUM(cantidad) > 1
);
