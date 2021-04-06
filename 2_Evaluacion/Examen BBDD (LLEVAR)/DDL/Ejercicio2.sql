DROP DATABASE IF EXISTS empresa_construccion;
CREATE DATABASE empresa_construccion;
USE empresa_construccion;

CREATE TABLE proyecto(
	codigo INT(9) PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL
);

CREATE TABLE empleados(
	dni_empleado CHAR(9) PRIMARY KEY,
	nombre_empleado VARCHAR(20) NOT NULL,
	sueldo_empleado INT(20) NOT NULL,
	fecha_asig DATE,
	codigo INT(10),
	CONSTRAINT proyec_emple_fk FOREIGN KEY (codigo) REFERENCES proyecto(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE jefe(
	dni_jefe CHAR(9),
	dni_empleado CHAR(9) UNIQUE,
	CONSTRAINT empledni_jefe_fk FOREIGN KEY (dni_empleado) REFERENCES empleados(dni_empleado) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT emple_jefedni_fk FOREIGN KEY (dni_empleado) REFERENCES empleados(dni_empleado) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO proyecto(codigo, nombre) VALUES('1','Proyecto1');
INSERT INTO proyecto(codigo, nombre) VALUES('2','Proyecto2');
INSERT INTO proyecto(codigo, nombre) VALUES('3','Proyecto3');

INSERT INTO empleados(dni_empleado, nombre_empleado, sueldo_empleado, fecha_asig, codigo) VALUES('76980518R','Paco', '1100', '2012/12/11', '1');
INSERT INTO empleados(dni_empleado, nombre_empleado, sueldo_empleado, fecha_asig, codigo) VALUES('06939392Q','Luis', '900', '2010/09/21', '2');
INSERT INTO empleados(dni_empleado, nombre_empleado, sueldo_empleado, fecha_asig, codigo) VALUES('84447380M','Andres', '950', '2011/08/12', '3');

INSERT INTO jefe(dni_jefe, dni_empleado) VALUES('76980518R','06939392Q');
INSERT INTO jefe(dni_jefe, dni_empleado) VALUES('76980518R','84447380M');

SELECT * FROM proyecto;

SELECT * FROM empleados
WHERE sueldo_empleado=(
	SELECT MAX(sueldo_empleado) FROM empleados);
	
SELECT * FROM empleados
WHERE nombre_empleado LIKE 'L%';