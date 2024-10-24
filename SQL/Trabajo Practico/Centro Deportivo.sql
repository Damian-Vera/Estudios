

-- TABLAS
CREATE TABLE categoria(
	id int not null,
	importe int not null,
	descripcion varchar(30) not null,
	creditos int,
	PRIMARY KEY(id)
);

CREATE TABLE socio (
	dni int,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	telefono int not null,
	id_categoria int not null,
	codigo_postal varchar(20),
	ciudad varchar(50) not null,
	fecha_nacimiento Date not null,
	PRIMARY KEY(dni),
	CONSTRAINT fk_idCat
		FOREIGN KEY(id_categoria)
			REFERENCES categoria(id)
);

CREATE TABLE socio_menor(
	dni int,
	dni_primo int,
	CONSTRAINT fk_dni FOREIGN KEY (dni) REFERENCES socio(dni),
	CONSTRAINT fk_dni_primo FOREIGN KEY (dni_primo) REFERENCES socio(dni)
);

CREATE TABLE instalacion(
	id int,
	descripcion varchar(40),
	precio float,
	ubicacion varchar(30),
	PRIMARY KEY(id)
);

CREATE TABLE reservacion (
	id int,
	fecha_reserva date not null,
	hora_inicio varchar(20) not null,
	hora_salida varchar(20) not null,
	id_instalacion int,
	dni int,
	PRIMARY KEY(id),
		CONSTRAINT fk_instalacion
			FOREIGN KEY (id_instalacion)
				REFERENCES instalacion(id),
		CONSTRAINT fk_dni
			FOREIGN KEY (dni)
				REFERENCES socio(dni)
);



CREATE TABLE articulo_deportivo (
	id int,
	descripcion varchar(40),
	precio int,
	PRIMARY KEY(id)
);

CREATE TABLE alquiler(
	reserva int not null,
	producto_id int not null,
	cantidad int not null,
		CONSTRAINT fk_reserva
		FOREIGN KEY (reserva)
			REFERENCES reservacion(id),
		CONSTRAINT fk_producto
		FOREIGN KEY (producto_id)
			REFERENCES articulo_deportivo(id)
);

-- Insercion de datos

INSERT INTO categoria (id, importe, descripcion, creditos)
	VALUES (1, 34.99, 'economico', 10), (2, 49.99, 'estandar', 20),
	(3, 79.99, 'premium', 60);
	
INSERT INTO socio (dni, nombre, apellido, telefono, id_categoria, codigo_postal, ciudad, fecha_nacimiento)
 VALUES
(12345678, 'Juan', 'Pérez', '654321987', 1, '28001', 'Merlo', '1990-05-14'),
(23456789, 'Ana', 'García', '612345678', 2, '08001', 'Merlo', '1985-08-23'),
(34567890, 'Luis', 'Martínez', '671234567', 3, '41001', 'Marcos Paz', '1992-11-30'),
(45678901, 'María', 'López', '689765432', 1, '29001', 'Moron', '1993-01-12'),
(56789012, 'Carlos', 'Sánchez', '697123456', 2, '46001', 'Mariano Acosta', '1988-03-07'),
(67890123, 'Laura', 'Fernández', '654789123', 3, '50001', 'Ferrari', '1991-06-25'),
(78901234, 'Pablo', 'Ruiz', '679321456', 1, '35001', 'Caballito', '1990-12-15'),
(89012345, 'Carmen', 'Hernández', '612789345', 2, '33001', 'Merlo', '1987-10-05'),
(90123456, 'José', 'Díaz', '691234789', 3, '20001', 'Marcos Paz', '1994-09-18'),
(01234567, 'Elena', 'Jiménez', '658912345', 1, '15001', 'Las Heras', '1990-04-22');


INSERT INTO instalacion(id, descripcion, precio, ubicacion)
	VALUES (1, 'cancha de tenis', 20, 'playon A'), (2, 'cancha de futbol', 15, 'playon B'),
			(3, 'Pileta', 30, 'Playon C');

