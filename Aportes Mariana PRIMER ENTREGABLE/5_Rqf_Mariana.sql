create database PalacioTiempo;
use PalacioTiempo;

create table Cliente(
    docCliente int primary key,
    nombreCliente varchar(20) not null,
    apellidoCliente varchar(20) not null,
    correoCliente varchar(30) not null,
    estadoCliente bool not null,
    telefonoCliente int not null,
    direccion text not null,
    tipoCliente enum('Jurídico', 'Natural') not null
);

create table Usuario(
    docUsuario int primary key,
    nombreUsuario varchar(20) not null,
    apellidoUsuario varchar(20) not null,
    correoUsuario varchar(30) not null,
    estadoUsuario bool not null,
    tipoUsuario varchar(20) not null,
    telefonoUsuario int not null,
    direccionUsuario text not null,
    nickname varchar(30) not null
);

create table Producto(
    codigoProducto varchar(20) primary key,
    nombreProducto varchar(20) not null,
    precioProducto double not null,
    cantidadProducto int not null,
    descripcionProducto text not null,
    estadoProducto bool not null
);

create table Stock(
    codigoStock varchar(20) primary key,
    codigoProductoFK varchar(20) not null,
    estadoStock bool not null,
    fEntradaProduc date not null,
    fSalidaProduc date not null,
    foreign key (codigoProductoFK) references Producto(codigoProducto) 
    on delete cascade on update cascade
);

create table Factura(
    codigoFact varchar(20) primary key,
    docClienteFK int not null,
    fEmision date not null,
    fVencimiento date not null,
    estadoFact varchar(20) not null,
    estadoPago varchar(20) not null,
    email text not null,
    valorImp double not null,
    foreign key (docClienteFK) references Cliente(docCliente) 
    on delete cascade on update cascade
);

create table DetalleFactura(
    idDetalle int auto_increment primary key,
    codigoFactFK varchar(20) not null,
    codigoProductoFK varchar(20) not null,
    cantidad int not null,
    precioUnit double not null,
    foreign key (codigoFactFK) references Factura(codigoFact) 
    on delete cascade on update cascade,
    foreign key (codigoProductoFK) references Producto(codigoProducto) 
    on delete cascade on update cascade
);

create table Venta(
    codigoVenta varchar(20) primary key,
    codigoFactFK varchar(20) not null,
    direccionEnv text not null,
    fEntrega date not null,
    fReparto date not null,
    estadoVenta varchar(20) not null,
    productosEnv varchar(100) not null,
    precioEn double not null,
    foreign key (codigoFactFK) references Factura(codigoFact) 
    on delete cascade on update cascade
);

-- Insertar clientes
INSERT INTO Cliente (docCliente, nombreCliente, apellidoCliente, correoCliente, estadoCliente, telefonoCliente, direccion, tipoCliente) 
VALUES (101, 'Juan', 'Pérez', 'juan@example.com', 1, 123456789, 'Calle 123', 'Natural');
INSERT INTO Cliente (docCliente, nombreCliente, apellidoCliente, correoCliente, estadoCliente, telefonoCliente, direccion, tipoCliente) 
VALUES (102, 'María', 'López', 'maria@example.com', 1, 987654321, 'Avenida 456', 'Natural');


-- Insertar productos
INSERT INTO Producto (codigoProducto, nombreProducto, precioProducto, cantidadProducto, descripcionProducto, estadoProducto) 
VALUES 
('P001', 'Reloj Casio', 50.00, 100, 'Reloj digital resistente al agua', 1),
('P002', 'Reloj Seiko', 120.00, 50, 'Reloj analógico de lujo', 1);

-- Insertar factura
INSERT INTO Factura (codigoFact, docClienteFK, fEmision, fVencimiento, estadoFact, estadoPago, email, valorImp) 
VALUES ('F002', 102, '2025-03-31', '2025-04-30', 'Activa', 'Pagada', 'maria@example.com', 0.15);
INSERT INTO Factura (codigoFact, docClienteFK, fEmision, fVencimiento, estadoFact, estadoPago, email, valorImp) 
VALUES ('F001', 101, '2025-03-30', '2025-04-30', 'Activa', 'Pendiente', 'juan@example.com', 0.12);

