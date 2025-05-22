drop database palacioDelTiempo1;
create database palacioDelTiempo1;
use palacioDelTiempo1;

create table Usuario(
	docUsuario int primary key,
	nombreUsuario varchar(20) not null,
	apellidoUsuario varchar(20) not null,
	correoUsuario varchar(50) not null,
	estadoUsuario bool not null,
	telefonoUsuario int unsigned not null,
	direccionUsuario varchar(100) not null,
	tipoUsuario enum('Administrador','Empleado') not null,
	nickname varchar(30) not null unique
);

create table Cliente(
    docCliente int primary key,
    nombreCliente varchar(20) not null,
    apellidoCliente varchar(20) not null,
    correoCliente varchar(30) not null,
    estadoCliente bool not null,
    telefonoCliente int unsigned not null,
    direccionCliente varchar(100) not null,
    tipoCliente enum('Natural','Juridico') not null
);

create table Producto(
    codigoProducto varchar(20) primary key,
    nombreProducto varchar(50) not null,
    precioProducto double not null, /*precio del producto por unidad*/
    descripcionProducto text null,
    cantidadProducto int not null, /*Indica la cantidad total del producto (Existencias)*/
    estadoProducto bool not null
);

create table Stock(
    codigoStock int auto_increment primary key,
    idProductoFK varchar(20) not null,
    cantidadDisponible int not null, /*Cantidad disponible del producto en el muetsrario*/
    estadoStock bool not null,
    foreign key (idProductoFK) references Producto(codigoProducto)
    on delete cascade on update cascade
);

create table facturaVenta(
    codigoFactura int auto_increment primary key,
    docUsuarioFK int not null,
    docClienteFK int not null,
    totalFactura double not null,
    iva double not null,
    fEntrega date not null,
    fReparto date not null,
    estadoPago enum ('Completado','Pendiente', 'Cancelado') not null,
    medioPago varchar(20) not null,
    direccionEnv varchar(100) not null,
    precioEnv double not null,
    descripcionFact text not null,
    estadoFactura bool not null,
    foreign key (docUsuarioFK) references Usuario(docUsuario) 
    on delete cascade on update cascade,
    foreign key (docClienteFK) references Cliente(docCliente) 
    on delete cascade on update cascade
);

create table DetallesFactura(
    idDetalle int auto_increment primary key,
    codigoFacturaFK int not null,
    codigoStockFK int not null,
    cantidadProd int not null,
    foreign key (codigoFacturaFK) references facturaVenta(codigoFactura) 
    on delete cascade on update cascade,
    foreign key (codigoStockFK) references Stock(codigoStock) 
    on delete cascade on update cascade
);

/*Insertar Usuarios*/
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
(112234598, 'Carlos Alberto', 'Martínez Pérez', 'carlos.martinez@hotmail.com', true, 3012345678, 'Calle 22 #11-23, Bogotá', 'Empleado', 'carlosalbertomar'),
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
(52123456, 'Carlos Alberto', 'Ramírez Pérez', 'carlos.ramirez@gmail.com', true, 3102345678, 'Carrera 12 #45-67, Bogotá', 'Empleado', 'carlosalbertoram'),
(52187632, 'Lucía María', 'Gómez Martínez', 'lucia.gomez@gmail.com', true, 3109876543, 'Avenida 5 #23-45, Bogotá', 'Empleado', 'luciamaria'),
(52134589, 'Juan Pablo', 'Rodríguez Sánchez', 'juan.rodriguez@gmail.com', true, 3112345678, 'Calle 45 #67-89, Bogotá', 'Empleado', 'juanpablo'),
(52176321, 'María Fernanda', 'Hernández López', 'maria.hernandez@gmail.com', true, 3123456789, 'Carrera 7 #12-34, Bogotá', 'Empleado', 'mariafernanda'),
(5214590, 'Fernando Andrés', 'Martínez García', 'fernando.martinez@gmail.com', true, 3134567890, 'Calle 32 #54-76, Bogotá', 'Empleado', 'fernandoandres'),
(52123987, 'Isabel', 'Suárez Díaz', 'ana.suarez@gmail.com', true, 3145678901, 'Carrera 9 #13-45, Bogotá', 'Empleado', 'anaisabel'),
(52765432, 'Ricardo David', 'Jiménez Ríos', 'ricardo.jimenez@gmail.com', true, 3156789012, 'Avenida 30 #19-21, Bogotá', 'Empleado', 'ricardodavid'),
(52143210, 'Patricia Elena', 'Sánchez Díaz', 'patricia.sanchez@gmail.com', true, 3167890123, 'Calle 56 #78-89, Bogotá', 'Empleado', 'patriciaelena'),
(52189034, 'Carlos Eduardo', 'Mora García', 'carlos.mora@gmail.com', true, 3178901234, 'Carrera 60 #32-56, Bogotá', 'Empleado', 'carloseduardomora'),
(52125679, 'Sofía Margarita', 'Torres Sánchez', 'sofia.torres@gmail.com', true, 3189012345, 'Calle 23 #65-89, Bogotá', 'Empleado', 'sofiamargarita'),
(21123678, 'Laura Fernanda', 'Pérez Gómez', 'laura.perez@gmail.com', true, 3198765432, 'Calle 10 #5-13, Bogotá', 'Empleado', 'laurafernanda'),
(21187432, 'Mauricio Andrés', 'Gutiérrez Ríos', 'mauricio.gutierrez@gmail.com', true, 3201234567, 'Carrera 24 #45-67, Bogotá', 'Empleado', 'mauricioandres'),
(21134789, 'Diana Carolina', 'Vega Lozano', 'diana.vega@gmail.com', true, 3212345678, 'Avenida 15 #67-89, Bogotá', 'Empleado', 'dianacarolina'),
(21176321, 'Eduardo', 'Sánchez Molina', 'carlos.sanchez@gmail.com', true, 3223456789, 'Calle 11 #34-12, Bogotá', 'Empleado', 'carloseduardosanchez'),
(21147890, 'Marta Beatriz', 'Martínez Romero', 'marta.martinez@gmail.com', true, 3234567890, 'Carrera 8 #56-78, Bogotá', 'Empleado', 'martabeatriz');

