create database palacioDelTiempo;

use palacioDelTiempo;

create table Usuario(
	docUsuario int primary key,
	nombreUsuario varchar(20) not null,
	appellidoUsuario varchar(20) not null,
	correoUsuario varchar(30) not null,
	estadoUsuario bool not null,
	telefonoUsuario int not null,
	direccionUsuario varchar(100) not null,
	tipoUsuario enum('Administrador','Empleado') not null,
	nickname varchar(30) not null
);

create table Cliente(
    docCliente int primary key,
    nombreCliente varchar(20) not null,
    apellidoCliente varchar(20) not null,
    correoCliente varchar(30) not null,
    estadoCliente bool not null,
    telefonoCliente int not null,
    direccionCliente varchar(100) not null,
    tipoCliente enum('Natural','Juridico')
);

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
    nombreProducto varchar(50) not null,
    precioProducto double not null,
    descripcionProducto text null,
    estadoProducto bool not null
);

create table FacturaVenta(
	codigoFactura int auto_increment primary key,
    totalFactura double not null,
    fechaEmision date not null,
    fechaVencimiento date not null,
    estadoFactura bool not null,
    estadoPago enum ('Completado','Pendiente', 'Fallido'),
    iva double not null,
    medioPago varchar(20) not null,
    codigoVentaFK int not null,
    foreign key (codigoVentaFK) references Venta(codigoVenta) 
    on delete cascade on update cascade
);

create table DetallesFactura(
	idDetalle int auto_increment primary key,
    codigoFacturaFK int not null,
    codigoProductoFK varchar(20) not null,
    cantidadProd int not null,
    precioUnitario double not null,
    foreign key (codigoFacturaFK) references FacturaVenta(codigoFactura) 
    on delete cascade on update cascade,
    foreign key (codigoProductoFK) references Producto(codigoProducto) 
    on delete cascade on update cascade
);

create table Stock(
    codigoStock int auto_increment primary key,
    idProductoFK varchar(20) not null,
    cantidadDisponible int not null,
    estadoStock bool not null,
    fEntradaProducto date not null,
    fSalidaProducto date,
    foreign key (idProductoFK) references Producto(codigoProducto)
    on delete cascade on update cascade
);

/* realizar inserciones */

describe producto;

