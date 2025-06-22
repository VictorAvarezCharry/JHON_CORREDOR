CREATE DATABASE Supermercado;
USE Supermercado;

CREATE TABLE Cliente (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(100),
  telefono VARCHAR(20)
);

CREATE TABLE Producto (
  id_producto INT PRIMARY KEY,
  nombre VARCHAR(100),
  precio DECIMAL(10,2),
  stock INT
);

CREATE TABLE Categoria (
  id_categoria INT PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE Empleado (
  id_empleado INT PRIMARY KEY,
  nombre VARCHAR(100),
  cargo VARCHAR(50)
);

CREATE TABLE Factura (
  id_factura INT PRIMARY KEY,
  id_cliente INT,
  fecha DATE,
  total DECIMAL(10,2),
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE DetalleFactura (
  id_factura INT,
  id_producto INT,
  cantidad INT,
  precio_unitario DECIMAL(10,2),
  PRIMARY KEY (id_factura, id_producto),
  FOREIGN KEY (id_factura) REFERENCES Factura(id_factura),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Producto_Categoria (
  id_producto INT,
  id_categoria INT,
  PRIMARY KEY (id_producto, id_categoria),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
  FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

-- INSERT (5 por tabla)
INSERT INTO Categoria VALUES (1, 'Lácteos'), (2, 'Carnes'), (3, 'Bebidas'), (4, 'Aseo'), (5, 'Verduras');

INSERT INTO Cliente VALUES (1, 'Carlos Ruiz', '3001234567'), (2, 'Ana Méndez', '3112345678'), (3, 'Luis Vargas', '3209876543'), (4, 'Sofía Rojas', '3007654321'), (5, 'Andrés López', '3012345678');

INSERT INTO Empleado VALUES (1, 'Pedro Díaz', 'Cajero'), (2, 'Laura Suárez', 'Vendedor'), (3, 'Mario Acosta', 'Bodeguero'), (4, 'Ana Torres', 'Supervisor'), (5, 'José Ramírez', 'Gerente');

INSERT INTO Producto VALUES (1, 'Leche', 5000, 100), (2, 'Carne de res', 15000, 50), (3, 'Coca-Cola', 3000, 200), (4, 'Jabón', 2500, 150), (5, 'Tomate', 2000, 120);

INSERT INTO Producto_Categoria VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

INSERT INTO Factura VALUES (1, 1, '2024-06-01', 20000), (2, 2, '2024-06-02', 30000), (3, 3, '2024-06-03', 15000), (4, 4, '2024-06-04', 10000), (5, 5, '2024-06-05', 12000);

INSERT INTO DetalleFactura VALUES (1, 1, 2, 5000), (2, 2, 1, 15000), (3, 3, 3, 3000), (4, 4, 2, 2500), (5, 5, 6, 2000);

-- SELECT (5 ejemplos)
SELECT f.id_factura, c.nombre, f.total FROM Factura f JOIN Cliente c ON f.id_cliente = c.id_cliente;
SELECT d.id_factura, p.nombre, d.cantidad FROM DetalleFactura d JOIN Producto p ON d.id_producto = p.id_producto;
SELECT p.nombre, c.nombre FROM Producto_Categoria pc JOIN Producto p ON pc.id_producto = p.id_producto JOIN Categoria c ON pc.id_categoria = c.id_categoria;
SELECT COUNT(*) AS total_clientes FROM Cliente;
SELECT nombre FROM Producto WHERE stock < 100;

-- DELETE (5 ejemplos)
DELETE FROM DetalleFactura WHERE id_factura = 1 AND id_producto = 1;
DELETE FROM Factura WHERE id_factura = 5;
DELETE FROM Producto WHERE id_producto = 5;
DELETE FROM Cliente WHERE id_cliente = 5;
DELETE FROM Empleado WHERE id_empleado = 5;

-- FUNCIONES (10)
CREATE FUNCTION totalFacturas() RETURNS INT
BEGIN DECLARE t INT;
SELECT COUNT(*) INTO t FROM Factura;
RETURN t;
END;

CREATE FUNCTION totalClientes() RETURNS INT
BEGIN DECLARE t INT;
SELECT COUNT(*) INTO t FROM Cliente;
RETURN t;
END;

CREATE FUNCTION stockProducto(pid INT) RETURNS INT
BEGIN DECLARE s INT;
SELECT stock INTO s FROM Producto WHERE id_producto = pid;
RETURN s;
END;

CREATE FUNCTION totalProductos() RETURNS INT
BEGIN DECLARE t INT;
SELECT COUNT(*) INTO t FROM Producto;
RETURN t;
END;

CREATE FUNCTION productosCategoria(cid INT) RETURNS INT
BEGIN DECLARE t INT;
SELECT COUNT(*) INTO t FROM Producto_Categoria WHERE id_categoria = cid;
RETURN t;
END;

CREATE FUNCTION totalEmpleados() RETURNS INT
BEGIN DECLARE t INT;
SELECT COUNT(*) INTO t FROM Empleado;
RETURN t;
END;

CREATE FUNCTION productosAgotados() RETURNS INT
BEGIN DECLARE t INT;
SELECT COUNT(*) INTO t FROM Producto WHERE stock = 0;
RETURN t;
END;

CREATE FUNCTION totalVentas() RETURNS DECIMAL(10,2)
BEGIN DECLARE s DECIMAL(10,2);
SELECT SUM(total) INTO s FROM Factura;
RETURN s;
END;

CREATE FUNCTION facturaCliente(cid INT) RETURNS INT
BEGIN DECLARE t INT;
SELECT COUNT(*) INTO t FROM Factura WHERE id_cliente = cid;
RETURN t;
END;

CREATE FUNCTION cantidadVendida(pid INT) RETURNS INT
BEGIN DECLARE t INT;
SELECT SUM(cantidad) INTO t FROM DetalleFactura WHERE id_producto = pid;
RETURN t;
END;

-- PROCEDIMIENTO
CREATE PROCEDURE registrarFactura(IN cid INT, IN fecha DATE, IN total DECIMAL(10,2))
BEGIN
INSERT INTO Factura (id_factura, id_cliente, fecha, total) VALUES (NULL, cid, fecha, total);
END;

-- SUBCONSULTA
SELECT nombre FROM Producto WHERE id_producto IN (
SELECT id_producto FROM DetalleFactura GROUP BY id_producto HAVING SUM(cantidad) > 5
);