alter table usuario add column  password varchar(25);
update Usuario set password = concat(nickname, cast(docUsuario as char));

/*Insertar Clientes*/
insert into Cliente values
(1114488229, 'Sara', 'Cifuentes','saracifuentes@hotmail.com',true,3005643894,'Avenida Jimenez #45-23a','Natural'),
(1023456781, 'Luis', 'Martinez', 'luismartinez@gmail.com', true, 3102345678, 'Calle 12 #34-56', 'Natural'),
(1023456782, 'Ana', 'Rodriguez', 'anarodriguez@yahoo.com', false, 3208765432, 'Carrera 45 #23-19', 'Juridico'),
(1023456783, 'Carlos', 'Gomez', 'carlosgomez@gmail.com', true, 3011234567, 'Diagonal 20 #18-90', 'Natural'),
(1023456784, 'Lucia', 'Perez', 'luciaperez@hotmail.com', true, 3022345678, 'Transversal 10 #33-22', 'Natural'),
(1023456785, 'Jorge', 'Ramirez', 'jorgeramirez@outlook.com', false, 3109988776, 'Avenida 1 #24-33', 'Juridico'),
(1023456786, 'Camila', 'Ruiz', 'camilaruiz@gmail.com', true, 3152233445, 'Calle 9 #76-34', 'Natural'),
(1023456787, 'Felipe', 'Mora', 'felipemora@yahoo.com', true, 3205556677, 'Carrera 100 #45-67', 'Juridico'),
(1023456788, 'Diana', 'Lopez', 'dianalopez@gmail.com', true, 3123344556, 'Calle 32 #55-21', 'Natural'),
(1023456789, 'Mario', 'Diaz', 'mariodiaz@outlook.com', false, 3112233445, 'Carrera 66 #34-11', 'Natural'),
(1023456790, 'Paula', 'Nieto', 'paulanieto@gmail.com', true, 3167788990, 'Calle 25 #10-44', 'Juridico'),
(1023456791, 'Juan', 'Vargas', 'juanvargas@hotmail.com', true, 3144455667, 'Diagonal 99 #88-12', 'Natural'),
(1023456792, 'Valeria', 'Castro', 'valeriacastro@yahoo.com', false, 3101122334, 'Calle 15 #17-19', 'Natural'),
(1023456793, 'Andres', 'Soto', 'andressoto@gmail.com', true, 3135566778, 'Carrera 22 #34-55', 'Juridico'),
(1023456794, 'Isabela', 'Medina', 'isabelamedina@hotmail.com', true, 3056677889, 'Calle 78 #12-88', 'Natural'),
(1023456795, 'Oscar', 'Torres', 'oscartorres@yahoo.com', false, 3004455667, 'Carrera 7 #89-76', 'Natural'),
(1023456796, 'Laura', 'Reyes', 'laurareyes@gmail.com', true, 3173344556, 'Transversal 15 #23-45', 'Juridico'),
(1023456797, 'Diego', 'Cano', 'diegocano@hotmail.com', true, 3122233441, 'Calle 60 #45-32', 'Natural'),
(1023456798, 'Natalia', 'Guerrero', 'nataliaguerrero@gmail.com', false, 3189988776, 'Carrera 12 #34-56', 'Natural'),
(1023456799, 'Sebastian', 'Ortega', 'sebastianortega@yahoo.com', true, 3195566778, 'Avenida 5 #10-11', 'Juridico'),
(1023456800, 'Monica', 'Silva', 'monicasilva@gmail.com', true, 3163344556, 'Calle 3 #45-67', 'Natural'),
(1023456801, 'Ricardo', 'Herrera', 'ricardoherrera@hotmail.com', false, 3031234567, 'Carrera 40 #23-45', 'Natural'),
(1023456802, 'Juliana', 'Mejia', 'julianamejia@yahoo.com', true, 3054455667, 'Calle 18 #56-78', 'Juridico'),
(1023456803, 'Esteban', 'Navarro', 'estebannavarro@gmail.com', true, 3077788990, 'Diagonal 13 #99-12', 'Natural'),
(1023456804, 'Melany', 'Castaño', 'melanycastano@hotmail.com', false, 3016677889, 'Carrera 90 #12-34', 'Natural'),
(1023456805, 'Tomás', 'Arango', 'tomasarango@yahoo.com', true, 3129988776, 'Transversal 1 #22-33', 'Natural'),
(1023456806, 'Mariana', 'Espinosa', 'marianaespinosa@gmail.com', true, 3092233445, 'Avenida 3 #44-55', 'Juridico'),
(1023456807, 'Hugo', 'Valencia', 'hugovalencia@outlook.com', false, 3137788990, 'Calle 47 #23-98', 'Natural'),
(1023456808, 'Viviana', 'Quintero', 'vivianaquintero@gmail.com', true, 3084455667, 'Carrera 19 #34-77', 'Juridico'),
(1023456809, 'Samuel', 'Montoya', 'samuelmontoya@yahoo.com', true, 3116677889, 'Calle 80 #12-90', 'Natural'),
(1023456810, 'Daniela', 'Cortes', 'danielacortes@hotmail.com', false, 3183344556, 'Carrera 15 #55-66', 'Natural'),
(1023456811, 'Gabriel', 'Acosta', 'gabrielacosta@gmail.com', true, 3205566778, 'Calle 22 #34-12', 'Juridico'),
(1023456812, 'Nicole', 'Salazar', 'nicolesalazar@yahoo.com', true, 3156677889, 'Carrera 27 #10-98', 'Natural'),
(1023456813, 'Eduardo', 'Moreno', 'eduardomoreno@gmail.com', false, 3091122334, 'Diagonal 70 #88-12', 'Natural'),
(1023456814, 'Angela', 'Paredes', 'angelaparedes@hotmail.com', true, 3123344555, 'Calle 5 #17-89', 'Juridico'),
(1023456815, 'Javier', 'Guerra', 'javierguerra@yahoo.com', true, 3149988776, 'Carrera 50 #34-56', 'Natural'),
(1023456816, 'Renata', 'Zapata', 'renatazapata@gmail.com', false, 3065566778, 'Transversal 9 #12-34', 'Natural'),
(1023456817, 'Mateo', 'Luna', 'mateoluna@hotmail.com', true, 3176677889, 'Avenida 8 #90-22', 'Natural'),
(1023456818, 'Carolina', 'Lemos', 'carolinalemos@gmail.com', true, 3087788990, 'Carrera 11 #45-88', 'Juridico'),
(1023456819, 'Alejandro', 'Cabrera', 'alejandrocabrera@yahoo.com', false, 3104455667, 'Calle 33 #76-22', 'Natural'),
(1023456820, 'Luisa', 'Villalba', 'luisavillalba@gmail.com', true, 3113344556, 'Carrera 60 #23-41', 'Natural'),
(1023456821, 'Brayan', 'Campos', 'brayancampos@hotmail.com', true, 3071122334, 'Avenida Sur #13-34', 'Juridico'),
(1023456822, 'Tatiana', 'Escobar', 'tatianaescobar@gmail.com', false, 3127788990, 'Calle 89 #55-11', 'Natural'),
(1023456823, 'Kevin', 'Bermudez', 'kevinbermudez@yahoo.com', true, 3096677889, 'Carrera 5 #23-33', 'Natural'),
(1023456824, 'Sara', 'Leon', 'saraleon@gmail.com', true, 3055566778, 'Transversal 4 #21-43', 'Juridico'),
(1023456825, 'Manuel', 'Peña', 'manuelpena@hotmail.com', false, 3023344556, 'Calle 13 #77-88', 'Natural'),
(1023456826, 'Adriana', 'Rojas', 'adrianarojas@gmail.com', true, 3182233445, 'Carrera 39 #45-90', 'Natural'),
(1023456827, 'Camilo', 'Velasquez', 'camilovelasquez@yahoo.com', true, 3049988776, 'Diagonal 17 #34-66', 'Juridico'),
(1023456828, 'Daniel', 'Barrera', 'danielbarrera@gmail.com', false, 3036677889, 'Calle 99 #12-45', 'Natural'),
(1023456829, 'María', 'Gil', 'mariagil@hotmail.com', true, 3153344556, 'Carrera 18 #56-12', 'Natural'),
(1023456830, 'Santiago', 'Lara', 'santiagolara@yahoo.com', true, 3015566778, 'Avenida 10 #44-77', 'Juridico');