INSERT INTO reservacion(id, dni, fecha_reserva, hora_inicio, hora_salida, id_instalacion)
    VALUES 
    (1, 12345678, '2024-09-05', '10:00', '11:00', 1),
    (2, 23456789, '2024-09-10', '15:00', '16:00', 1),
    (3, 34567890, '2024-09-15', '17:00', '18:00', 1),
    (4, 45678901, '2024-08-20', '12:00', '13:00', 2),
    (5, 56789012, '2024-07-25', '09:00', '10:00', 3),
    (6, 67890123, '2024-06-30', '14:00', '15:00', 2),
    (7, 78901234, '2024-10-05', '11:00', '12:00', 1),
    (8, 89012345, '2024-05-15', '16:00', '17:00', 3),
    (9, 90123456, '2024-04-10', '13:00', '14:00', 2),
    (10, 01234567, '2024-03-12', '18:00', '19:00', 3);

/*
	a- Listar los datos completos de las instalaciones y 
	la cantidad de reservas hechas durante el mes de Septiembre.
	Incluir solo instalaciones que tuvieron más de 3 reservas.
*/
-- resolucion del punto A

SELECT i.id, i.descripcion, i.precio, i.ubicacion, COUNT(r.id) AS reservas
FROM reservacion r
INNER JOIN instalacion i ON r.id_instalacion = i.id
WHERE EXTRACT(MONTH FROM r.fecha_reserva) = 9
AND EXTRACT(YEAR FROM r.fecha_reserva) = 2024
GROUP BY i.id, i.descripcion, i.precio, i.ubicacion
HAVING COUNT(r.id) >= 3;


/*
	b- Listar los datos completos de las instalaciones que tuvieron en el mes de 
	Septiembre más uso que en el mes de Agosto de este año.
	Incluir la cantidad de reservas.
*/
-- resolucion del punto B

SELECT i.id, i.descripcion, i.precio, i.ubicacion, 
COUNT(CASE WHEN EXTRACT(MONTH FROM r.fecha_reserva) = 8 THEN 1 END) AS reservas_agosto,
COUNT(CASE WHEN EXTRACT(MONTH FROM r.fecha_reserva) = 9 THEN 1 END) AS reservas_septiembre
FROM reservacion r 
INNER JOIN instalacion i ON r.id_instalacion = i.id
GROUP BY i.id, i.descripcion, i.precio, i.ubicacion
HAVING COUNT(CASE WHEN EXTRACT(MONTH FROM r.fecha_reserva) = 8 THEN 1 END) > 
	   COUNT(CASE WHEN EXTRACT(MONTH FROM r.fecha_reserva) = 9 THEN 1 END);

-- EXPLICACION
-- COUNT(CASE WHEN EXTRACT(MONTH FROM r.fecha_reserva) = 8 THEN 1 END) AS reservas_agosto
-- CUANDO EL MES ES IGUAL A 8 DEVUELVE 1, ENTONCES SE CONTABILIZA 1 reserva en agosto
-- esto lo hace con cada reservacion

/*
HAVING COUNT(CASE WHEN EXTRACT(MONTH FROM r.fecha_reserva) = 8 THEN 1 END) > 
	   COUNT(CASE WHEN EXTRACT(MONTH FROM r.fecha_reserva) = 9 THEN 1 END);

En este caso el HAVING se encarga de comparar los dos COUNT para verificar si se hicieron 
mas reservas en agosto.
*/


/*
	c- Listar los datos completos de los socios que NO realizaron reservas entre 
	el 10 y el 20 de Septiembre (incluidos).
*/
-- Resolucion del punto C
SELECT * FROM socio s WHERE s.dni NOT IN(
SELECT r.dni FROM reservacion r where Fecha_reserva
BETWEEN '2024-09-10' and '2024-09-20');


