DROP TABLE alumnos;
CREATE TABLE alumnos(
								codigo INT(3),
								nombre VARCHAR(21) NOT NULL,
								apellido VARCHAR(30) NOT NULL CHECK (UPPER(apellido)),
								Curso INT CHECK (Curso=1 OR Curso=2 OR Curso=3),
								Fecha_matri DATE,
								PRIMARY KEY (codigo) 
							);
							
DROP TABLE empleados;							
CREATE TABLE empleados	(
									Cod_emple INT(2),
									Nombre VARCHAR(20) NOT NULL CHECK (Nombre < 20),
									Apellido VARCHAR(25) CHECK (Apellido < 25),
									Salario DOUBLE(7, 2) CHECK (Salario > 0),
									PRIMARY KEY (Cod_emple),
									Cod_provi_fk INT(2),
									Cod_empre_fk INT(2),
									CONSTRAINT Cod_provi_fk FOREIGN KEY (Cod_provi_fk) REFERENCES provincias (Cod_provi) ON DELETE CASCADE,
									CONSTRAINT Cod_empre_fk FOREIGN KEY (Cod_empre_fk) REFERENCES empresas (Cod_empre) ON DELETE CASCADE
								);