/*Insertar Productos*/
insert into producto values ('P1', 'THOM GAFAS DE SOL迪特眼镜', 26057.16, 'Gafas de sol', 50, true),
('P2', 'BOLSAS RAYBAN', 10067.92, 'estuche', 40, true),
('P3', 'RELOJ CASIO MTP-V002', 149000, 'Reloj análogo para hombre, resistente al agua', 60, true),
('P4', 'RELOJ TIMEX WEEKENDER', 199900, 'Reloj casual con correa intercambiable', 30, true),
('P5', 'RELOJ SEIKO 5 SPORTS', 950000, 'Reloj automático con correa de acero', 20, true),
('P6', 'CAJA RELOJ LUJO', 45900, 'Caja de presentación para reloj, acolchada', 80, true),
('P7', 'CORREA CUERO NEGRO', 32000, 'Correa ajustable de cuero genuino', 100, true),
('P8', 'CORREA SILICONA AZUL', 25000, 'Correa deportiva para reloj', 95, true),
('P9', 'RELOJ CITIZEN ECO-DRIVE', 1200000, 'Reloj solar sin necesidad de batería', 15, true),
('P10', 'RELOJ ORIENT CLASSIC', 790000, 'Reloj automático elegante para hombre', 25, true),
('P11', 'RELOJ DIESEL DZ4323', 850000, 'Reloj cronógrafo para hombre', 30, true),
('P12', 'RELOJ FOSSIL CH2565', 680000, 'Reloj deportivo de cuero', 45, true),
('P13', 'RELOJ SKAGEN ANITA', 470000, 'Reloj minimalista para mujer', 60, true),
('P14', 'RELOJ MVMT CLASSIC', 520000, 'Reloj moderno con diseño limpio', 40, true),
('P15', 'RELOJ TOMMY HILFIGER', 650000, 'Reloj con cronógrafo y correa de acero', 35, true),
('P16', 'RELOJ GUESS GW0030L2', 570000, 'Reloj de moda para mujer', 38, true),
('P17', 'RELOJ HUGO BOSS', 899000, 'Reloj elegante para eventos formales', 27, true),
('P18', 'RELOJ ARMANI EXCHANGE', 770000, 'Reloj juvenil y urbano', 32, true),
('P19', 'RELOJ MICHAEL KORS', 720000, 'Reloj de lujo para mujer', 20, true),
('P20', 'GAFAS POLARIZADAS RAYBAN', 180000, 'Protección UV y estilo', 55, true),
('P21', 'ESTUCHE DUAL WATCH', 35000, 'Estuche para guardar dos relojes', 65, true),
('P22', 'KIT LIMPIEZA RELOJES', 22000, 'Herramientas y paño de limpieza', 90, true),
('P23', 'RELOJ SMARTWATCH AMAZFIT', 430000, 'Reloj inteligente con monitor de actividad', 42, true),
('P24', 'RELOJ XIAOMI MI BAND 6', 180000, 'Pulsera inteligente con pantalla AMOLED', 88, true),
('P25', 'RELOJ APPLE WATCH SE', 1500000, 'Smartwatch con GPS y sensor cardíaco', 22, true),
('P26', 'CORREA DE MALLA METÁLICA', 42000, 'Correa de acero inoxidable tipo milanesa', 70, true),
('P27', 'CAJA RELOJES MADERA NOGAL', 89000, 'Caja elegante para 6 relojes', 33, true),
('P28', 'RELOJ BULOVA MOONWATCH', 1550000, 'Edición especial cronógrafo lunar', 12, true),
('P29', 'RELOJ INVICTA PRO DIVER', 410000, 'Reloj de buceo resistente al agua', 28, true),
('P30', 'RELOJ LUMINOX NAVY SEAL', 1300000, 'Reloj táctico militar', 10, true),
('P31', 'RELOJ VOSTOK AMPHIBIA', 350000, 'Reloj automático ruso de buceo', 18, true),
('P32', 'RELOJ TISSOT PRX', 1190000, 'Diseño clásico con movimiento suizo', 24, true),
('P33', 'RELOJ SWATCH ORIGINAL', 290000, 'Reloj colorido con diseño pop', 37, true),
('P34', 'RELOJ CASIO G-SHOCK', 670000, 'Reloj resistente a golpes y agua', 48, true),
('P35', 'RELOJ CASIO VINTAGE', 115000, 'Reloj digital retro', 61, true),
('P36', 'RELOJ CALVIN KLEIN', 740000.00, 'Diseño minimalista para mujer', 23, true),
('P37', 'RELOJ DANIEL WELLINGTON', 490000, 'Reloj clásico con correa de tela', 52, true),
('P38', 'RELOJ ROLEX SUBMARINER', 50000000, 'Reloj de lujo para coleccionistas', 5, true),
('P39', 'RELOJ TAG HEUER CARRERA', 12400000, 'Cronógrafo suizo de alta gama', 7, true),
('P40', 'RELOJ HAMILTON KHAKI FIELD', 860000, 'Reloj militar con diseño clásico', 19, true),
('P41', 'RELOJ GARMIN FORERUNNER', 1350000, 'Smartwatch para deportistas', 26, true),
('P42', 'RELOJ POLAR VANTAGE M', 999000, 'Reloj deportivo con GPS integrado', 29, true),
('P43', 'RELOJ SUUNTO CORE', 1100000, 'Reloj outdoor con altímetro y barómetro', 14, true),
('P44', 'RELOJ LORUS SPORTS', 320000, 'Reloj resistente para uso diario', 36, true),
('P45', 'RELOJ FESTINA CHRONO', 540000, 'Reloj de cronómetro elegante', 31, true),
('P46', 'RELOJ LOTUS URBAN CLASSIC', 360000, 'Diseño moderno y sofisticado', 17, true),
('P47', 'RELOJ PUMA PU102871002', 275000, 'Reloj deportivo con correa de caucho', 43, true),
('P48', 'RELOJ BEN SHERMAN', 190000, 'Diseño clásico con correa textil', 49, true),
('P49', 'RELOJ ZADIG & VOLTAIRE', 310000, 'Diseño moderno para mujer', 39, true),
('P50', 'RELOJ EMPORIO ARMANI', 950000, 'Elegante y refinado para ocasiones especiales', 21, true),
('P51', 'CORREA NATO ROJA', 28000, 'Correa de tela resistente para relojes deportivos', 77, true),
('P52', 'RELOJ CASIO EDIFICE', 620000, 'Reloj elegante con cronómetro y correa metálica', 41, true),
('P53', 'ESTUCHE PREMIUM MADERA', 97000, 'Estuche para colección de relojes con vidrio frontal', 66, true),
('P54', 'KIT HERRAMIENTAS RELOJERO', 56000, 'Incluye destornilladores, pinzas y herramientas para ajuste', 92, true),
('P55', 'GAFAS AVIADOR CLÁSICAS', 138000, 'Gafas con montura metálica estilo aviador', 53, true),
('P56', 'RELOJ DIESEL RASP', 790000, 'Diseño moderno y robusto para uso diario', 34, true),
('P57', 'CAJA RELOJES VIAJE', 45000, 'Estuche acolchado portátil para viajes', 67, true),
('P58', 'CORREA PIEL MARRÓN', 35000, 'Correa de piel natural con hebilla clásica', 87, true),
('P59', 'RELOJ SKAGEN HAGEN', 410000, 'Diseño delgado y minimalista con correa de malla', 58, true);

