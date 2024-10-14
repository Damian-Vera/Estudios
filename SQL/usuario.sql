/*
CREATE TABLE usuario (
	id SERIAL,
	name varchar(50) not null,
	edad int not null,
	email varchar(100) not null,
	PRIMARY KEY (id)
);
*/

/*
INSERT INTO usuario (name, edad, email) values ('Oscar', 25, 'oscar@gmail.com');
INSERT INTO usuario (name, edad, email) values ('Layla', 15, 'layla@gmail.com');
INSERT INTO usuario (name, edad, email) values ('Nicolas', 36, 'nicolas@gmail.com');
INSERT INTO usuario (name, edad, email) values ('Chanchito', 7, 'chanchito@gmail.com');
*/

SELECT * FROM usuario;
SELECT * FROM usuario limit 1;
SELECT * FROM usuario WHERE edad > 15;
SELECT * FROM usuario WHERE edad >= 15;
SELECT * FROM usuario WHERE edad >= 20 AND email = 'nicolas@gmail.com';
SELECT * FROM usuario WHERE edad >= 20 OR email = 'layla@gmail.com';
SELECT * FROM usuario WHERE email != 'layla@gmail.com';
SELECT * FROM usuario WHERE edad BETWEEN 15 and 30;
-- empieza con algo, sigue gmail y termina con algo
SELECT * FROM usuario WHERE email LIKE '%@gmail%';
-- empieza con gmail, y termina con algo
SELECT * FROM usuario WHERE email LIKE '@gmail%';
-- Empieza con algo, y termina en gmail
SELECT * FROM usuario WHERE email LIKE '%@gmail';

SELECT * FROM usuario ORDER BY edad asc;
SELECT * FROM usuario ORDER BY edad desc;

SELECT MAX(edad) AS mayor FROM usuario;
SELECT MIN(edad) AS menor FROM usuario;

SELECT id, name FROM usuario;
SELECT id, name as nombre FROM usuario;