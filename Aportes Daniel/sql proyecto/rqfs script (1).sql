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
    ciudadCliente varchar (20) not null,
    tipoCliente enum('Jurídico', 'Natural') not null
);

create table Usuario(
    docUsuario int primary key,
    nombreUsuario varchar(20) not null,
    claveUsuario varchar(20) not null,
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

insert into cliente values(1014665735, 'Daniel', 'Moreno', 'dani@gmail.com', 1 ,
3204051805, 'carrera 68', 'Bogota', 'Natural') ;

-- Consultar clientes por ciudad

select * from cliente where ciudadCliente = 'Bogota';

insert into factura values('F001', 1014665735, '2025-01-01', '2026-01-01', 'Activa',
'Pagada', 'dani@gmail.com', 100);

-- Consultar factura por email

select * from factura where email = 'dani@gmail.com';

insert into producto values ('R001', 'xiaomi watch', 1000, 10, 'reloj inteligente', 1);

select * from producto;

-- modificar estado producto

DELIMITER //

CREATE PROCEDURE ModificarEstadoProducto(
    IN p_codigoProducto VARCHAR(20),
    IN p_estadoProducto BOOLEAN
)
BEGIN
    UPDATE Producto
    SET estadoProducto = p_estadoProducto
    WHERE codigoProducto = p_codigoProducto;
END //

DELIMITER ;

CALL ModificarEstadoProducto('R001', 0);