/*Insertar Stock*/
insert into Stock values
('','P1',10,true),
('', 'P2', 7, true),
('', 'P3', 12, true),
('', 'P4', 5, true),
('', 'P5', 3, true),
('', 'P6', 15, true),
('', 'P7', 20, true),
('', 'P8', 18, true),
('', 'P9', 4, true),
('', 'P10', 6, true),
('', 'P11', 7, true),
('', 'P12', 11, true),
('', 'P13', 9, true),
('', 'P14', 8, true),
('', 'P15', 10, true),
('', 'P16', 5, true),
('', 'P17', 6, true),
('', 'P18', 7, true),
('', 'P19', 4, true),
('', 'P20', 12, true),
('', 'P21', 13, true),
('', 'P22', 14, true),
('', 'P23', 9, true),
('', 'P24', 17, true),
('', 'P25', 3, true),
('', 'P26', 16, true),
('', 'P27', 7, true),
('', 'P28', 2, true),
('', 'P29', 6, true),
('', 'P30', 2, true),
('', 'P31', 4, true),
('', 'P32', 5, true),
('', 'P33', 9, true),
('', 'P34', 11, true),
('', 'P35', 10, true),
('', 'P36', 3, true),
('', 'P37', 12, true),
('', 'P38', 1, true),
('', 'P39', 1, true),
('', 'P40', 4, true),
('', 'P41', 5, true),
('', 'P42', 6, true),
('', 'P43', 2, true),
('', 'P44', 8, true),
('', 'P45', 5, true),
('', 'P46', 4, true),
('', 'P47', 7, true),
('', 'P48', 9, true),
('', 'P49', 8, true),
('', 'P50', 6, true),
('', 'P51', 13, true),
('', 'P52', 7, true),
('', 'P53', 10, true),
('', 'P54', 12, true),
('', 'P55', 14, true),
('', 'P56', 6, true),
('', 'P57', 9, true),
('', 'P58', 13, true),
('', 'P59', 8, true);

