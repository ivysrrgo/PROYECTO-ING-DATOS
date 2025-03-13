create database PalacioTiempo;

use PalacioTiempo;

create table Cliente(
docCliente int primary KEY,
nombreCliente varchar (20) not null,
apellidoCliente varchar (20) not null,
correoCliente varchar(30) not null,
estadoCliente bool not null,
telefonoCliente int not null,
direccion text not null,
tipoCliente enum ('Jurídico','Natural') not null
);

create table Usuario(
docUsuario int primary KEY,
nombreUsuario varchar (20) not null,
apellidoUsuario varchar (20) not null,
correoUsuario varchar(30) not null,
estadoUsuario bool not null,
tipoUsuario varchar(20) not null,
telefonoUsuario int not null,
direccionUsuario text not null,
nickname varchar(30) not null
);

create table Producto(
codigoProducto varchar(20) primary KEY,
nombreProducto varchar (20) not null,
precioProducto double not null,
cantidadProducto int not null,
descripcionProducto text not null,
estadoProducto bool not null,
codigoStockFK int not null,
foreign key (codigoStockFK) references Stock(codigoStock) on delete cascade on update cascade

);

