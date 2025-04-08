create database palacioDelTiempo;

use palacioDelTiempo;

create table Venta(
    codigoVenta int auto_increment primary key,
	docUsuarioFK int not null,
    docClienteFK int not null,
    direccionEnv varchar(100) not null,
    fEntrega date not null,
    fReparto date not null,
    estadoVenta bool not null,
    precioEnv double not null,
    foreign key (docUsuarioFK) references Usuario(docUsuario) 
    on delete cascade on update cascade,
    foreign key (docClienteFK) references Cliente(docCliente) 
    on delete cascade on update cascade
);


create table Producto(
	codigoProducto varchar(20) primary key,
    nombreProducto varchar(20) not null,
    precioProducto double not null,
    descripcionProducto text null,
    estadoProducto bool not null
);