/*Insertar factura venta*/
insert into facturaVenta (docUsuarioFK, docClienteFK, fEntrega, fReparto, estadoPago, medioPago, direccionEnv, precioEnv, descripcionFact, estadoFactura) values
(981234585,1114488229,'2025-11-31','2025-12-02','Completado','Tranferencia','Calle 89 #55-11',5000,'Sin detalles adicionales',true),
(901234585, 1023456781, '2025-12-05', '2025-12-07', 'Pendiente', 'Efectivo', 'Calle 60 #32-21', 7000, 'Sin detalles adicionales', true),
(109234595, 1023456782, '2025-12-10', '2025-12-12', 'Cancelado', 'Nequi', 'Avenida 15 #72-10', 4500, 'Sin detalles adicionales', true),
(881234575, 1023456783, '2025-11-25', '2025-11-27', 'Completado', 'Transferencia', 'Carrera 42 #89-12', 6000, 'Sin detalles adicionales', true),
(931234580, 1023456784, '2025-12-01', '2025-12-03', 'Pendiente', 'Daviplata', 'Calle 98 #44-56', 8000, 'Sin detalles adicionales', true),
(105234591, 1023456785, '2025-12-15', '2025-12-17', 'Completado', 'Tarjeta', 'Calle 89 #12-45', 9000, 'Sin detalles adicionales', true),
(107234593, 1023456786, '2025-12-03', '2025-12-05', 'Completado', 'Nequi', 'Carrera 21 #34-56', 5500, 'Sin detalles adicionales', true),
(119234605, 1023456787, '2025-12-20', '2025-12-22', 'Cancelado', 'Efectivo', 'Avenida 33 #24-10', 7000, 'Sin detalles adicionales', true),
(114234600, 1023456788, '2025-12-04', '2025-12-06', 'Completado', 'Transferencia', 'Calle 77 #11-22', 12000, 'Sin detalles adicionales', true),
(921234579, 1023456789, '2025-12-10', '2025-12-12', 'Pendiente', 'Daviplata', 'Carrera 15 #44-22', 3000, 'Sin detalles adicionales', true),
(116234602, 1023456790, '2025-12-01', '2025-12-03', 'Completado', 'Tarjeta', 'Avenida 90 #21-14', 11000, 'Sin detalles adicionales', true),
(111234597, 1023456791, '2025-11-29', '2025-12-01', 'Cancelado', 'Nequi', 'Calle 10 #45-76', 9500, 'Sin detalles adicionales', true),
(861234573, 1023456792, '2025-12-10', '2025-12-12', 'Completado', 'Transferencia', 'Avenida 55 #65-21', 8000, 'Sin detalles adicionales', true),
(971234584, 1023456793, '2025-11-25', '2025-11-27', 'Pendiente', 'Efectivo', 'Carrera 12 #12-21', 6500, 'Sin detalles adicionales', true),
(110234596, 1023456794, '2025-12-05', '2025-12-07', 'Completado', 'Daviplata', 'Calle 66 #33-23', 7500, 'Sin detalles adicionales', true),
(104234590, 1023456795, '2025-12-12', '2025-12-14', 'Pendiente', 'Nequi', 'Avenida 90 #12-56', 8500, 'Sin detalles adicionales', true),
(971234583, 1023456796, '2025-12-06', '2025-12-08', 'Completado', 'Transferencia', 'Calle 34 #55-13', 4000, 'Sin detalles adicionales', true),
(761234567, 1023456797, '2025-12-15', '2025-12-17', 'Cancelado', 'Tarjeta', 'Avenida 55 #78-23', 4500, 'Sin detalles adicionales', true),
(821234570, 1023456798, '2025-12-01', '2025-12-03', 'Completado', 'Nequi', 'Calle 85 #98-67', 5000, 'Sin detalles adicionales', true),
(101234587, 1023456799, '2025-11-30', '2025-12-02', 'Pendiente', 'Efectivo', 'Carrera 44 #12-34', 5500, 'Sin detalles adicionales', true),
(113234599, 1023456800, '2025-12-10', '2025-12-12', 'Completado', 'Transferencia', 'Avenida 33 #12-55', 15000, 'Sin detalles adicionales', true),
(951234582, 1023456801, '2025-12-03', '2025-12-05', 'Completado', 'Tarjeta', 'Calle 72 #34-45', 13000, 'Sin detalles adicionales', true),
(871234574, 1023456802, '2025-12-07', '2025-12-09', 'Cancelado', 'Daviplata', 'Carrera 18 #43-22', 4000, 'Sin detalles adicionales', true),
(901234577, 1023456803, '2025-11-27', '2025-11-29', 'Pendiente', 'Nequi', 'Calle 11 #54-65', 6200, 'Sin detalles adicionales', true),
(931234581, 1023456804, '2025-12-12', '2025-12-14', 'Completado', 'Transferencia', 'Avenida 66 #45-34', 5300, 'Sin detalles adicionales', true),
(112234598, 1023456805, '2025-12-08', '2025-12-10', 'Completado', 'Efectivo', 'Calle 99 #56-12', 7500, 'Sin detalles adicionales', true),
(932234580, 1023456806, '2025-11-30', '2025-12-02', 'Pendiente', 'Tarjeta', 'Avenida 22 #77-23', 4700, 'Sin detalles adicionales', true),
(932234586, 1023456807, '2025-12-03', '2025-12-05', 'Completado', 'Nequi', 'Calle 11 #44-12', 6200, 'Sin detalles adicionales', true),
(951234585, 1023456808, '2025-12-14', '2025-12-16', 'Cancelado', 'Transferencia', 'Avenida 45 #11-22', 4300, 'Sin detalles adicionales', true),
(102234589, 1023456809, '2025-12-06', '2025-12-08', 'Pendiente', 'Daviplata', 'Carrera 21 #34-56', 5400, 'Sin detalles adicionales', true),
(104234588, 1023456810, '2025-12-12', '2025-12-14', 'Completado', 'Efectivo', 'Calle 21 #45-33', 6500, 'Sin detalles adicionales', true),
(981234586, 1023456811, '2025-11-28', '2025-11-30', 'Completado', 'Nequi', 'Calle 22 #11-12', 5900, 'Sin detalles adicionales', true),
(100123457, 1023456812, '2025-12-09', '2025-12-11', 'Pendiente', 'Transferencia', 'Avenida 55 #44-33', 5200, 'Sin detalles adicionales', true),
(109234596, 1023456813, '2025-12-04', '2025-12-06', 'Completado', 'Tarjeta', 'Calle 44 #12-10', 4500, 'Sin detalles adicionales', true),
(931234582, 1023456814, '2025-12-11', '2025-12-13', 'Completado', 'Efectivo', 'Carrera 66 #55-88', 6800, 'Sin detalles adicionales', true),
(104234589, 1023456815, '2025-11-27', '2025-11-29', 'Pendiente', 'Nequi', 'Calle 78 #34-12', 5600, 'Sin detalles adicionales', true),
(107234594, 1023456816, '2025-12-01', '2025-12-03', 'Cancelado', 'Transferencia', 'Carrera 12 #99-34', 7200, 'Sin detalles adicionales', true),
(52123456, 1023456817, '2025-11-30', '2025-12-02', 'Completado', 'Daviplata', 'Calle 32 #45-21', 5100, 'Sin detalles adicionales', true),
(52187632, 1023456818, '2025-12-05', '2025-12-07', 'Pendiente', 'Tarjeta', 'Avenida 23 #54-76', 6200, 'Sin detalles adicionales', true),
(52134589, 1023456819, '2025-12-12', '2025-12-14', 'Completado', 'Nequi', 'Calle 90 #11-45', 4700, 'Sin detalles adicionales', true),
(52176321, 1023456820, '2025-11-28', '2025-11-30', 'Pendiente', 'Transferencia', 'Carrera 65 #43-12', 5400, 'Sin detalles adicionales', true),
(5214590, 1023456821, '2025-12-10', '2025-12-12', 'Completado', 'Daviplata', 'Calle 12 #55-67', 6000, 'Sin detalles adicionales', true),
(52123987, 1023456822, '2025-12-14', '2025-12-16', 'Pendiente', 'Tarjeta', 'Calle 30 #12-99', 5300, 'Sin detalles adicionales', true),
(104234590, 1023456823, '2025-12-10', '2025-12-12', 'Completado', 'Transferencia', 'Calle 44 #99-55', 5200, 'Sin detalles adicionales', true),
(971234584, 1023456824, '2025-12-06', '2025-12-08', 'Pendiente', 'Efectivo', 'Avenida 23 #12-89', 4300, 'Sin detalles adicionales', true),
(110234596, 1023456825, '2025-12-03', '2025-12-05', 'Cancelado', 'Daviplata', 'Carrera 15 #21-78', 4800, 'Sin detalles adicionales', true),
(104234588, 1023456826, '2025-12-12', '2025-12-14', 'Completado', 'Tarjeta', 'Calle 56 #33-44', 7200, 'Sin detalles adicionales', true),
(981234586, 1023456827, '2025-11-28', '2025-11-30', 'Pendiente', 'Nequi', 'Calle 33 #44-12', 5000, 'Sin detalles adicionales', true),
(100123457, 1023456828, '2025-12-09', '2025-12-11', 'Completado', 'Transferencia', 'Avenida 66 #54-21', 6500, 'Sin detalles adicionales', true),
(109234596, 1023456829, '2025-12-01', '2025-12-03', 'Completado', 'Efectivo', 'Calle 45 #77-99', 5300, 'Sin detalles adicionales', true),
(931234581, 1023456830, '2025-12-10', '2025-12-12', 'Pendiente', 'Daviplata', 'Avenida 80 #55-33', 6100, 'Sin detalles adicionales', true);

