/* Añadir drop y probar siempre a importar el archivo sql a heidi */
/* http://aulavirtual.iesalixar.org/mod/resource/view.php?id=7055 */

DROP DATABASE IF EXISTS empresa1 ;
CREATE DATABASE empresa1;
USE empresa1;
CREATE TABLE depart
(
	dept_no INTEGER,
	dnombre VARCHAR(20),
	loc     VARCHAR(20),
	PRIMARY KEY (dept_no)
);

INSERT INTO depart
VALUES ('10','CONTABILIDAD','SEVILLA');
INSERT INTO depart
VALUES ('20','INVESTIGACION','MADRID');
INSERT INTO depart
VALUES ('30','VENTAS','BARCELONA');
INSERT INTO depart
VALUES ('40','PRODUCCION','BILBAO');


CREATE TABLE emple
(
	emp_no    INTEGER,
	apellidos VARCHAR(20),
	oficio    VARCHAR(20),
	dir       INTEGER,
	fecha_alt date,
	salario   INTEGER,
	comision  INTEGER,
	dept_no   INTEGER,
	PRIMARY KEY (emp_no),
	foreign KEY (dept_no) references depart (dept_no)
);

INSERT INTO emple (emp_no, apellidos, oficio, dir, fecha_alt, salario, dept_no)
VALUES ('7369','SANCHEZ','EMPLEADO','7902','1980-02-17','104000','20');
INSERT INTO emple
VALUES ('7499','ARROYO','VENDEDOR','7698','1980-02-20','208000','39000','30');
INSERT INTO emple
VALUES ('7521','SALA','VENDEDOR','7698','1981-02-22','162500','162500','30');
INSERT INTO emple (emp_no, apellidos, oficio, dir, fecha_alt, salario, dept_no)
VALUES ('7566','JIMENEZ','DIRECTOR','7839','1981-04-02','386750','20');
INSERT INTO emple
VALUES ('7654','MARTIN','VENDEDOR','7698','1981-09-29','162500','182000','30');
INSERT INTO emple(emp_no, apellidos, oficio, dir, fecha_alt, salario, dept_no)
VALUES ('7698','NEGRO','DIRECTOR','7839','1981-05-01','370500','30');
INSERT INTO emple(emp_no, apellidos, oficio, dir, fecha_alt, salario, dept_no)
VALUES ('7788','GIL','ANALISTA','7566','1981-11-09','390000','20');
INSERT INTO emple(emp_no, apellidos, oficio, fecha_alt, salario, dept_no)
VALUES ('7839','REY','PRESIDENTE','1981-11-17','650000','10');
INSERT INTO emple
VALUES ('7844','TOVAR','VENDEDOR','7698','1981-09-08','195000','0','30');
INSERT INTO emple(emp_no, apellidos, oficio, dir, fecha_alt, salario, dept_no)
VALUES ('7876','ALONSO','EMPLEADO','7788','1981-09-23','143000','20');
INSERT INTO emple(emp_no, apellidos, oficio, dir, fecha_alt, salario, dept_no)
VALUES ('7900','JIMENO','EMPLEADO','7698','1981-12-03','1235000','30');
INSERT INTO emple(emp_no, apellidos, oficio, dir, fecha_alt, salario, dept_no)
VALUES ('7902','FERNANDEZ','ANALISTA','7566','1981-12-03','390000','20');
INSERT INTO emple(emp_no, apellidos, oficio, dir, fecha_alt, salario, dept_no)
VALUES ('7934','MUÑOZ','EMPLEADO','7782','1982-01-23','169000','10');

-- EJERCICIO 1
SELECT apellidos, oficio, emp_no FROM emple;

-- EJERCICIO 2
SELECT * FROM  depart;

-- EJERCICIO 3
SELECT * FROM  emple;

-- EJERCICIO 4
SELECT * FROM emple
ORDER BY apellidos;

-- EJERCICIO 5
SELECT * FROM emple
ORDER BY dept_no DESC;

-- EJERCICIO 6
SELECT * FROM emple
ORDER BY dept_no DESC, apellidos ASC;

-- EJERCICIO 8
SELECT * FROM emple
WHERE salario>2000000;