insert into producto values ('P1', 'THOM GAFAS DE SOL迪特眼镜', '26057,16', 'Gafas de sol', true );
insert into producto values ('P2', 'BOLSAS RAYBAN', '1067.92', 'estuche', true );
insert into producto values ('P3', 'RELOJ CASIO MTP-V002', 149000.00, 'Reloj análogo para hombre, resistente al agua', true),
('P4', 'RELOJ TIMEX WEEKENDER', 199900.00, 'Reloj casual con correa intercambiable', true),
('P5', 'RELOJ SEIKO 5 SPORTS', 950000.00, 'Reloj automático con correa de acero', true),
('P6', 'CAJA RELOJ LUJO', 45900.00, 'Caja de presentación para reloj, acolchada', true),
('P7', 'CORREA CUERO NEGRO', 32000.00, 'Correa ajustable de cuero genuino', true),
('P8', 'CORREA SILICONA AZUL', 25000.00, 'Correa deportiva para reloj', true),
('P9', 'RELOJ CITIZEN ECO-DRIVE', 1200000.00, 'Reloj solar sin necesidad de batería', true),
('P10', 'RELOJ ORIENT CLASSIC', 790000.00, 'Reloj automático elegante para hombre', true),
('P11', 'RELOJ DIESEL DZ4323', 850000.00, 'Reloj cronógrafo para hombre', true),
('P12', 'RELOJ FOSSIL CH2565', 680000.00, 'Reloj deportivo de cuero', true),
('P13', 'RELOJ SKAGEN ANITA', 470000.00, 'Reloj minimalista para mujer', true),
('P14', 'RELOJ MVMT CLASSIC', 520000.00, 'Reloj moderno con diseño limpio', true),
('P15', 'RELOJ TOMMY HILFIGER', 650000.00, 'Reloj con cronógrafo y correa de acero', true),
('P16', 'RELOJ GUESS GW0030L2', 570000.00, 'Reloj de moda para mujer', true),
('P17', 'RELOJ HUGO BOSS', 899000.00, 'Reloj elegante para eventos formales', true),
('P18', 'RELOJ ARMANI EXCHANGE', 770000.00, 'Reloj juvenil y urbano', true),
('P19', 'RELOJ MICHAEL KORS', 720000.00, 'Reloj de lujo para mujer', true),
('P20', 'GAFAS POLARIZADAS RAYBAN', 180000.00, 'Protección UV y estilo', true),
('P21', 'ESTUCHE DUAL WATCH', 35000.00, 'Estuche para guardar dos relojes', true),
('P22', 'KIT LIMPIEZA RELOJES', 22000.00, 'Herramientas y paño de limpieza', true),
('P23', 'RELOJ SMARTWATCH AMAZFIT', 430000.00, 'Reloj inteligente con monitor de actividad', true),
('P24', 'RELOJ XIAOMI MI BAND 6', 180000.00, 'Pulsera inteligente con pantalla AMOLED', true),
('P25', 'RELOJ APPLE WATCH SE', 1500000.00, 'Smartwatch con GPS y sensor cardíaco', true),
('P26', 'CORREA DE MALLA METÁLICA', 42000.00, 'Correa de acero inoxidable tipo milanesa', true),
('P27', 'CAJA RELOJES MADERA NOGAL', 89000.00, 'Caja elegante para 6 relojes', true),
('P28', 'RELOJ BULOVA MOONWATCH', 1550000.00, 'Edición especial cronógrafo lunar', true),
('P29', 'RELOJ INVICTA PRO DIVER', 410000.00, 'Reloj de buceo resistente al agua', true),
('P30', 'RELOJ LUMINOX NAVY SEAL', 1300000.00, 'Reloj táctico militar', true),
('P31', 'RELOJ VOSTOK AMPHIBIA', 350000.00, 'Reloj automático ruso de buceo', true),
('P32', 'RELOJ TISSOT PRX', 1190000.00, 'Diseño clásico con movimiento suizo', true),
('P33', 'RELOJ SWATCH ORIGINAL', 290000.00, 'Reloj colorido con diseño pop', true),
('P34', 'RELOJ CASIO G-SHOCK', 670000.00, 'Reloj resistente a golpes y agua', true),
('P35', 'RELOJ CASIO VINTAGE', 115000.00, 'Reloj digital retro', true),
('P36', 'RELOJ CALVIN KLEIN', 740000.00, 'Diseño minimalista para mujer', true),
('P37', 'RELOJ DANIEL WELLINGTON', 490000.00, 'Reloj clásico con correa de tela', true),
('P38', 'RELOJ ROLEX SUBMARINER', 50000000.00, 'Reloj de lujo para coleccionistas', true),
('P39', 'RELOJ TAG HEUER CARRERA', 12400000.00, 'Cronógrafo suizo de alta gama', true),
('P40', 'RELOJ HAMILTON KHAKI FIELD', 860000.00, 'Reloj militar con diseño clásico', true),
('P41', 'RELOJ GARMIN FORERUNNER', 1350000.00, 'Smartwatch para deportistas', true),
('P42', 'RELOJ POLAR VANTAGE M', 999000.00, 'Reloj deportivo con GPS integrado', true),
('P43', 'RELOJ SUUNTO CORE', 1100000.00, 'Reloj outdoor con altímetro y barómetro', true),
('P44', 'RELOJ LORUS SPORTS', 320000.00, 'Reloj resistente para uso diario', true),
('P45', 'RELOJ FESTINA CHRONO', 540000.00, 'Reloj de cronómetro elegante', true),
('P46', 'RELOJ LOTUS URBAN CLASSIC', 360000.00, 'Diseño moderno y sofisticado', true),
('P47', 'RELOJ PUMA PU102871002', 275000.00, 'Reloj deportivo con correa de caucho', true),
('P48', 'RELOJ BEN SHERMAN', 190000.00, 'Diseño clásico con correa textil', true),
('P49', 'RELOJ ZADIG & VOLTAIRE', 310000.00, 'Diseño moderno para mujer', true),
('P50', 'RELOJ EMPORIO ARMANI', 950000.00, 'Elegante y refinado para ocasiones especiales', true);

