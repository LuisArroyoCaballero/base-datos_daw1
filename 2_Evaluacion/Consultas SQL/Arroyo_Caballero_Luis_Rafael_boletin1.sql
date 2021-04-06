/*1 Mostrar el apellido, oficio y número de departamento de cada empleado.*/
SELECT apellidos, oficio, dept_no FROM emple;
/*2 Mostrar el número, nombre y localización de cada departamento */
SELECT dept_no, dnombre, loc FROM depart;
/*3 Mostrar todos los datos de todos los empleados*/
SELECT * FROM emple;
/*4 Datos de los empleados ordenados por apellidos.*/
SELECT * FROM emple ORDER BY apellidos ASC;
/*5 Datos de los empleados ordenados por número de departamento descendentemente.*/
SELECT * FROM emple ORDER BY dept_no DESC;
/*6 Datos de los empleados ordenados por número de departamento descendentemente y dentro de cada departamento ordenados por apellido ascendentemente.*/
SELECT * FROM emple ORDER BY dept_no DESC, apellidos ASC;
/*8 Mostrar los datos de los empleados cuyo salario sea mayor que 2000000.*/
SELECT * FROM emple WHERE salario > 2000000; /* No hay ningun empleado con un salario mayor a esa cifra*/
/*9 Mostrar los datos de los empleados cuyo oficio sea ʻANALISTAʼ.*/
SELECT * FROM emple WHERE oficio='Analista';
/*10 Seleccionar el apellido y oficio de los empleados del departamento número 20.*/
SELECT apellidos, oficio FROM emple WHERE dept_no=20;
/*11 Mostrar todos los datos de los empleados ordenados por apellido.*/
SELECT * FROM emple ORDER BY apellidos ASC;
/*12 Seleccionar los empleados cuyo oficio sea ʻVENDEDORʼ. Mostrar los datos ordenados por apellido.*/
SELECT * FROM emple WHERE oficio='vendedor' ORDER BY apellidos ASC;
/*13 Mostrar los empleados cuyo departamento sea 10 y cuyo oficio sea ʻANALISTAʼ. Ordenar el resultado por apellido.*/
SELECT * FROM emple WHERE dept_no=10 and oficio='Analista' ORDER BY apellidos ASC;
/*14 Mostrar los empleados que tengan un salario mayor que 200000 o que pertenezcan al departamento número 20.*/
SELECT * FROM emple WHERE salario > 200000 OR dept_no=20;
/*15 Ordenar los empleados por oficio, y dentro de oficio por nombre*/
SELECT * FROM emple ORDER BY oficio, apellidos;/*No hay columna nombre, he sustitudido nombre por apellidos*/
/*16 Seleccionar de la tabla EMPLE los empleados cuyo apellido empiece por ʻAʼ.*/
SELECT * FROM emple WHERE apellidos LIKE 'A%';
/*17 Seleccionar de la tabla EMPLE los empleados cuyo apellido termine por ʻZʼ.*/
SELECT * FROM emple WHERE apellidos LIKE '%Z';
/*18 Seleccionar de la tabla EMPLE aquellas filas cuyo APELLIDO empiece por ʻAʼ y el OFICIO tenga una ʻEʼ en cualquier posición*/
SELECT * FROM emple WHERE apellidos LIKE 'A%' AND oficio LIKE '%E%';
/*19 Seleccionar los empleados cuyo salario esté entre 100000 y 200000. Utilizar el operador BETWEEN.*/
SELECT * FROM emple WHERE salario BETWEEN 100000 AND 200000;
/*20 Obtener los empleados cuyo oficio sea ʻVENDEDORʼ y tengan una comisión superior a 100000.*/
SELECT * FROM emple WHERE oficio='vendedor' AND comision>100000;
/*21 Seleccionar los datos de los empleados ordenados por número de departamento, y dentro de cada departamento ordenados por apellido.*/
SELECT * FROM emple ORDER BY dept_no ASC, apellidos ASC;
/*22 Número y apellidos de los empleados cuyo apellido termine por ʻZʼ y tengan un salario superior a 300000.*/
SELECT emp_no, apellidos FROM emple WHERE apellidos LIKE '%Z' AND salario>300000;
/*23. Datos de los departamentos cuya localización empiece por ʻBʼ.*/
SELECT * FROM depart WHERE loc LIKE 'B%';
/*24. Datos de los empleados cuyo oficio sea ʻEMPLEADOʼ, tengan un salario superior a 100000 y pertenezcan al departamento número 10.*/
SELECT * FROM emple WHERE oficio='EMPLEADO' AND salario>100000 AND dept_no=10;
/*25. Mostrar los apellidos de los empleados que no tengan comisión.*/
SELECT apellidos FROM emple WHERE comision is NULL;
/*26. Mostrar los apellidos de los empleados que no tengan comisión y cuyo apellido empiece por ʻJʼ.*/
SELECT apellidos FROM emple WHERE comision is NULL AND apellidos LIKE 'J%';
/*27. Mostrar los apellidos de los empleados cuyo oficio sea ʻVENDEDORʼ, ʻANALISTAʼ o ʻEMPLEADOʼ*/
SELECT apellidos FROM emple WHERE oficio='vendedor' OR oficio='analista' OR oficio='empleado';
/*28. Mostrar los apellidos de los empleados cuyo oficio no sea ni ʻANALISTAʼ ni ʻEMPLEADOʼ, y además tengan un salario mayor de 200000.*/
SELECT apellidos FROM emple WHERE salario>200000 and not oficio='analista' and not oficio='empleado';
/*29 Seleccionar de la tabla EMPLE los empleados cuyo salario esté entre 2000000 y 3000000 (utilizar BETWEEN).*/
SELECT * FROM emple WHERE salario BETWEEN 200000 AND 300000; /*le he quitado un cero para que me de algun resultado, he intuido que habia ceros de mas*/
/*30 Seleccionar el apellido, salario y número de departamento de los empleados cuyo salario sea mayor que 200000 en los departamentos 10 ó 30.*/
SELECT apellidos, salario, dept_no from emple WHERE salario>200000 AND dept_no=10 OR dept_no=30;
/*31. Mostrar el apellido y número de los empleados cuyo salario no esté entre 100000 y 200000 (utilizar BETWEEN).*/
SELECT apellidos, emp_no FROM emple WHERE salario BETWEEN 100000 AND 200000;
/*32.Obtener el apellidos de todos los empleados en minúscula.*/
SELECT LOWER (apellidos) FROM emple;
/*33.En una consulta concatena el apellido de cada empleado con su oficio.*/
SELECT CONCAT_WS(" ",apellidos, oficio) AS ConcatApellidoOficio FROM emple;
/*34. Mostrar el apellido y la longitud del apellido (función LENGTH) de todos los empleados, ordenados por la longitud de los 
apellidos de los empleados descendentemente.*/
SELECT  apellidos,LENGTH(apellidos) FROM emple ORDER BY LENGTH(apellidos) DESC;
/*35.Obtener el año de contratación de todos los empleados (función YEAR).*/
SELECT YEAR(fecha_alt) FROM emple;
/*36. Mostrar los datos de los empleados que hayan sido contratados en el año 1992.*/
SELECT * FROM emple WHERE YEAR(fecha_alt)=1992;
/*37. Mostrar los datos de los empleados que hayan sido contratados en el mes de febrero de cualquier año (función MONTHNAME).*/
SELECT * FROM emple WHERE MONTHNAME(fecha_alt)='February';
/*38. Para cada empleado mostrar el apellido y el mayor valor del salario y la comisión que tienen.*/
SELECT apellidos,MAX(salario) AS MayorSalario, comision FROM emple;
/*39. Mostrar los datos de los empleados cuyo apellido empiece por 'A' y hayan sido contratados en el año 1990.*/
SELECT * FROM emple WHERE apellidos LIKE 'A%' AND YEAR(fecha_alt)=1990;
/*40. Mostrar los datos de los empleados del departamento 10 que no tengan comisión.*/
SELECT * FROM emple WHERE dept_no=10 AND comision IS NULL;