-- Insertar detalles de la factura (productos comprados)
INSERT INTO DetalleFactura (codigoFactFK, codigoProductoFK, cantidad, precioUnit) 
VALUES 
('F001', 'P001', 2, 50.00), -- 2 relojes Casio a $50 cada uno
('F001', 'P002', 1, 120.00); -- 1 reloj Seiko a $120
INSERT INTO DetalleFactura (codigoFactFK, codigoProductoFK, cantidad, precioUnit) 
VALUES 
('F002', 'P001', 3, 50.00),  -- 3 Relojes Casio a $50 cada uno
('F002', 'P002', 2, 120.00); -- 2 Relojes Seiko a $120 cada uno



/*Creacion de 5 RQF*/
/*RQF004 Cálculo del SUBtotal de la factura*/
SELECT 
    f.codigoFact AS Codigo_Factura,
    c.nombreCliente AS Cliente,
    c.apellidoCliente AS Apellido,
    SUM(df.cantidad * df.precioUnit) AS SUBtotal
FROM Factura f
JOIN Cliente c ON f.docClienteFK = c.docCliente
JOIN DetalleFactura df ON f.codigoFact = df.codigoFactFK
WHERE f.codigoFact = 'F002' 
GROUP BY f.codigoFact, c.nombreCliente, c.apellidoCliente, f.valorImp;



/*RQF005 Cálculo del total de la factura*/
SELECT 
    f.codigoFact AS Codigo_Factura,
    c.nombreCliente AS Cliente,
    c.apellidoCliente AS Apellido,
    SUM(df.cantidad * df.precioUnit) AS SUBtotal,
    SUM(df.cantidad * df.precioUnit) * f.valorImp AS Impuesto, -- Valor del impuesto
    SUM(df.cantidad * df.precioUnit) * (1 + f.valorImp) AS Total
FROM Factura f
JOIN Cliente c ON f.docClienteFK = c.docCliente
JOIN DetalleFactura df ON f.codigoFact = df.codigoFactFK
WHERE f.codigoFact = 'F002' 
GROUP BY f.codigoFact, c.nombreCliente, c.apellidoCliente, f.valorImp;



/*RQF008 Modificar la información de la Venta con un procedimiento almacenado*/
DELIMITER //
CREATE PROCEDURE ModificarVenta2(IN p_codigoVenta VARCHAR(20), IN p_fEntraga DATE, IN p_fReparto DATE, IN p_estadoVenta VARCHAR(20),
	IN p_direccionEnv TEXT, IN p_productosEnv VARCHAR(100), IN p_precioEn DOUBLE
)
BEGIN
    UPDATE Venta SET fEntrega = p_fEntraga, fReparto = p_fReparto, estadoVenta = p_estadoVenta, direccionEnv = p_direccionEnv,
        productosEnv = p_productosEnv, precioEn = p_precioEn WHERE codigoVenta = p_codigoVenta;
END //
DELIMITER ;
-- Ejemplo de ejecucion
INSERT INTO Venta VALUES ('V001', 'F001', 'Av. Siempre Viva 742', '2025-04-10', '2025-04-08', 'Pendiente', 
'Reloj Casio, Reloj Seiko', 15.75);
INSERT INTO Venta VALUES ('V003', 'F002', 'Calle Los Rosales 123', '2025-04-12', '2025-04-10', 'En camino', 
'Reloj Rolex, Reloj Omega', 20.00);
desc venta;
CALL ModificarVenta2('V001', '2025-04-05','2025-04-03','En camino','Calle Nueva 123','Reloj Casio, Reloj Seiko',10.50);
SELECT * FROM Venta WHERE codigoVenta = 'V001';



/*RQF009 Consultar productos enviados en una venta*/
SELECT codigoVenta, productosEnv FROM Venta WHERE codigoVenta = 'V003'; 



/*RQF022 Inactivar Cientes*/
DELIMITER //
CREATE PROCEDURE InactivarCliente(IN p_docCliente INT)
BEGIN
    UPDATE Cliente SET estadoCliente = 0 WHERE docCliente = p_docCliente;
END //
DELIMITER ;
-- Ejemplo de ejecucion
CALL InactivarCliente(102);
SELECT docCliente, nombreCliente, estadoCliente FROM Cliente WHERE docCliente = 102;