-- EJERCICIO 9
SELECT * FROM emple
WHERE oficio='ANALISTA';

-- EJERCICIO 10
SELECT apellidos, oficio FROM emple
WHERE dept_no=20;

-- EJERCICIO 11
SELECT * FROM emple
ORDER BY apellidos;

-- EJERCICIO 12
SELECT * FROM emple
WHERE oficio='VENDEDOR' ORDER BY apellidos;

-- EJERCICIO 13
SELECT * FROM emple
WHERE dept_no=10 AND oficio='ANALISTA'
ORDER BY apellidos;

-- EJERCICIO 14
SELECT * FROM emple
WHERE salario>200000 OR dept_no=20;

-- EJERCICIO 15
SELECT * FROM emple
ORDER BY oficio, nombre;

-- EJERCICIO 16
SELECT * FROM emple
WHERE apellidos LIKE'A%'

-- EJERCICIO 17
SELECT * FROM emple
WHERE apellidos LIKE'%Z'

-- EJERCICIO 18
SELECT * FROM emple
WHERE apellidos LIKE'A%' AND oficio LIKE '%E%';

-- EJERCICIO 19
SELECT * FROM emple
WHERE salario BETWEEN 100000 AND 200000;

-- EJERCICIO 20
SELECT * FROM emple
WHERE oficio='VENDEDOR' AND comision>100000;

-- EJERCICIO 21
SELECT * FROM emple
ORDER BY dept_no, apellidos;
 
-- EJERCICIO 22
SELECT emp_no, apellidos FROM emple
WHERE apellidos LIKE '%Z' AND salario>300000;

-- EJERCICIO 23
SELECT * FROM depart
WHERE loc LIKE 'B%';

-- EJERCICIO 24
SELECT * FROM emple
WHERE oficio='EMPLEADO' AND salario>100000 AND dept_no=10;

-- EJERCICIO 25
SELECT apellidos FROM emple
WHERE comision IS NULL;

-- EJERCICIO 26
SELECT apellidos FROM emple
WHERE comision IS NULL AND apellidos LIKE 'J%';

-- EJERCICIO 27
SELECT apellidos FROM emple
WHERE oficio='VENDEDOR' OR oficio='ANALISTA' OR oficio='EMPLEADO';

-- EJERCICIO 28
SELECT apellidos FROM emple
WHERE NOT (oficio='ANALISTA' OR oficio='EMPLEADO') AND salario>200000;

-- EJERCICIO 29
SELECT * FROM emple
WHERE salario BETWEEN 2000000 AND 3000000;

-- EJERCICIO 30
SELECT apellidos, salario, dept_no FROM emple
WHERE salario>200000 AND (dept_no=10 OR dept_no=30);

-- EJERCICIO 31
SELECT apellidos, emp_no FROM emple
WHERE NOT salario BETWEEN 100000 AND 200000;

-- EJERCICIO 32
SELECT LOWER(apellidos) FROM emple;

-- EJERCICIO 33
SELECT CONCAT (apellidos,' ', oficio) FROM emple;

-- EJERCICIO 34
SELECT apellidos, LENGTH(apellidos) AS longitud_apellidos FROM emple
ORDER BY longitud_apellidos DESC;

-- EJERCICIO 35
SELECT emp_no, YEAR(fecha_alt) AS año_contratacion FROM emple;

-- EJERCICIO 36
SELECT emp_no, YEAR(fecha_alt) AS año_contratacion FROM emple
WHERE YEAR(fecha_alt)=1992;

-- EJERCICIO 37
SELECT emp_no, apellidos, oficio, dir, MONTHNAME(fecha_alt) AS
mes_contratacion, salario, comision, dept_no  FROM emple
WHERE MONTHNAME(fecha_alt)='February';

-- EJERCICIO 38
SELECT emp_no, apellidos, comision, MAX(salario) FROM emple;

-- EJERCICIO 39
SELECT emp_no, apellidos, oficio, dir, YEAR(fecha_alt) AS
año_contratacion, salario, comision, dept_no  FROM emple
WHERE apellidos LIKE 'A%' AND YEAR(fecha_alt)=1990;

-- EJERCICIO 40 
SELECT * FROM emple
WHERE dept_no=10 AND comision IS NULL; 



