DROP DATABASE IF EXISTS veterinario;
CREATE DATABASE veterinario;
USE veterinario;

CREATE TABLE animal	(
								id_animal INT(4) UNSIGNED PRIMARY KEY,
								nombre_animal VARCHAR(50),
								fecha_llegada DATETIME DEFAULT SYSDATE()
							);
							
CREATE TABLE gato	(
							id_animal INT(4) UNSIGNED PRIMARY KEY,
							castrado VARCHAR(2) DEFAULT 'NO' CHECK (castrado = 'SI' OR castrado = 'no'),
							CONSTRAINT fk_animal_gato FOREIGN KEY (id_animal) REFERENCES animal(id_animal) ON DELETE CASCADE
						);
						
CREATE TABLE perro	(
								id_animal INT(4) UNSIGNED PRIMARY KEY,
								CONSTRAINT fk_animal_perro FOREIGN KEY (id_animal) REFERENCES animal(id_animal) ON DELETE CASCADE
							);
								
						
CREATE TABLE empleado	(
									id_empleado INT(4) UNSIGNED PRIMARY KEY,
									nombre_empleado VARCHAR(50),
									id_jefe INT(4) UNSIGNED,
									CONSTRAINT fk_jefe_empleado FOREIGN KEY (id_jefe) REFERENCES empleado(id_empleado) ON DELETE CASCADE
								);
						
CREATE TABLE pasea	(
								id_animal INT(4) UNSIGNED,
								id_empleado INT(4) UNSIGNED,
								CONSTRAINT pk_pasea PRIMARY KEY (id_animal,id_empleado),
								CONSTRAINT fk_perro_pasea FOREIGN KEY (id_animal) REFERENCES perro(id_animal) ON DELETE CASCADE,
								CONSTRAINT fk_empleado_pasea FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE
							);
							
CREATE TABLE alimenta	(
									id_empleado INT(4) UNSIGNED,
									id_animal INT(4) UNSIGNED,
									CONSTRAINT pk_alimenta PRIMARY KEY (id_empleado,id_animal),
									CONSTRAINT fk_animal_alimenta FOREIGN KEY (id_animal) REFERENCES animal(id_animal) ON DELETE CASCADE,
									CONSTRAINT fk_empleado_alimenta FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE
								);
									
									
INSERT INTO animal(id_animal,nombre_animal)
VALUES (1,'Paco');
INSERT INTO animal(id_animal,nombre_animal)
VALUES (2,'Perico');
INSERT INTO animal(id_animal,nombre_animal)
VALUES (3,'Jose');
INSERT INTO animal(id_animal,nombre_animal)
VALUES (4,'Julian');

INSERT INTO gato(id_animal,castrado)
VALUES (1,'SI');
INSERT INTO gato(id_animal)
VALUES (2);

INSERT INTO perro(id_animal)
VALUES (3);
INSERT INTO perro(id_animal)
VALUES (4);

INSERT INTO empleado(id_empleado,nombre_empleado,id_jefe)
VALUES (1,'Jose Pedro',1);
INSERT INTO empleado(id_empleado,nombre_empleado,id_jefe)
VALUES (2,'Alfonso Javier',1);

INSERT INTO pasea (id_animal,id_empleado)
VALUES (3,2);
INSERT INTO pasea (id_animal,id_empleado)
VALUES (4,1);

INSERT INTO alimenta (id_empleado, id_animal)
VALUES (1,1);
INSERT INTO alimenta (id_empleado, id_animal)
VALUES (1,2);		

/*MODIFICACIONES*/

/*FECHA Y HORA DE PASEO

Para esta modificacion lo mejor (desde mi punto de vista) es añadir una columna en la tabla paseo donde se 
registre esta fecha y hora. Esta columna será de tipo DATETIME y como valor por defecto se tomara la hora
actual. Tambien debemos de hacer esta columna clave primaria, pues puede que el mismo empleado pasee al mismo
perro varias veces.

*/				

ALTER TABLE pasea
ADD fecha_hora_paseo DATETIME DEFAULT SYSDATE();



/*PERROS CASTRADOS*/

ALTER TABLE perro
ADD perro_castrado VARCHAR(2) DEFAULT 'NO' CHECK (perro_castrado = 'SI' OR perro_castrado = 'NO');
