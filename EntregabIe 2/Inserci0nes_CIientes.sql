create database palacioDelTiempo;

use palacioDelTiempo;
create table Usuario(
	docUsuario int primary key,
	nombreUsuario varchar(20) not null,
	appellidoUsuario varchar(20) not null,
	correoUsuario varchar(50) not null,
	estadoUsuario bool not null,
	telefonoUsuario int unsigned not null,
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

insert into producto values ('P1', 'THOM GAFAS DE SOL迪特眼镜', 26057.16, 'Gafas de sol', true );
insert into producto values ('P2', 'BOLSAS RAYBAN', 1067.92, 'estuche', true );
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


desc Cliente;
INSERT INTO Cliente (docCliente, nombreCliente, apellidoCliente, correoCliente, estadoCliente, telefonoCliente, direccionCliente, tipoCliente) VALUES
(92193950, 'MELIDA', 'FUENTES', 'melidapin4@gmail.com', true, 313801, '', 'Natural'),
(1002300530, 'YEISON', 'ESTUPIÑAN TORRES', 'yeisonestupinan47@gmail.com', true, 3208111, 'CL 75 C SUR 4 24', 'Natural'),
(1002599645, 'NELFY', 'RODRIGUEZ', 'sofi.18@hotmail.es', true, 3144806, 'CL 19 5 58', 'Natural'),
(1010171307, 'LUIGY', 'HERNANDEZ', 'lhernandezga2@gmail.com', true, 3143690, 'BOGOTA', 'Natural'),
(1010185799, 'JHONATAN', 'AVILA', 'jhonatanavila@live.com', true, 4444444, 'cl  #0-00', 'Natural'),
(1010187182, 'YISETH', 'MAHECHA', 'yisethmahecha@gmail.com', true, 3003571, 'CL 11 11 79', 'Natural'),
(1010218476, 'LUISA FERNANDA', 'MURILLO', 'Luisamurillog94@gmail.com', true, 0, 'CL 150 16 56 LC 1085', 'Natural');
INSERT INTO Cliente (docCliente, nombreCliente, apellidoCliente, correoCliente, estadoCliente, telefonoCliente, direccionCliente, tipoCliente) VALUES
(1010235161, 'KAREN', 'GOMEZ', 'karensiomarin223@gmail.com', true, 86774735, 'BOGOTA', 'Natural'),
(1012383973, 'RAMIREZ', 'JOHAN', 'sincorreo@correo.com', true, 23104056, '', 'Natural'),
(1012395828, 'JORGE ELIECER', 'BARRERA HERNANDEZ', 'jorgebh.93.01@gmail.com', true, 9999999, 'CR 77 A 75 551', 'Natural'),
(1013587671, 'ANDREA', 'PALACIOS', 'sincorreo@correo.com', true, 3860178, '', 'Natural'),
(1013629920, 'ALBA LUZ', 'RUBIO GARCIA', 'albitarubio174@gmail.com', true, 3996412, 'CL 49S 13G 21 ESTE', 'Natural'),
(1013641332, 'MIGUEL SANTIAGO', 'GOMEZ GIRALDO', 'sincorreo@correo.com', true, 9999999, '', 'Natural'),
(1013657211, 'GUISELL LORENA', 'SANCHEZ', 'maryi2216@hotmai.com', true, 8100379, 'CR 109 71 A 47', 'Natural'),
(1014197405, 'steven', 'correa', 'stevenco1023@gmail.com', true, 2152021, 'CR 92 A 72 A 23', 'Natural'),
(1015424147, 'WILLIAM', 'CEBALLOS', 'william.ceballos2323@gmail.com', true, 9999999, 'BOGOTA', 'Natural'),
(1016000283, 'AVILA', 'CAROLINA', 'sincorreo@correo.com', true, 9999999, '', 'Natural');
INSERT INTO Cliente (docCliente, nombreCliente, apellidoCliente, correoCliente, estadoCliente, telefonoCliente, direccionCliente, tipoCliente) VALUES
(1016026285, 'CINDY LORENA', 'VELEZ GARCIA', 'cindyvelez90@hotmail.com', true, 7042791, 'CR 91 20 A 65 IN 8 AP 202', 'Natural'),
(1016083358, 'PAULA', 'MARTIN MEJIA', 'sincorreo@correo.com', true, 9999999, '', 'Natural'),
(1018407786, 'CLAUDIA LILIANA', 'NOVOA', 'claudialinovoa@gmail.com', true, 3183119, 'BOGOTA', 'Natural'),
(1018442663, 'DIEGO', 'CORREDOR', 'sincorreo@correo.com', true, 9999999, 'BOGOTA', 'Natural'),
(1018488125, 'JOAAN SEBASTIAN', '', 'sincorreo@correo.com', true, 9999999, 'BOGOTA', 'Natural'),
(1020727299, 'CRISTINA', 'MUÑOZ ANGARITA', 'sincorreo@correo.com', true, 3138142, 'DG 182 20 17', 'Natural'),
(1020738129, 'DIEGO FERNANDO', 'MURILLO GONZALEZ', 'joyeriamoderna@gmail.com', true, 601705, 'CL 138 55 53 IN 6', 'Natural'),
(1022353467, 'JONATHAN', 'DIAZ RUIZ', 'sincorreo@correo.com', true, 9999999, 'BOGOTA', 'Natural'),
(1022391520, 'CARLOS ALEXIS', 'HERNANDEZ MARTINEZ', 'carlosalexish30@gmail.com', true, 3103454, 'CL 9 36 03 LC 16', 'Natural'),
(1022417338, 'CRISTHIAN', 'MORA', 'sincorreo@correo.com', true, 9999999, '', 'Natural'),
(1022991866, 'GUSTAVO', 'RUEDA CASTILLO', 'sincorreo@correo.com', true, 3014805, 'DG 98 A 12 ESTE', 'Natural'),
(1022995840, 'LEIDY GERALDIN', 'FONSECA TORRES', 'geraldinatorres@gmail.com', true, 9999999, 'TV 4 C 87 18 SUR', 'Natural'),
(1023917957, 'JAZBLEYDI', '', 'sincorreo@correo.com', true, 9999999, 'BOGOTA', 'Natural'),
(1023924818, 'JULIETH ANDREA', 'GONZALEZ', 'sincorreo@correo.com', true, 3229715, 'CR 7 BIS 35 B 53 SUR', 'Natural'),
(1023933325, 'MICHAEL STEVE', 'PEREZ MEDINA', 'miichael.element@gmail.com', true, 3156533, 'CR 4 B 36 A 31 SUR', 'Natural'),
(1024545393, 'JUAN', 'BORJA', 'sincorreo@correo.com', true, 9999999, 'BOGOTA', 'Natural');
INSERT INTO Cliente (docCliente, nombreCliente, apellidoCliente, correoCliente, estadoCliente, telefonoCliente, direccionCliente, tipoCliente) 
VALUES (1024561198, 'DIANA', 'MARTINEZ', 'diana.martinez@gmail.com', true, 0, 'BOGOTA', 'Natural'),
(1026262781, 'LINA MARCELA', 'CUESTA', 'linamarcela@gmail.com', true, 3153617, 'BOGOTA', 'Natural'),
(1027524341, 'INGRID YURANI', 'RODRIGUEZ', 'ingridyurany2005@gmail.com', true, 0, 'BOGOTA', 'Natural'),
(10280550, 'JOSE GERARDO', 'CARMONA', 'gerardocarmona1968@gmail.com', true, 3113974, 'CL 11 12 35 CUNDINAMARCA CHIA', 'Natural'),
(10289718, 'CARLOS ALBERTO', 'CARMONA', 'jvsolucionesles2@gmail.com', true, 3173501, 'CR 11 10 49 CUNDINAMARCA CHIA', 'Natural'),
(1030560401, 'LIBER', 'MEDINA', 'liber.medina@gmail.com', true, 0, 'BOGOTA', 'Natural'),
(1030588860, 'ALEJANDRO', 'PRADA', 'alejandro.prada@gmail.com', true, 3134611, 'CRA 38 10 90', 'Natural'),
(1030635179, 'BRENDA', 'ROJAS', 'bien.rojas@hotmail.com', true, 3188110, 'BOGOTA', 'Natural'),
(1031165346, 'ALEJANDRA', 'SATOBA', 'u0304519@unimilitar.edu.co', true, 3124705, 'CRA 9 17 63 LC 113 BOGOTA', 'Natural'),
(1032442034, 'LINDA JACKELINE', 'MARTINEZ', 'linda17.25@hotmail.com', true, 3058136, 'CL 9 37 A 49 BOGOTA D.C.', 'Natural'),
(1038434941, 'WILDER ANTONIO', 'DE HOYOS', 'wilderdehoyos6@hotmail.com', true, 3177219, 'CR 130 137 B 30 BOGOTA D.C.', 'Natural'),
(1049413366, 'JHIMMY JAIR', 'TORRES', 'jairtorrespuentes@gmail.com', true, 3132017, 'CR 80 50 43 SUR BOYACA EL COCUY', 'Natural'),
(1050546584, 'LUZ DARI', 'SERNA', 'luzdarism76@gmail.com', true, 3144150, 'CL 17 9 25 BOLIVAR SAN PABLO', 'Natural'),
(1053329241, 'LUIS ANTONIO', 'ROMERO', 'romaluis_@hotmail.com', true, 0, 'BOGOTA', 'Natural'),
(1067094704, 'ADRIANA MARCELA', 'ALMANZA', 'adrianauni10@hotmail.com', true, 3196514, 'CRA 130 137 B 30 BOGOTA D.C.', 'Natural'),
(1069099130, 'YAMILE GEOMAR', 'BAUTISTA MONTERO', 'yagebamo@gmail.com', true, 3023536, 'CR 10 12 36 CUNDINAMARCA CHIA', 'Natural');
INSERT INTO Cliente (docCliente, nombreCliente, apellidoCliente, correoCliente, estadoCliente, telefonoCliente, direccionCliente, tipoCliente) VALUES
(1069731813, 'MABELL', 'BERNAL', 'sincorreo@ejemplo.com', false, 3192843, 'SIN DIRECCION', 'Natural'),
(1070199659, 'ALBERT', 'CAMACHO', 'sincorreo@ejemplo.com', true, 0, 'SIN DIRECCION', 'Natural'),
(1070954750, 'ELKIN', 'SANABRIA', 'ELKINZA2189@GMAIL.COM', true, 3175511, 'CL 57B SUR 71 C 06, BOGOTA D.C.-BOGOTA, D.C.', 'Natural'),
(1072650597, 'YEIMI PAOLA', 'USME', 'paolita1.usme1@gmail.com', true, 3222329, 'BOGOTA', 'Natural'),
(1075150046, 'ALEX', 'MUÑOZ', 'sincorreo@ejemplo.com', true, 0, 'BOGOTA', 'Natural'),
(1075284368, 'QUESADA', 'OSCAR', 'sincorreo@ejemplo.com', true, 0, 'SIN DIRECCION', 'Natural'),
(1083905835, 'JERALDIN', 'HERNANDEZ', 'thalihernandez@outlook.com', true, 0, 'CR 3 6 54 CC LA TERCERA, HUILA-PITALITO', 'Natural'),
(1097604252, 'ALEXANDER', 'RAMIREZ', 'sincorreo@ejemplo.com', false, 0, 'BOGOTA', 'Natural'),
(1103114380, 'RUIZ', 'JEHERCIÑO', 'sincorreo@ejemplo.com', true, 0, 'BOGOTA', 'Natural'),
(1104708940, 'CRISTAN', 'CASTRO', 'libalokotolima@hotmail.com', true, 0, 'CR 3 N 16 51 LC 10 77 BRR CENTRO, TOLIMA-IBAGUE', 'Natural'),
(1106244682, 'CORREA', 'SAMUEL', 'sincorreo@ejemplo.com', true, 3238139, 'TULUA', 'Natural'),
(1110570484, 'JESSICA ANDREA', 'GUERRERO ALAPE', 'jesanguerreroal@gmail.com', true, 0, 'CR 7 4 -16, CAQUETA-FLORENCIA', 'Natural'),
(1115075252, 'JOSE ADONAY', 'GIRALDO CARMONA', 'giraldojose35@outlook.com', true, 3158296, 'CR 18B 28 A 34 BRR MONTELLANO, VALLE DEL CAUCA-GUADALAJARA DE BUGA', 'Natural');
INSERT INTO Cliente (docCliente, nombreCliente, apellidoCliente, correoCliente, estadoCliente, telefonoCliente, direccionCliente, tipoCliente) VALUES
(1115085371, 'OSCAR IVAN', 'ZUÑIGA', 'sincorreo@ejemplo.com', false, 0, 'BOGOTA', 'Natural'),
(1118555956, 'WILLINTON', 'JIMENEZ', 'sincorreo@ejemplo.com', false, 3219316, 'BOGOTA', 'Natural'),
(11187904, 'LEONARDO', 'MURCIA', 'sincorreo@ejemplo.com', true, 3103071, 'CALLE 74 23 86-40', 'Natural'),
(1121706842, 'JANETH', 'FAJARDO', 'sincorreo@ejemplo.com', true, 3048309, 'SIN DIRECCION', 'Natural'),
(1121713100, 'EMERSON ELIAS', 'OSORIO ACEVEDO', 'osorioemersonelias@gmail.com', true, 3227027, 'CL 34 2 A 14 BRR GALAN', 'Natural'),
(1121883802, 'ERIKA', 'TRIANA', 'sincorreo@ejemplo.com', true, 0, 'VILLAVICENCIO', 'Natural'),
(1121898908, 'HAYFFA ALEXANDRA', 'ABUASSI MORENO', 'hayffa.1@gmail.com', true, 0, 'CR 35 A 5 A 1125 SUR TORRES DE SALERNO 1', 'Natural'),
(1121898994, 'CAMILA', 'CELIS', 'sincorreo@ejemplo.com', true, 3126144, 'VILLAVICENCIO', 'Natural'),
(1121910243, 'CARLOS MARIO', 'MARIN RODRIGUEZ', 'charlsmarinel@gmail.com', true, 0, 'MZ H 10 CA 3 B URB PRADOS DE MAVICURE', 'Natural'),
(11523717, 'CAMILO', 'RODRIGUEZ', 'camilomany@hotmail.com', true, 3117807, 'SIN DIRECCION', 'Natural'),
(11524433, 'FABIAN RICARDO', 'CUBILLOS MERCHAN', 'fabiancubillos2010@gmail.com', true, 3103001, 'CL 8 14 74 CEN', 'Natural'),
(12125049, 'CAERLOS EDUARDO', 'GARCES', 'sincorreo@ejemplo.com', true, 0, 'SIN DIRECCION', 'Natural'),
(12209739, 'CARLOS ENRIQUE', 'HERNANDEZ QUINTERO', 'timoh19@hotmail.com', true, 3133864, 'CR 4 2 60', 'Natural'),
(12276281, 'OLMES', 'GARCIA', 'mileniumfashionco@gmail.com', true, 3132100, 'CR 6 7 21', 'Natural'),
(1233892143, 'SEBASTIAN', 'TOVAR', 'sebastiantvs.0731@gmail.com', true, 0, 'CR 76 41 G 23 SUR', 'Natural'),
(12401337, 'JAVIER EDUARDO', 'HERNANDEZ PINO', 'javierprimo1979@hotmail.com', true, 3095868, 'CR 9 18 60 LC 6', 'Natural'),
(14259394, 'JAYSON', 'SIN APELLIDO', 'sincorreo@ejemplo.com', true, 0, 'SIN DIRECCION', 'Natural');
INSERT INTO Cliente (docCliente, nombreCliente, apellidoCliente, correoCliente, estadoCliente, telefonoCliente, direccionCliente, tipoCliente) VALUES
(15325489, 'PEDRO', 'DIAZ TORREZ', 'sincorreo@correo.com', false, 1000000, '', 'Natural'),
(158001, 'GUILLERMO', 'RODRIGUEZ GOMEZ', 'sincorreo@correo.com', true, 1000000, 'AVE.19 NO.9-16, ARMENIA', 'Natural'),
(15877487, 'JUAN', 'SAAVEDRA WANDERLEY', 'impocasabella@hotmail.com', true, 5925208, 'CL 8 9 69, AMAZONAS-LETICIA', 'Natural'),
(16737691, 'DANILO', 'REYES MENDEZ', 'danilolocal48@gmail.com', true, 3105052, 'CRA 5 15 21, VALLE DEL CAUCA-JAMUNDI', 'Natural'),
(17132685, 'CARLOS', 'GALLO OBREGOSO', 'x.gallo@gmail.com', true, 3424048, 'CR 7 19 401, BOGOTA D.C.', 'Natural'),
(17327084, 'ORLANDO', 'OCAMPO', 'sincorreo@correo.com', true, 1000000, '', 'Natural'),
(17356955, 'LEONARDO', 'GALVIS', 'sincorreo@correo.com', false, 8565356, 'CRA 15 NO. 18A-15, VILLAVICENCIO', 'Natural'),
(17416955, 'PEDRO JOSE', 'CASTRO', 'sincorreo@correo.com', true, 6561432, 'CALLE 15 N. 12-33, ACACIAS', 'Natural'),
(17418933, 'HERNANDO', 'CLAVIJO', 'sincorreo@correo.com', true, 3182928, '', 'Natural'),
(17456987, 'CARLOS ALBERTO', 'GUZMAN', 'sincorreo@correo.com', false, 1000000, 'CRA 3 N.4-12, RESTREPO', 'Natural'),
(17546369, 'CARLOS', 'RAMIREZ', 'sincorreo@correo.com', true, 1000000, 'CALLE 35 N. 12-36, IBAGUE', 'Natural'),
(17569523, 'WILZON', 'RAMIREZ', 'sincorreo@correo.com', false, 1000000, 'CALLE12 N. 36 -14, BARANQUILLA', 'Natural'),
(17653267, 'ALVARO', 'ZAMBRANO', 'sincorreo@correo.com', true, 1000000, '', 'Natural'),
(18001454, 'JAVIER PEÑA', 'PEÑA HENRY', 'motosai@hotmail.com', true, 5126297, 'AV COLON CL 2A 3 135, SAN ANDRES', 'Natural'),
(18564985, 'CARLOS', 'CASTAÑEDA', 'sincorreo@correo.com', false, 1000000, 'DIAG. 79 N. 78A-40, VILLAVICENCIO', 'Natural'),
(18929078, 'FREDDY', 'GELVEZ BUSTOS', 'gelvezfreddy4@gmail.com', true, 1000000, 'CR 10 A BIS 12 65, CESAR-AGUACHICA', 'Natural'),
(19225446, 'FILIBERTO', 'TORREZ', 'sincorreo@correo.com', true, 1000000, 'AV.CARACAS 32-89, IPIALES', 'Natural'),
(19286498, 'TINOCO', 'VENTURA', 'tinocoventura18@gmail.com', true, 320253191, 'CR 6 7 -36 LC 121, CUNDINAMARCA-FUSAGASUGA', 'Natural'),
(19333255, 'DANIEL', 'BARATO ABELLO', 'sincorreo@correo.com', true, 1000000, 'CLL.36B NO.1B-25, ARMENIA', 'Natural');
INSERT INTO Cliente (
    docCliente, nombreCliente, apellidoCliente, correoCliente,
    estadoCliente, telefonoCliente, direccionCliente, tipoCliente
) VALUES
(19401111, 'ALBERTO', 'MUÑOZ', '', true, 3103214, 'CALLE 27 SUR 15 03', 'Natural'),
(19401694, 'GOMEZ', 'JAIME', '', true, 3112000, '', 'Natural'),
(19418691, 'MELO', 'CARLOS ORLANDO', 'orlandomelo@hotmail.es', true, 3008770, 'DIAG 40C SUR 72 J 80', 'Natural'),
(22243992, 'DALGY', 'PEREZ', '', true, 3123132, '', 'Natural'),
(23621452, 'ARGUELLO PINTO', 'MARTHA YANETH', 'marthayarpi@gmail.com', true,8471000, 'CRA 7  10 67', 'Natural'),
(23623406, 'CAROLINA', 'MOSQUERA', 'carito.mosquera13@gmail.com', true, 21111, 'CL 0 #0', 'Natural'),
(23854410, 'FLOR', 'CASTRO', 'granados.florcastro@gmail.com', true, 3118173, '', 'Natural'),
(24356899, 'DIAZ', 'CLARA LINA', '', false, 2142563, 'DIAG.30A NO.19-32', 'Natural'),
(24587513, 'PAOLA ANDREA', 'LONDOÑO', '', true, 3113280, '', 'Natural');

insert into Usuario values
(981234585, 'Clara Lucía', 'Morales González', 'clara.morales@hotmail.com', true, 30103456, 'Carrera 70 #45-67, Bogotá', 'Empleado', 'claralucia'),
(901234585, 'Antonio José', 'González Díaz', 'antonio.gonzalez@hotmail.com', true, 3010012345, 'Carrera 35 #23-45, Bogotá', 'Empleado', 'antoniojose'),
(109234595, 'Martín Felipe', 'Hernández Ruiz', 'martin.hernandez@hotmail.com', true, 3011012345, 'Avenida 12 #56-78, Bogotá', 'Empleado', 'martinfelipe'),
(881234575, 'Pedro Pablo', 'Vázquez Ruiz', 'pedropablo.vazquez@gmail.com', true, 3009012345, 'Carrera 45 #67-89, Bogotá', 'Empleado', 'pedropablo'),
(931234580, 'Miguel Ángel', 'Díaz Gómez', 'miguel.diaz@gmail.com', true, 3009567890, 'Calle 70 #56-78, Bogotá', 'Empleado', 'miguelangel'),
(105234591, 'Ricardo Andrés', 'González López', 'ricardo.gonzalez@hotmail.com', true, 3010678901, 'Carrera 50 #12-34, Bogotá', 'Empleado', 'ricardoandres'),
(107234593, 'Oscar Antonio', 'Gómez Fernández', 'oscar.gomez@gmail.com', true, 3010890123, 'Calle 40 #45-67, Bogotá', 'Empleado', 'oscarantonio'),
(119234605, 'Rosa Margarita', 'Romero Silva', 'rosa.romero@gmail.com', true, 3012012345, 'Calle 56 #78-90, Bogotá', 'Empleado', 'rosamargarita'),
(114234600, 'Ramón Eduardo', 'Díaz Rodríguez', 'ramon.diaz@gmail.com', true, 3011567890, 'Calle 21 #45-67, Bogotá', 'Empleado', 'ramoneduardo'),
(921234579, 'José Antonio', 'García Martínez', 'jose.antonio.garcia@gmail.com', true, 3009456789, 'Avenida 60 #23-45, Bogotá', 'Empleado', 'joseantonio'),
(116234602, 'Raúl Ernesto', 'Rojas Herrera', 'raul.rojas@gmail.com', true, 3011789012, 'Calle 98 #45-67, Bogotá', 'Empleado', 'raulernesto'),
(111234597, 'Mónica Alejandra', 'Campos Díaz', 'monica.campos@hotmail.com', true, 3011234567, 'Carrera 12 #34-56, Bogotá', 'Empleado', 'monicaalejandra'),
(861234573, 'José Luis', 'López Herrera', 'joseluis.lopez@hotmail.com', true, 3007890123, 'Carrera 20 #13-45, Bogotá', 'Empleado', 'joseluis'),
(971234584, 'Ricardo Javier', 'Álvarez Pérez', 'ricardo.alvarez@gmail.com', true, 3009901234, 'Avenida 40 #56-78, Bogotá', 'Empleado', 'ricardojavier'),
(110234596, 'Esteban Alejandro', 'Cordero Paredes', 'esteban.cordero@gmail.com', true, 3011123456, 'Calle 23 #12-34, Bogotá', 'Empleado', 'estebanalex'),
(104234590, 'Beatriz Elena', 'Serrano Ríos', 'beatriz.serrano@gmail.com', true, 3010567890, 'Calle 60 #34-56, Bogotá', 'Empleado', 'beatrizelena'),
(100123456, 'Sara Beatriz', 'Villar Ortega', 'sara.villar@hotmail.com', true, 3010901234, 'Carrera 33 #23-45, Bogotá', 'Empleado', 'sarabeatriz'),
(971234583, 'María Dolores', 'Hernández Gómez', 'maria.dolores.hernandez@hotmail.com', true, 3009890123, 'Calle 90 #34-56, Bogotá', 'Empleado', 'mariadolores'),
(761234567, 'Juan Carlos', 'Pérez Gómez', 'juancarlos.perez@hotmail.com', true, 3001234567, 'Calle 123 #45-67, Bogotá', 'Administrador', 'juancarlos'),
(821234570, 'Ana María', 'Rodríguez Pérez', 'anamaria.rodriguez@gmail.com', true, 3004567890, 'Avenida 68 #23-45, Bogotá', 'Administrador', 'anamaria'),
(101234587, 'Fernando Javier', 'Mora Sánchez', 'fernando.mora@gmail.com', true, 3010234567, 'Calle 80 #12-34, Bogotá', 'Empleado', 'fernandojavier'),
(113234599, 'Lucía Fernanda', 'Ramírez Ríos', 'lucia.ramirez@hotmail.com', true, 3011456789, 'Carrera 67 #23-45, Bogotá', 'Empleado', 'luciafernanda'),
(951234582, 'Santiago José', 'Torres Rodríguez', 'santiago.torres@hotmail.com', true, 3009789012, 'Calle 30 #78-90, Bogotá', 'Empleado', 'santiagojose'),
(871234574, 'Raquel María', 'Moreno Díaz', 'raquel.moreno@hotmail.com', true, 3008901234, 'Calle 10 #21-43, Bogotá', 'Empleado', 'raquelmaria'),
(901234577, 'Carlos Enrique', 'Ramírez Rodríguez', 'carlos.ramirez@hotmail.com', true, 3009234567, 'Calle 55 #12-34, Bogotá', 'Empleado', 'carlosenrique'),
(931234581, 'Laura Isabel', 'Gómez Sánchez', 'laura.gomez@gmail.com', true, 3009876543, 'Carrera 10 #20-45, Bogotá', 'Empleado', 'lauraisabel'),
(112234598, 'Carlos Alberto', 'Martínez Pérez', 'carlos.martinez@hotmail.com', true, 3012345678, 'Calle 22 #11-23, Bogotá', 'Empleado', 'carlosalberto'),
(932234580, 'Estefanía Paola', 'Ramírez Ríos', 'estefania.ramirez@gmail.com', true, 3012348765, 'Carrera 45 #65-23, Bogotá', 'Empleado', 'estefaniapaola'),
(932234586, 'Francisco Javier', 'Torres López', 'francisco.torres@gmail.com', true, 3007654321, 'Calle 14 #12-45, Bogotá', 'Empleado', 'franciscojavier'),
(951234585, 'Gabriela Patricia', 'González Pérez', 'gabriela.gonzalez@gmail.com', true, 3002345678, 'Carrera 9 #23-56, Bogotá', 'Empleado', 'gabrielapatricia'),
(102234589, 'Javier Antonio', 'Rodríguez López', 'javier.rodriguez@hotmail.com', true, 3012345678, 'Calle 34 #56-78, Bogotá', 'Empleado', 'javierantonio'),
(104234588, 'Silvia Alejandra', 'Martínez Ruiz', 'silvia.martinez@gmail.com', true, 3008765432, 'Carrera 77 #45-67, Bogotá', 'Empleado', 'silviaalejandra'),
(981234586, 'Manuel Ernesto', 'Hernández Paredes', 'manuel.hernandez@gmail.com', true, 3007654321, 'Calle 24 #34-45, Bogotá', 'Empleado', 'manuelernesto'),
(100123457, 'Luis Eduardo', 'Sánchez Gómez', 'luis.sanchez@hotmail.com', true, 3009876543, 'Calle 67 #23-45, Bogotá', 'Empleado', 'luiseduardo'),
(109234596, 'Daniela María', 'Rojas Sánchez', 'daniela.rojas@gmail.com', true, 3013456789, 'Calle 12 #45-67, Bogotá', 'Empleado', 'danielamaria'),
(931234582, 'Evelyn Carolina', 'Moreno Gómez', 'evelyn.moreno@gmail.com', true, 3012346789, 'Carrera 56 #89-23, Bogotá', 'Empleado', 'evelyncarolina'),
(104234589, 'José Alberto', 'Castro Torres', 'jose.castro@gmail.com', true, 3008765432, 'Calle 56 #34-45, Bogotá', 'Empleado', 'josealberto'),
(107234594, 'Vera Patricia', 'Álvarez Guzmán', 'vera.alvarez@gmail.com', true, 3008765432, 'Calle 28 #45-56, Bogotá', 'Empleado', 'verapatricia'),
(52123456, 'Carlos Alberto', 'Ramírez Pérez', 'carlos.ramirez@gmail.com', true, 3102345678, 'Carrera 12 #45-67, Bogotá', 'Empleado', 'carlosalberto'),
(52187632, 'Lucía María', 'Gómez Martínez', 'lucia.gomez@gmail.com', true, 3109876543, 'Avenida 5 #23-45, Bogotá', 'Empleado', 'luciamaria'),
(52134589, 'Juan Pablo', 'Rodríguez Sánchez', 'juan.rodriguez@gmail.com', true, 3112345678, 'Calle 45 #67-89, Bogotá', 'Empleado', 'juanpablo'),
(52176321, 'María Fernanda', 'Hernández López', 'maria.hernandez@gmail.com', true, 3123456789, 'Carrera 7 #12-34, Bogotá', 'Empleado', 'mariafernanda'),
(5214590, 'Fernando Andrés', 'Martínez García', 'fernando.martinez@gmail.com', true, 3134567890, 'Calle 32 #54-76, Bogotá', 'Empleado', 'fernandoandres'),
(52123987, 'Isabel', 'Suárez Díaz', 'ana.suarez@gmail.com', true, 3145678901, 'Carrera 9 #13-45, Bogotá', 'Empleado', 'anaisabel'),
(52765432, 'Ricardo David', 'Jiménez Ríos', 'ricardo.jimenez@gmail.com', true, 3156789012, 'Avenida 30 #19-21, Bogotá', 'Empleado', 'ricardodavid'),
(52143210, 'Patricia Elena', 'Sánchez Díaz', 'patricia.sanchez@gmail.com', true, 3167890123, 'Calle 56 #78-89, Bogotá', 'Empleado', 'patriciaelena'),
(52189034, 'Carlos Eduardo', 'Mora García', 'carlos.mora@gmail.com', true, 3178901234, 'Carrera 60 #32-56, Bogotá', 'Empleado', 'carloseduardo'),
(52125679, 'Sofía Margarita', 'Torres Sánchez', 'sofia.torres@gmail.com', true, 3189012345, 'Calle 23 #65-89, Bogotá', 'Empleado', 'sofiamargarita'),
(21123678, 'Laura Fernanda', 'Pérez Gómez', 'laura.perez@gmail.com', true, 3198765432, 'Calle 10 #5-13, Bogotá', 'Empleado', 'laurafernanda'),
(21187432, 'Mauricio Andrés', 'Gutiérrez Ríos', 'mauricio.gutierrez@gmail.com', true, 3201234567, 'Carrera 24 #45-67, Bogotá', 'Empleado', 'mauricioandres'),
(21134789, 'Diana Carolina', 'Vega Lozano', 'diana.vega@gmail.com', true, 3212345678, 'Avenida 15 #67-89, Bogotá', 'Empleado', 'dianacarolina'),
(21176321, 'Eduardo', 'Sánchez Molina', 'carlos.sanchez@gmail.com', true, 3223456789, 'Calle 11 #34-12, Bogotá', 'Empleado', 'carloseduardo'),
(21147890, 'Marta Beatriz', 'Martínez Romero', 'marta.martinez@gmail.com', true, 3234567890, 'Carrera 8 #56-78, Bogotá', 'Empleado', 'martabeatriz');




-- Consulta basica
select * from Cliente;

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