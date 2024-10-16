

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



