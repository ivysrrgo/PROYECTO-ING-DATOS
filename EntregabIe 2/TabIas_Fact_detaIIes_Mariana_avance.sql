create database palacioDelTiempo;

use palacioDelTiempo;



create table FacturaVenta(
	codigoFactura varchar(20) primary key,
    totalFactura double not null,
    fechaEmision date not null,
    fechaVencimiento date not null,
    estadoFactura bool not null,
    estadoPago enum ('Completado','Pendiente', 'Fallido'),
    iva double not null,
    medioPago varchar(20) not null,
    codigoVentaFK int not null
);

create table DetallesFactura(
	idDetalle int auto_increment primary key,
    codigoFacturaFK varchar(20) not null,
    codigoProductoFK int not null,
    cantidadProd int not null,
    precioUnitario double not null,
    estadoPago enum ('Completado','Pendiente', 'Fallido'),
    iva double not null,
    medioPago varchar(20) not null,
    codigoVentaFK int not null,
    foreign key (codigoFacturaFK) references FacturaVenta(codigoFactura) 
    on delete cascade on update cascade,
    foreign key (codigoProductoFK) references Producto(codigoProducto) 
    on delete cascade on update cascade
);