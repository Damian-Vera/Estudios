

Create Table Pokemon (
	nombre varchar(30) NOT NULL,
	id int NOT NULL,
	pesoKG float NOT NULL, 
	alturaMts float NOT NULL,
	tipo varchar(20) NOT NULL,
	tipo_secundario varchar(20),
	preevo_id int, 
	nombre_preevo varchar(30),
	nombre_evo varchar(30),
	evo_id int,
	PRIMARY KEY(id)
);

-- jugando un poco con el select
SELECT * FROM pokemon WHERE tipo = 'psíquico' AND tipo_Secundario = 'hada';
SELECT * FROM POKEMON WHERE tipo = 'fuego' AND pesoKG > 100;
SELECT * FROM pokemon WHERE nombre_preevo IS NOT NULL;
SELECT * FROM pokemon WHERE tipo IN ('agua') and tipo_secundario IS NOT NULL;
SELECT * FROM pokemon WHERE TIPO NOT IN ('normal', 'veneno', 'fantasma' , 'bicho') 
AND tipo_secundario NOT IN ('normal', 'veneno', 'fantasma' , 'bicho');
-- olvide quitar las tildes. :P