/*Disparador que actualiza el total y el iva de un factura cade que se agreguen productos ----- RQF*/
DELIMITER //
create trigger actualizar_total
after insert on DetallesFactura
for each row
begin
    declare totalFactura DECIMAL(10, 2);
    declare ivaFactura DECIMAL(10, 2);
    
    -- Calcular el total de la factura
    select SUM(P.precioProducto * D.cantidadProd) into totalFactura
    from DetallesFactura D
    join Stock S on D.codigoStockFK = S.codigoStock
    join Producto P on S.idProductoFK = P.codigoProducto
    where D.codigoFacturaFK = new.codigoFacturaFK
    group by D.codigoFacturaFK;
    
    -- Calcular el IVA (asumiendo un 19% de IVA)
    set ivaFactura = totalFactura * 0.19;
    
    -- Actualizar la factura con el nuevo total y IVA
    update facturaVenta
    set totalFactura = totalFactura, iva = ivaFactura
    where codigoFactura = new.codigoFacturaFK;
end //
DELIMITER ;


/*Disparador para disminuir el stock ------- RQF*/
DELIMITER //
create trigger disminuirStock
after insert on DetallesFactura
for each row
begin
    update Stock
    set cantidadDisponible = cantidadDisponible - new.cantidadProd
    where codigoStock = new.codigoStockFK;