insert into producto values ('P51', 'CORREA NATO ROJA', 28000.00, 'Correa de tela resistente para relojes deportivos', true),
('P52', 'RELOJ CASIO EDIFICE', 620000.00, 'Reloj elegante con cronómetro y correa metálica', true),
('P53', 'ESTUCHE PREMIUM MADERA', 97000.00, 'Estuche para colección de relojes con vidrio frontal', true),
('P54', 'KIT HERRAMIENTAS RELOJERO', 56000.00, 'Incluye destornilladores, pinzas y herramientas para ajuste', true),
('P55', 'GAFAS AVIADOR CLÁSICAS', 138000.00, 'Gafas con montura metálica estilo aviador', true),
('P56', 'RELOJ DIESEL RASP', 790000.00, 'Diseño moderno y robusto para uso diario', true),
('P57', 'CAJA RELOJES VIAJE', 45000.00, 'Estuche acolchado portátil para viajes', true),
('P58', 'CORREA PIEL MARRÓN', 35000.00, 'Correa de piel natural con hebilla clásica', true),
('P59', 'RELOJ SKAGEN HAGEN', 410000.00, 'Diseño delgado y minimalista con correa de malla', true);

-- Consulta basica
select * from producto;

-- consultas especificas
select codigoProducto, nombreProducto, precioProducto from Producto
where precioProducto >= 500000;

select codigoProducto, nombreProducto, descripcionProducto from Producto
where descripcionProducto like '%moderno%';

select codigoProducto, nombreProducto, descripcionProducto from Producto
where descripcionProducto like '%elegante%';

select * from producto 
order by precioProducto desc limit 10;

select * from producto 
order by precioProducto asc limit 10;

select count(*) as Disponibles
from Producto
where estadoProducto = true;

select codigoProducto, nombreProducto, precioProducto from Producto
where precioProducto between 100000 AND 1000000;

select codigoProducto, nombreProducto, descripcionProducto from Producto
where descripcionProducto like '%estuche%';

-- Modificaciones

update Producto
set estadoProducto = false
where codigoProducto = 'p28';

update Producto
set precioProducto = precioProducto * 1.20;

update Producto
set nombreProducto = 'CORREA SILICONA ROJO'
where codigoProducto = 'P8';

update Producto
set descripcionProducto = 'Reloj deportivo ideal para actividades al aire libre'
where codigoProducto = 'P12';

update Producto
set precioProducto = precioProducto * 0.95
where precioProducto between 500000 and 1000000;

-- Eliminacion

delete from Producto
where codigoProducto = 'P59';

/*rqf 19: cambiar disponibilidad de un producto*/

DELIMITER  // 
CREATE PROCEDURE cambiarDisponibilidadProducto(in p_codigoProducto varchar(20), p_estadoNuevo bool)
BEGIN

update producto
set estadoProducto = p_estadoNuevo
where codigoProducto = p_codigoProducto;
END //
DELIMITER ;

call cambiarDisponibilidadProducto('P10', true);

/* rqf 40: filtrar por precio los productos, de manera descendente */

select * from producto 
order by precioProducto desc limit 10;

/* rqf 41: insert productos mediante un procedimiento*/

DELIMITER  // 
CREATE PROCEDURE insertarProducto(in p_codigoProducto varchar(20), p_nombreProducto varchar(20), p_precioProducto double, p_descripcionProducto text, p_estadoProducto bool)
BEGIN

insert into producto values (p_codigoProducto, p_nombreProducto, p_precioProducto, p_descripcionProducto, p_estadoProducto);

END //
DELIMITER ;

call insertarProducto ('P59', 'RELOJ SKAGEN HAGEN', 410000.00, 'Diseño delgado y minimalista con correa de malla', true);

-- rqf 36: buscar producto por palabra clave

DELIMITER  // 

CREATE PROCEDURE buscarProductoPalabra(in p_palabraClave varchar(20))
BEGIN

select * from producto
where descripcionProducto like concat('%', p_palabraClave, '%' ); -- metodo CONCAT: concatenar sibolos (strings) con variables dentro de un metodo

END //
DELIMITER ;

-- drop procedure  buscarProductoPalabra;

call buscarProductoPalabra('moderno');
