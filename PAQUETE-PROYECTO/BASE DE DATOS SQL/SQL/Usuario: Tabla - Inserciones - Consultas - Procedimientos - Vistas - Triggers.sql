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

#Consulta básica
describe Usuario;
select estadoUsuario from Usuario;

#Consultas Específicas
select * from Usuario where tipoUsuario = 'Administrador';
select * from Usuario where telefonoUsuario = 30103456;
select nombreUsuario, appellidoUsuario, docUsuario from Usuario where appellidoUsuario like '%Torres%';
select docUsuario,nombreUsuario, appellidoUsuario,estadoUsuario from Usuario where docUsuario Like '5%';
select count(tipoUsuario) from Usuario where tipoUsuario = 'Empleado';
select docUsuario, nombreUsuario, appellidoUsuario from Usuario where direccionUsuario not like '%Avenida%';
select docUsuario, nombreUsuario, appellidoUsuario from Usuario where telefonoUsuario = 3178901234;

#Modificaciones
update Usuario set tipoUsuario = 'Administrador' where docUsuario = 971234583;
alter table Usuario modify column nombreUsuario varchar(30);
alter table Usuario change column appellidoUsuario apellidoUsuario VARCHAR(20) NOT NULL;
update Usuario set estadoUsuario = false where docUsuario = 107234593;
update Usuario set nombreUsuario = 'Vera patricia' where docUsuario = 52765432;

#Eliminación
delete from Usuario where docUsuario = 981234585;

#Subconsultas
select nombreCliente, apellidoCliente from Cliente
where docCliente in (select docClienteFK from Venta where estadoVenta = false);

#Procedimientos
DELIMITER //
create procedure insertarUsuario(in docUs int, in nomUs varchar(30), in apellidoUs varchar(20), 
in correoUs varchar(50), in estadoUs bool, in telUs int unsigned,in dirUs varchar(100), in tipUs enum('Administrador','Empleado'),
in nicknom varchar(30))
Begin
	insert into Usuario values (docUs,nomUs,apellidoUs,correoUs,
    estadoUs,telUs,dirUs,tipUs,nicknom);
end// 
DELIMITER ;

call insertarUsuario(20147890, 'Marta Beatriz', 'Martínez Romero', 'marta.martinez@gmail.com',
true, 3234567890, 'Carrera 8 #56-78, Bogotá', 'Empleado', 'martabeatriz');

DELIMITER //
create procedure inactivarUsuario(in docUs int)
Begin
	Update Usuario set estadoUsuario = false where docUsuario = docUs;
end//
DELIMITER ;

call inactivarUsuario(20147890);

DELIMITER //
create procedure actualizarDireccion(in docUs int, in dirUs varchar(100))
Begin
	Update Usuario set direccionUsuario = dirUs where docUsuario = docUs;
end//
DELIMITER ;

call actualizarDireccion(20147890,'Calle 11 #34-12, Bogotá');

#Vistas
create view vistaAdministradores as 
select docUsuario, nombreUsuario, apellidoUsuario, nickname
from Usuario where tipoUsuario = 'Administrador';

create view vistaEmpleadosActivos as select docUsuario, nombreUsuario, 
apellidoUsuario, correoUsuario, telefonoUsuario, nickname
from Usuario where estadoUsuario = true and tipoUsuario = 'Empleado';

select * from vistaEmpleadosActivos;