end;
//
DELIMITER ;

/*Disparador para reponer el stock ---------RQF*/
DELIMITER //
create trigger reponerStockSiSeAgota
after insert on DetallesFactura
for each row
begin
    declare stock_actual int;
    declare cantidad_total int;
    declare producto_id varchar(20);

    -- Obtener el ID del producto correspondiente
    select idProductoFK into producto_id
    from Stock
    where codigoStock = new.codigoStockFK;

    -- Obtener la cantidad disponible de stock actual
    select cantidadDisponible into stock_actual
    from Stock
    where codigoStock = new.codigoStockFK;

    -- Obtener la cantidad total del producto en inventario general
    select cantidadProducto into cantidad_total
    from Producto
    where codigoProducto = producto_id;

    -- Verificar si el stock se agotó y hay suficiente inventario general
    if stock_actual = 0 and cantidad_total >= 5 then
        -- Reponer 5 unidades al stock
        update Stock
        set cantidadDisponible = cantidadDisponible + 5
        where codigoStock = new.codigoStockFK;

        -- Descontar 5 unidades del inventario general del producto
        update Producto
        set cantidadProducto = cantidadProducto - 5
        where codigoProducto = producto_id;
    end if;
end //
DELIMITER ;

/*Insertar detalles factura*/
insert into DetallesFactura (codigoFacturaFK,codigoStockFK,cantidadProd) values
(1,2,2),(1,1,2),(1,4,1);

insert into DetallesFactura (codigoFacturaFK,codigoStockFK,cantidadProd) values
(2, 1, 2),(2, 3, 1),(2, 5, 2),
(3, 2, 3),(3, 4, 1),(3, 6, 1),
(4, 3, 2),(4, 4, 1),(4, 5, 1),
(5, 2, 2),(5, 3, 1),(5, 4, 3),(5, 5, 1),
(6, 1, 3),(6, 2, 1),(6, 4, 2),
(7, 5, 2),(7, 9, 1),(7, 14, 2),
(8, 7, 3),(8, 13, 1),
(9, 12, 2),(9, 18, 1),
(10, 6, 1),(10, 22, 2),
(11, 10, 1),(11, 15, 1),(11, 25, 2),
(12, 4, 3),
(13, 8, 2),(13, 19, 1),
(14, 3, 1),(14, 20, 2),(14, 23, 1),
(15, 1, 2),(15, 11, 1),
(16, 2, 2),(16, 26, 1),
(17, 16, 1),(17, 5, 2),
(18, 17, 2),
(19, 21, 1),(19, 7, 1),(19, 13, 1),
(20, 6, 2),(20, 14, 2),(20, 28, 1),
(21, 5, 2),(21, 12, 1),(21, 18, 1),
(22, 7, 3),
(23, 8, 2),(23, 16, 2),
(24, 9, 1),(24, 20, 1),(24, 21, 1),
(25, 13, 2),
(26, 10, 3),(26, 14, 2),(26, 25, 1),
(27, 2, 1),(27, 59, 2),
(28, 6, 2),(28, 11, 2),
(29, 1, 2),(29, 4, 1),
(30, 17, 1),(30, 19, 1),(30, 23, 2),
(31, 3, 2), (31, 14, 1),(31, 27, 2),
(32, 5, 3),
(33, 12, 1),(33, 29, 2),(33, 31, 1),
(34, 7, 1),(34, 18, 1),(34, 22, 2),(34, 33, 1),
(35, 2, 2),
(36, 6, 3),(36, 10, 2),
(37, 1, 1),(37, 24, 2),(37, 35, 1),
(38, 13, 1),(38, 9, 2),
(39, 4, 2),(39, 20, 1),(39, 26, 1),
(40, 15, 1),(40, 16, 2),(40, 28, 2),(40, 39, 1),
(41, 8, 2), (41, 17, 1), (41, 33, 2),
(42, 11, 3), (42, 23, 1),
(43, 6, 2),(43, 28, 2),(43, 30, 1),
(44, 19, 2),(44, 25, 2),(44, 41, 1),
(45, 4, 1),(45, 12, 1),(45, 36, 2),
(46, 9, 2),(46, 20, 1),(46, 44, 2),
(47, 10, 1),(47, 24, 2),(47, 38, 1),(47, 49, 1),
(48, 14, 2),(48, 27, 2),
(49, 5, 1),(49, 22, 2),(49, 31, 1),
(50, 16, 2),(50, 35, 1),
(51, 1, 2),(51, 7, 1),(51, 18, 2),(51, 43, 1);

