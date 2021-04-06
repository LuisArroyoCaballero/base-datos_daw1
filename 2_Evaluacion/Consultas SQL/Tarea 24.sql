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
									PRIMARY KEY (Cod_emple)
								);
								
CREATE TABLE TABLA_PROVINCIA	(
											COD_PROVINCIA INT,
											NOM_PROVINCIA VARCHAR(25),
											PRIMARY KEY (COD_PROVINCIA)
										);
								
CREATE TABLE Tabla_Personas	(
											DNI CHAR(9),
											NOMBRE VARCHAR(25),
											DIRECCION VARCHAR(30),
											POBLACION VARCHAR(25),
											CODPROVIN INT,
											PRIMARY KEY (DNI),
											CONSTRAINT CODPROVIN FOREIGN KEY (CODPROVIN) REFERENCES TABLA_PROVINCIA (COD_PROVINCIA) ON DELETE CASCADE
										);
										
