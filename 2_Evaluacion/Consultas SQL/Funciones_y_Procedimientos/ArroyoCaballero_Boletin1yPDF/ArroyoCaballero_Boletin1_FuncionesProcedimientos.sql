/*Boletin 1 funciones y procedimientos en mySQL*/

/*1. Diseñar un procedimiento que muestre todos los empleados*/

DELIMITER $$

CREATE PROCEDURE mostrarEmpleados()
	BEGIN 
		SELECT *
		FROM empleados;
	END
$$

CALL mostrarEmpleados;


/*2. Mostrar todos los empleados mayores de una edad determinada, ésta se pasará como parámetro al procedimiento*/

DROP PROCEDURE mostrarEmpleadosPorEdad;

DELIMITER $$

CREATE PROCEDURE mostrarEmpleadosPorEdad(x INT)
	BEGIN 
		SELECT *
		FROM empleados
		WHERE X <= YEAR(NOW()) - YEAR(fechanac);	
	END
$$

CALL mostrarEmpleadosPorEdad(50);

/*3. Diseñar un procedimiento que según el número de empleados nos muestre: “Pequeña o mediana empresa” 
si el número de empleados es menor o igual que 10. En caso contrario debe mostrar: “Gran empresa”*/

DROP PROCEDURE mostrarTamEmpresa;

DELIMITER $$

CREATE PROCEDURE mostrarTamEmpresa()
	BEGIN
		DECLARE cuentaEmpleados INT;
		SELECT COUNT(dni)
		INTO cuentaEmpleados 
		FROM empleados;
		IF (cuentaEmpleados <= 10) THEN 
			SELECT 'Pequena o mediana empresa';
		ELSE 
			SELECT 'Gran empresa';
		END IF;
	END
$$

CALL mostrarTamEmpresa;

/*4. Diseñar un procedimiento que según el número total de horas de trabajo de todos
los proyectos (en Robótica) muestre:

a. Si el número total de horas de trabajo es menor que 25: debe mostrar el
nombre de todos los empleados (para notificarles que el rendimiento es muy
bajo).

b. Si el número total de horas se encuentra entre 25 y 100: debe mostrar un
mensaje indicado que todo es normal.

c. Y otro caso: (como el número de horas es elevado) premiar a los empleados
incrementando su sueldo en un 10 %.*/

DROP PROCEDURE rendimiento;

DELIMITER $$

CREATE PROCEDURE rendimiento()
	BEGIN 
		DECLARE horasTrabajadas INT;
		SELECT SUM(horas)
		INTO horasTrabajadas
		FROM trabaja_en;
		
		IF (horasTrabajadas < 25) THEN 
			SELECT nombre
			FROM empleados;
		ELSEIF (horasTrabajadas >= 25 AND horasTrabajadas <=100) THEN 
			SELECT 'Todo normal';
		ELSE 
		 	UPDATE empleados
		 	SET salario = salario * (1.1);
			SELECT nombre, salario
         FROM empleados;
		END IF;
	END 
$$
		
CALL rendimiento;	