/*Consultas Básicas*/

select * from Cliente;
SELECT * FROM detallesfactura;
SELECT * FROM facturaVenta;
SELECT * FROM producto;
SELECT * FROM Stock;
SELECT * FROM Usuario;

/*VISTAS*/

/*Vista Para visualizar las Facturas --------RQF*/
create view Factura as
select 
    codigoFactura as Codigo,
    docUsuarioFK as Documento_Usuario,
    docClienteFK as Documento_Cliente,
    totalFactura as Subtotal,
    iva as IVA,
    (totalFactura + iva) as Total,
    fEntrega as Fecha_Entrega,
    fReparto as Fecha_Reparto,
    estadoPago as Estado_Pago,
    medioPago as Medio_Pago,
    direccionEnv as Direccion_Envio,
    precioEnv as Precio_Envio,
    descripcionFact as Descripcion,
    estadoFactura as Estado_Factura
from 
    facturaVenta;
    
SELECT * FROM Factura;
desc facturaventa;

		-- Vista de clientes con total de compras
create view vista_TotalComprasCliente as
select c.docCliente, c.nombreCliente, c.apellidoCliente, SUM(f.totalFactura) as TotalCompras
from Cliente c join facturaVenta f on c.docCliente = f.docClienteFK
group by c.docCliente, c.nombreCliente, c.apellidoCliente;

select * from vista_TotalComprasCliente;

		-- Productos con stock disponible
create view vista_productosconstock as
select codigoproducto, nombreproducto, cantidaddisponible from producto
join stock on producto.codigoproducto = stock.idproductofk where stock.cantidaddisponible > 0;
select * from vista_productosconstock;

		-- Facturas pendientes de pago
create view vista_facturaspendientes as
select codigofactura, nombrecliente, totalfactura, fechavencimiento from facturaventa
join venta on facturaventa.codigoventafk = venta.codigoventa join cliente on venta.docclientefk = cliente.doccliente
where facturaventa.estadopago = 'pendiente';
select * from vista_facturaspendientes;

		-- Detalles de factura con subtotal
create view vista_detallesfacturaextendida as
select codigofactura, nombreproducto, cantidadprod, preciounitario, (cantidadprod * preciounitario) as 'subtotal'
from detallesfactura join producto on detallesfactura.codigoproductofk = producto.codigoproducto
join facturaventa on detallesfactura.codigofacturafk = facturaventa.codigofactura;
select * from vista_detallesfacturaextendida;

		-- Usuarios activos
create view vista_usuariosactivos as
select docusuario, nombreusuario, apellidousuario, correousuario, tipousuario from usuario
where estadousuario = true;
select * from vista_usuariosactivos;

# Vista que muestra usuarios de tipo administrador
create view vistaAdministradores as 
select docUsuario, nombreUsuario, apellidoUsuario, nickname
from Usuario where tipoUsuario = 'Administrador';

# Vista que muesta a los usuarios de tipo empleado activos
create view vistaEmpleadosActivos as select docUsuario, nombreUsuario, 
apellidoUsuario, correoUsuario, telefonoUsuario, nickname
from Usuario where estadoUsuario = true and tipoUsuario = 'Empleado';

/* CONSULTAS */

/*RQF002 ---- Consultar productos en stock*/
select codigoproducto,nombreproducto, descripcionproducto,stock.cantidaddisponible, estadoproducto,
estadostock from producto join stock on producto.codigoproducto = stock.idproductofk
where stock.cantidaddisponible > 0 and stock.estadostock = true;

/* POCEDIMIENTOS */

/*Procedimiento que inactiva un usuario dado su documento ------RQF*/
DELIMITER //
create procedure inactivarUsuario(in docUs int)
Begin
	Update Usuario set estadoUsuario = false where docUsuario = docUs;
end//
DELIMITER ;
call inactivarUsuario(20147890);


/*Buscar producto por palabra clave*/
DELIMITER  // 
CREATE PROCEDURE buscarProductoPalabra(in p_palabraClave varchar(20))
BEGIN

select * from producto
where descripcionProducto like concat('%', p_palabraClave, '%' ); -- metodo CONCAT: concatenar sibolos (strings) con variables dentro de un metodo
END //
DELIMITER ;

call buscarProductoPalabra('moderno');

/*Filtrar por precio los productos, de manera descendente */

select * from producto 
order by precioProducto desc limit 10;
