DROP DATABASE IF EXISTS empresa_examen;
CREATE DATABASE empresa_examen;
USE empresa_examen;

/*CREACION DE TABLAS*/

CREATE TABLE departamento	(
										cod_depto INT(4) PRIMARY KEY,
										nombre_depto VARCHAR(50)
									);
									
CREATE TABLE empleado (
								num_matricula INT(4) PRIMARY KEY,
								nombre_empleado VARCHAR(50),
								direccion_empleado VARCHAR(50),
								cod_depto INT(4),
								CONSTRAINT fk_departamento_empleado FOREIGN KEY (cod_depto) REFERENCES departamento(cod_depto) ON DELETE CASCADE
							);
						
CREATE TABLE tecnico	(
								num_matricula_tecnico INT(4) PRIMARY KEY,
								nivel INT(1) CHECK(nivel = '1' OR nivel = '2' OR nivel = '3'),
								CONSTRAINT fk_empleado_tecnico FOREIGN KEY (num_matricula_tecnico) REFERENCES empleado(num_matricula) ON DELETE CASCADE
							);
							
CREATE TABLE proyecto	(
									cod_proyecto INT(4) PRIMARY KEY,
									nombre_proyecto VARCHAR(50),
									fecha_inicio DATE DEFAULT CURDATE(),
									fecha_fin DATE DEFAULT CURDATE(),
									cliente VARCHAR(50)
								);
							
CREATE TABLE trabaja_en	(
									cod_proyecto INT(4),
									num_matricula INT(4),
									fecha_asignacion DATE DEFAULT CURDATE(),
									fecha_cese DATE DEFAULT CURDATE(),
									CONSTRAINT pk_trabaja_en PRIMARY KEY (cod_proyecto,num_matricula),
									CONSTRAINT fk_proyecto_trabaja_en FOREIGN KEY (cod_proyecto) REFERENCES proyecto(cod_proyecto) ON DELETE CASCADE,
									CONSTRAINT fk_tecnico_trabaja_en FOREIGN KEY (num_matricula) REFERENCES empleado(num_matricula) ON DELETE CASCADE
								);
								
								
/*INSERCIONES*/

INSERT INTO departamento(cod_depto, nombre_depto)
VALUES (1111,'Electricidad');
INSERT INTO departamento(cod_depto, nombre_depto)
VALUES (2222,'Agua');

INSERT INTO empleado(num_matricula, nombre_empleado, direccion_empleado, cod_depto)
VALUES (1111,'Paco','Alicante', 1111);
INSERT INTO empleado(num_matricula, nombre_empleado, direccion_empleado, cod_depto)
VALUES (2222,'Balleno','Cadiz', 2222);

INSERT INTO tecnico(num_matricula_tecnico, nivel)
VALUES (1111,1);
INSERT INTO tecnico(num_matricula_tecnico, nivel)
VALUES (2222,2);

INSERT INTO proyecto(cod_proyecto,nombre_proyecto,cliente)
VALUES (2222,'Proyecto1','Cliente1');
INSERT INTO proyecto(cod_proyecto,nombre_proyecto,cliente)
VALUES (1111,'Proyecto1','Cliente1');

INSERT INTO trabaja_en(cod_proyecto,num_matricula)
VALUES (1111,1111);
INSERT INTO trabaja_en(cod_proyecto,num_matricula)
VALUES (2222,2222);


/*MODIFICACIONES*/

-- Considero que a la hora de modificar la tabla no solo debemos de implementar la fecha y la hora,
-- tambien debemos hacer clave primaria este dato, pues puede que este trabajador se una varias veces
-- al departamento a lo largo de su vida. Para ello devemos borrar tanto la clave primaria de la tabla
-- empleado como la clave foranea cod_depto y volver a crearla tras implementar este atributo, 
-- creando una nueva clave foranea para cod_depto y una nueva clave primaria compuesta de la 
-- fecha y hora + cod_depto + num_matricula.



ALTER TABLE empleado
ADD fecha_union DATETIME DEFAULT SYSDATE(); 



ALTER TABLE empleado
DROP CONSTRAINT fk_departamento_empleado;

ALTER TABLE tecnico
DROP CONSTRAINT fk_empleado_tecnico;

ALTER TABLE trabaja_en
DROP CONSTRAINT fk_tecnico_trabaja_en;

ALTER TABLE trabaja_en
DROP CONSTRAINT fk_proyecto_trabaja_en;



ALTER TABLE trabaja_en
DROP PRIMARY KEY;



ALTER TABLE empleado
DROP PRIMARY KEY;

ALTER TABLE empleado
ADD CONSTRAINT fk_departamento_empleado FOREIGN KEY (cod_depto) REFERENCES departamento(cod_depto) ON DELETE CASCADE;

ALTER TABLE tecnico
ADD CONSTRAINT fk_empleado_tecnico FOREIGN KEY (num_matricula_tecnico) REFERENCES empleado(num_matricula) ON DELETE CASCADE;

ALTER TABLE trabaja_en
DROP CONSTRAINT fk_tecnico_trabaja_en;

ALTER TABLE trabaja_en
DROP CONSTRAINT fk_proyecto_trabaja_en;



ALTER TABLE trabaja_en
DROP PRIMARY KEY;



ALTER TABLE empleado
DROP PRIMARY KEY;




