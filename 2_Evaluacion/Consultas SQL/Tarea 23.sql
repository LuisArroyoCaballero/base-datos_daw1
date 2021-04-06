/*
1. Crea la tabla provincias con los siguientes campos

Cod_provi de tipo number(2) y es la clave primaria
Nombre de tipo varchar2(25), es obligatorio
Pais de tipo varchar2(25) debe ser uno de los siguientes España, Portugal o Italia
*/

CREATE TABLE provincias (
							Cod_provi INT(2),
							Nombre VARCHAR(25) NOT NULL,
							Pais VARCHAR(25),
							CHECK (Pais = 'Espana' OR Pais = 'Italia' OR Pais = 'Portugal'),
							PRIMARY KEY (Cod_provi)
						);


/*
2. Crea la tabla empresas con los siguientes campos:

Cod_empre number(2) es la clave
Nombre varchar2(25) obligatorio por defecto será empresa1
Fecha_crea de tipo fecha por defecto será un dia posterior a la fecha actual.
*/

CREATE TABLE empresas 	(
									Cod_empre INT(2),
									Nombre VARCHAR(25) NOT NULL DEFAULT 'empre1',
									Fecha_crea DATE DEFAULT CURDATE(),
									PRIMARY KEY (Cod_empre)
								);

/*
3. Crea la tabla Continentes con los siguientes campos

Cod_conti de tipo number y es la clave primaria
Nombre de tipo varchar2(20) el valor por defecto es EUROPA Y es obligatorio
*/

CREATE TABLE Continentes	(
										Cod_conti INT,
										Nombre VARCHAR(20) NOT NULL DEFAULT 'EUROPA',
										PRIMARY KEY (Cod_conti)
									);