CREATE DATABASE TIENDA;
USE TIENDA;


CREATE TABLE Proveedor (
    idProveedor INT PRIMARY KEY,
    nombre VARCHAR(50),
    contacto VARCHAR(50)
);

CREATE TABLE Categoria (
    idCategoria INT PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion VARCHAR(100)
);

CREATE TABLE Producto (
    idProducto INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2),
    idCategoria INT,
    idProveedor INT,
    FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria),
    FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
);

CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(100)
);

CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    fecha DATE,
    idCliente INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Pago (
    idPago INT PRIMARY KEY,
    metodo VARCHAR(50),
    monto DECIMAL(10,2),
    idPedido INT,
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

CREATE TABLE Inventario (
    idInventario INT PRIMARY KEY,
    stock INT,
    idProducto INT,
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
);

CREATE TABLE Pedido_Producto (
    idPedido INT,
    idProducto INT,
    cantidad INT,
    PRIMARY KEY (idPedido, idProducto),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
);

CREATE TABLE Producto_Categoria (
    idProducto INT,
    idCategoria INT,
    PRIMARY KEY (idProducto, idCategoria),
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto),
    FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
);


INSERT INTO Proveedor VALUES (1, 'TechCorp', 'ventas@techcorp.com');
INSERT INTO Categoria VALUES (1, 'Electrónica', 'Dispositivos electrónicos');
INSERT INTO Producto VALUES (1, 'Smartphone X', 750.00, 1, 1);
INSERT INTO Cliente VALUES (1, 'Ana López', 'ana@gmail.com');
INSERT INTO Pedido VALUES (1, '2025-07-05', 1);
INSERT INTO Pago VALUES (1, 'Tarjeta', 750.00, 1);
INSERT INTO Inventario VALUES (1, 20, 1);
INSERT INTO Pedido_Producto VALUES (1, 1, 2);
INSERT INTO Producto_Categoria VALUES (1, 1);


SELECT nombre FROM Producto;


DELETE FROM Cliente WHERE idCliente = 1;


CREATE FUNCTION TotalProductosPorPedido_Tienda (@idPedido INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT;
    SELECT @total = COUNT(*) FROM Pedido_Producto WHERE idPedido = @idPedido;
    RETURN ISNULL(@total, 0);
END;

CREATE PROCEDURE RegistrarPedidoProducto_Tienda
    @idPedido INT,
    @idProducto INT,
    @cantidad INT
AS
BEGIN
    INSERT INTO Pedido_Producto VAL_
