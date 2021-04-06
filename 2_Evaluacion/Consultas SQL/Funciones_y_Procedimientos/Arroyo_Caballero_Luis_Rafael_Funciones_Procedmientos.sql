/*Procedimientos sin sentencias SQL*/

/*1. Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida
y que muestre el texto ¡Hola mundo!.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS getHolaMundo$$
CREATE PROCEDURE getHolaMundo()
	BEGIN 
		SELECT 'Hola mundo';
	END
$$

CALL getHolaMundo$$


/*2. Escribe un procedimiento que reciba un número real de entrada y muestre un 
mensaje indicando si el número es positivo, negativo o cero.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS numPosNeg $$
CREATE PROCEDURE numPosNeg(x DOUBLE)
	BEGIN 
		IF (X < 0) THEN
			SELECT 'El numero es negativo';
		ELSEIF (X > 0) THEN
			SELECT 'El numero es positivo';
		ELSE 
			SELECT 'El numero es cero';
		END IF;
	END 
$$
CALL numPosNeg(-1)$$

/*3. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un 
parámetro de entrada, con el valor un número real, y un parámetro de salida, con una 
cadena de caracteres indicando si el número es positivo, negativo o cero.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS numPosNeg_ $$
CREATE PROCEDURE numPosNeg_(x DOUBLE)
	BEGIN
		DECLARE cad VARCHAR(10); 
		IF (X < 0) THEN
			SET cad = 'El numero es negativo';
		ELSEIF (X > 0) THEN
			SET cad = 'El numero es positivo';
		ELSE 
			SET cad = 'El numero es cero';
		END IF;
		SELECT cad;
	END 
$$
CALL numPosNeg(5)$$

/*4. Escribe un procedimiento que reciba un número real de entrada, que representa el valor 
de la nota de un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta 
las siguientes condiciones:
[0,5) = Insuficiente
[5,6) = Aprobado
[6, 7) = Bien
[7, 9) = Notable
[9, 10] = Sobresaliente
En cualquier otro caso la nota no será válida.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS getNota$$
CREATE PROCEDURE getNota(nota_numerica DOUBLE)
	BEGIN
		IF (nota_numerica >= 0 AND nota_numerica < 5) THEN
			SELECT 'Insuficiente';
		ELSEIF (nota_numerica >= 5 AND nota_numerica < 6) THEN 
			SELECT 'Aprobado';
		ELSEIF (nota_numerica >= 6 AND nota_numerica < 7) THEN 
			SELECT 'Bien';
		ELSEIF (nota_numerica >= 7 AND nota_numerica < 9) THEN 
			SELECT 'Notable';
		ELSEIF (nota_numerica >= 9 AND nota_numerica <= 10) THEN 
			SELECT 'Sobresaliente';
		ELSE
			SELECT 'Nota no valida';
		END IF;
	END
$$

CALL getNota(10)$$


/*5. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un 
parámetro de entrada, con el valor de la nota en formato numérico y un parámetro de salida, 
con una cadena de texto indicando la nota correspondiente.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS getNota_salida$$
CREATE PROCEDURE getNota_salida(nota_numerica DOUBLE)
	BEGIN
		DECLARE nota_cadena VARCHAR(15);
		IF (nota_numerica >= 0 AND nota_numerica < 5) THEN
			SET nota_cadena = 'Insuficiente';
		ELSEIF (nota_numerica >= 5 AND nota_numerica < 6) THEN 
			SET nota_cadena = 'Aprobado';
		ELSEIF (nota_numerica >= 6 AND nota_numerica < 7) THEN 
			SET nota_cadena = 'Bien';
		ELSEIF (nota_numerica >= 7 AND nota_numerica < 9) THEN 
			SET nota_cadena = 'Notable';
		ELSEIF (nota_numerica >= 9 AND nota_numerica <= 10) THEN 
			SET nota_cadena = 'Sobresaliente';
		ELSE
			SET nota_cadena = 'Nota no valida';
		END IF;
		SELECT nota_cadena;
	END
$$

CALL getNota_salida(10)$$


/*6. Resuelva el procedimiento diseñado en el ejercicio anterior haciendo 
uso de la estructura de control CASE.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS getNota_case$$
CREATE PROCEDURE getNota_case(nota_numerica DOUBLE)
	BEGIN
		DECLARE nota_cadena VARCHAR(15) DEFAULT 'Nota no valida';
		CASE nota_numerica
			WHEN 0 THEN SET nota_cadena = 'Insuficiente';
			WHEN 1 THEN SET nota_cadena = 'Insuficiente';
			WHEN 2 THEN SET nota_cadena = 'Insuficiente';
			WHEN 3 THEN SET nota_cadena = 'Insuficiente';
			WHEN 4 THEN SET nota_cadena = 'Insuficiente';
			WHEN 5 THEN SET nota_cadena = 'Aprobado';
			WHEN 6 THEN SET nota_cadena = 'Bien';
			WHEN 7 THEN SET nota_cadena = 'Notable';
			WHEN 8 THEN SET nota_cadena = 'Notable';
			WHEN 9 THEN SET nota_cadena = 'Notable';
			WHEN 10 THEN SET nota_cadena = 'Sobresaliente';
		END CASE;	
		SELECT nota_cadena;
	END
$$

CALL getNota_case(7)$$

/*7. Escribe un procedimiento que reciba como parámetro de entrada un valor numérico 
que represente un día de la semana y que devuelva una cadena de caracteres con el nombre 
del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver 
la cadena lunes.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS getDiaSemana$$
CREATE PROCEDURE getDiaSemana(num_dia INT)
	BEGIN
		CASE num_dia
			WHEN 1 THEN SELECT 'Lunes';
			WHEN 2 THEN SELECT 'Martes';
			WHEN 3 THEN SELECT 'Miercoles';
			WHEN 4 THEN SELECT 'Jueves';
			WHEN 5 THEN SELECT 'Viernes';
			WHEN 6 THEN SELECT 'Sabado';
			WHEN 7 THEN SELECT 'Domingo';
			ELSE
				SELECT 'Valor incorrecto';
		END CASE;
	END
$$

CALL getDiaSemana(2)$$



/*Procedimientos con sentencias SQL

1. Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada y
realice una consulta sobre la tabla cliente para obtener todos los clientes que existen en la tabla de ese país.*/

DELIMITER $$
USE jardineria $$
DROP PROCEDURE IF EXISTS getListClientes_byPais $$
CREATE PROCEDURE getListClientes_byPais(p VARCHAR(30))
	BEGIN 
 		SELECT nombre_cliente
 		FROM cliente
 		WHERE pais = p;
	END
$$
CALL getListClientes_byPais('USA')$$


/*2. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de 
caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida el pago de máximo valor realizado para 
esa forma de pago. Deberá hacer uso de la tabla pago de la base de datos jardineria.*/

DELIMITER $$
USE jardineria $$
DROP PROCEDURE IF EXISTS getMaxPago_Forma $$
CREATE PROCEDURE getMaxPago_Forma(p VARCHAR(20))
	BEGIN
		SELECT MAX(total)
		FROM pago
		WHERE p = forma_pago;
	END 
$$
CALL getMaxPago_Forma('PayPal')$$


/*3. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres 
(Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida los siguientes valores teniendo en cuenta la forma de pago 
seleccionada como parámetro de entrada:

el pago de máximo valor,
el pago de mínimo valor,
el valor medio de los pagos realizados,
la suma de todos los pagos,
el número de pagos realizados para esa forma de pago.
Deberá hacer uso de la tabla pago de la base de datos jardineria.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS getPrecios_byFormaPago$$
CREATE PROCEDURE getPrecios_byFormaPago(forma_pago_entrada VARCHAR(40))
	BEGIN
		SELECT MAX(total) AS pago_maximo, MIN(total) AS pago_minimo, AVG(total) AS valor_medio_pagos, SUM(total) AS suma_total_pagos, COUNT(total) AS numero_de_pagos
		FROM pago
		WHERE forma_pago = forma_pago_entrada;
	END
$$

CALL getPrecios_byFormaPago('PayPal')$$


/*4. Crea una base de datos llamada procedimientos que contenga una tabla llamada cuadrados. La tabla cuadrados debe tener dos columnas 
de tipo INT UNSIGNED, una columna llamada número y otra columna llamada cuadrado. 

Una vez creada la base de datos y la tabla deberá crear  un procedimiento llamado calcular_cuadrados con las siguientes características. 
El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y calculará el valor de los cuadrados de los primeros 
números naturales hasta el valor introducido como parámetro.  El valor del números y de sus cuadrados deberán ser almacenados en la tabla
cuadrados que hemos creado previamente.

Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los nuevos valores de los cuadrados
que va a calcular.

Utilice un bucle WHILE para resolver el procedimiento.*/

DROP DATABASE IF EXISTS procedimientos;
CREATE DATABASE procedimientos;

DROP TABLE IF EXISTS cuadrados;
CREATE TABLE cuadrados	(
									numero INT UNSIGNED,
									cuadrado INT UNSIGNED
								);


DELIMITER $$
DROP PROCEDURE IF EXISTS getCuadrado$$
CREATE PROCEDURE getCuadrado(num_entrada INT UNSIGNED)
	BEGIN 
		DECLARE contador INT UNSIGNED;
		SET contador = 0;
		WHILE (contador <> num_entrada) DO
			SET contador = (contador + 1);
			INSERT INTO cuadrados(numero, cuadrado)
			VALUES (contador, POW(contador, 2));
		END WHILE;
	END 
$$

CALL getCuadrado(5)$$

/*5. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.*/

DROP TABLE IF EXISTS cuadrados;
CREATE TABLE cuadrados	(
									numero INT UNSIGNED,
									cuadrado INT UNSIGNED
								);

DELIMITER $$
DROP PROCEDURE IF EXISTS getCuadrado_repeat$$
CREATE PROCEDURE getCuadrado_repeat(num_entrada INT UNSIGNED)
	BEGIN 
		DECLARE contador INT UNSIGNED;
		SET contador = 0;
		REPEAT 
			SET contador = (contador + 1);
			INSERT INTO cuadrados(numero, cuadrado)
			VALUES (contador, POW(contador, 2));
		UNTIL (contador = num_entrada) END REPEAT;
	END 
$$

CALL getCuadrado_repeat(5)$$


/*6. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.*/

DROP TABLE IF EXISTS cuadrados;
CREATE TABLE cuadrados	(
									numero INT UNSIGNED,
									cuadrado INT UNSIGNED
								);

DELIMITER $$
DROP PROCEDURE IF EXISTS getCuadrado_loop$$
CREATE PROCEDURE getCuadrado_loop(num_entrada INT UNSIGNED)
	BEGIN 
		DECLARE contador INT UNSIGNED;
		SET contador = 0;
		label1: LOOP
			SET contador = (contador + 1);
			INSERT INTO cuadrados(numero, cuadrado)
			VALUES (contador, POW(contador, 2));
			IF (contador <> num_entrada) THEN
				ITERATE label1;
			END IF;
			LEAVE label1;
		END LOOP label1;
	END 
$$

CALL getCuadrado_loop(7)$$


/*7. Crea una base de datos llamada procedimientos que contenga una tabla llamada ejercicio. La tabla debe tener una única columna 
llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.

Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_números con las siguientes características. 
El procedimiento recibe un parámetro de entrada llamado valor_inicial de tipo INT UNSIGNED y deberá almacenar en la tabla ejercicio 
toda la secuencia de números desde el valor inicial pasado como entrada hasta el 1.

Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.

Utilice un bucle WHILE para resolver el procedimiento.*/


DROP TABLE IF EXISTS ejercicio;
CREATE TABLE ejercicio	(
									numero INT UNSIGNED
								);
								

									

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_numeros$$
CREATE PROCEDURE calcular_numeros(valor_inicial INT UNSIGNED)
	BEGIN 
		DECLARE contador INT UNSIGNED DEFAULT 0;
		WHILE (valor_inicial > contador) DO 
			INSERT INTO ejercicio(numero)
			VALUES (valor_inicial);
			SET valor_inicial = valor_inicial - 1;
		END WHILE;
	END
$$

CALL calcular_numeros(5)$$

/*8. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior*/

DROP TABLE IF EXISTS ejercicio;
CREATE TABLE ejercicio	(
									numero INT UNSIGNED
								);
									

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_numeros_repeat$$
CREATE PROCEDURE calcular_numeros_repeat(valor_inicial INT UNSIGNED)
	BEGIN 
		DECLARE contador INT UNSIGNED DEFAULT 0;
		REPEAT
			INSERT INTO ejercicio(numero)
			VALUES (valor_inicial);
			SET valor_inicial = valor_inicial - 1;
		UNTIL (valor_inicial = contador) END REPEAT;
	END
$$

CALL calcular_numeros_repeat(6)$$


/*9. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.*/

DROP TABLE IF EXISTS ejercicio;
CREATE TABLE ejercicio	(
									numero INT UNSIGNED
								);
									

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_numeros_loop$$
CREATE PROCEDURE calcular_numeros_loop(valor_inicial INT UNSIGNED)
	BEGIN 
		label1: LOOP
			INSERT INTO ejercicio(numero)
			VALUES (valor_inicial);
			IF (valor_inicial > 0) THEN
				SET valor_inicial = valor_inicial - 1;
			END IF;
			IF (valor_inicial > 0) THEN
				ITERATE label1;
			END IF;
			LEAVE label1;
		END LOOP label1;
	END
$$

CALL calcular_numeros_loop(7)$$


/*10. Crea una base de datos llamada procedimientos que contenga una tabla llamada pares y otra tabla llamada impares. 
Las dos tablas deben tener única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.

Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado calcular_pares_impares con las siguientes características. 
El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y deberá almacenar en la tabla pares aquellos números pares 
que existan entre el número 1 el valor introducido como parámetro. Habrá que realizar la misma operación para almacenar los números impares en 
la tabla impares.

Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.

Utilice un bucle WHILE para resolver el procedimiento.*/

USE procedimientos;
DROP TABLE IF EXISTS pares;
DROP TABLE IF EXISTS impares;

CREATE TABLE pares	(
								numero INT UNSIGNED	
							);
							
CREATE TABLE impares	(
								numero INT UNSIGNED	
							);
							
							

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_pares_impares$$
CREATE PROCEDURE calcular_pares_impares(tope INT UNSIGNED)
	BEGIN 
		DECLARE contador INT DEFAULT 0;
		WHILE (contador <> tope) DO
			SET contador = contador + 1;
			IF (contador % 2 = 0) THEN
				INSERT INTO pares(numero)
				VALUES (contador);
			ELSEIF (contador % 2 <> 0) THEN
				INSERT INTO impares(numero)
				VALUES (contador);
			END IF;
		END WHILE;
	END
$$

CALL calcular_pares_impares(7)$$


/*11. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.*/

USE procedimientos;
DROP TABLE IF EXISTS pares;
DROP TABLE IF EXISTS impares;

CREATE TABLE pares	(
								numero INT UNSIGNED	
							);
							
CREATE TABLE impares	(
								numero INT UNSIGNED	
							);
							
							

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_pares_impares$$
CREATE PROCEDURE calcular_pares_impares(tope INT UNSIGNED)
	BEGIN 
		DECLARE contador INT DEFAULT 0;
		REPEAT
			SET contador = contador + 1;
			IF (contador % 2 = 0) THEN
				INSERT INTO pares(numero)
				VALUES (contador);
			ELSEIF (contador % 2 <> 0) THEN
				INSERT INTO impares(numero)
				VALUES (contador);
			END IF;
		UNTIL (contador = tope) END REPEAT;
	END
$$

CALL calcular_pares_impares(10)$$


/*12. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.*/

USE procedimientos;
DROP TABLE IF EXISTS pares;
DROP TABLE IF EXISTS impares;

CREATE TABLE pares	(
								numero INT UNSIGNED	
							);
							
CREATE TABLE impares	(
								numero INT UNSIGNED	
							);
							
							

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_pares_impares$$
CREATE PROCEDURE calcular_pares_impares(tope INT UNSIGNED)
	BEGIN 
		DECLARE contador INT DEFAULT 0;
		label1: LOOP
			SET contador = contador + 1;
			IF (contador % 2 = 0) THEN
				INSERT INTO pares(numero)
				VALUES (contador);
			ELSEIF (contador % 2 <> 0) THEN
				INSERT INTO impares(numero)
				VALUES (contador);
			END IF;
			IF (contador < tope) THEN
				ITERATE label1;
			END IF;
			LEAVE label1;
		END LOOP label1;
	END
$$

CALL calcular_pares_impares(12)$$




/*Funciones sin sentencias SQL*/


/*1. Escribe una función que reciba un número entero de entrada y devuelva TRUE si el número es par o FALSE en caso contrario.*/

DELIMITER $$
DROP FUNCTION IF EXISTS get_par_impar $$
CREATE FUNCTION get_par_impar(x INT) RETURNS BOOLEAN
	BEGIN
		DECLARE true_false BOOLEAN DEFAULT FALSE;
		IF (X % 2 = 0) THEN
			SET true_false = TRUE;
		END IF;
		RETURN true_false;
	END
$$

SELECT get_par_impar(1)$$


/*2. Escribe una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados.*/

DELIMITER $$
DROP FUNCTION IF EXISTS get_hipotenusa $$
CREATE FUNCTION get_hipotenusa(cateto_a DOUBLE, cateto_b DOUBLE) RETURNS DOUBLE
	BEGIN
		DECLARE hipotenusa DOUBLE;
		SET hipotenusa = POW((POW(cateto_a,2)+POW(cateto_b,2)),1/2);
		RETURN hipotenusa;
	END
$$

SELECT get_hipotenusa(2,4)$$


/*3. Escribe una función que reciba como parámetro de entrada un valor numérico que represente un 
día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente. 
Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.*/

DELIMITER $$
DROP FUNCTION IF EXISTS diaSemana $$
CREATE FUNCTION diaSemana(x INT) RETURNS VARCHAR(20)
	BEGIN 
		DECLARE dia VARCHAR(20);
		CASE x
			WHEN 1 THEN SET dia = 'LUNES';
			WHEN 2 THEN SET dia = 'MARTES';
			WHEN 3 THEN SET dia = 'MIERCOLES';
			WHEN 4 THEN SET dia = 'JUEVES';
			WHEN 5 THEN SET dia = 'VIERNES';
			WHEN 6 THEN SET dia = 'SABADO';
			WHEN 7 THEN SET dia = 'DOMINGO';
			ELSE 
				SET dia = 'Dia incorrecto';
		END CASE;
		RETURN dia;
	END
$$
SELECT diaSemana(0)$$

/*4. Escribe una función que reciba tres números reales como parámetros de entrada y devuelva el mayor de los tres.*/

DELIMITER $$
DROP FUNCTION IF EXISTS getMayorNum $$
CREATE FUNCTION getMayorNum(num1 DOUBLE, num2 DOUBLE, num3 DOUBLE) RETURNS DOUBLE
	BEGIN 
		DECLARE mayor_num DOUBLE DEFAULT 0;
		IF (num1 > num2 AND num1 > num3) THEN
			SET mayor_num = num1;
		ELSEIF (num2 > num3) THEN
			SET mayor_num = num2;
		ELSE 
			SET mayor_num = num3;
		END IF;
		RETURN mayor_num;
	END
$$

SELECT getMayorNum(1.14, 2.14, 2.15)$$


/*5. Escribe una función que devuelva el valor del área de un círculo a partir del valor del radio que se recibirá como parámetro de entrada.*/

DELIMITER $$
DROP FUNCTION IF EXISTS getCircleArea $$
CREATE FUNCTION getCircleArea(radio DOUBLE) RETURNS DOUBLE 
	BEGIN
		DECLARE area_circulo DOUBLE DEFAULT 0;
		SET area_circulo = (PI()*POW(radio,2));
		RETURN area_circulo;
	END
$$

SELECT getCircleArea(4.2)$$


/*6. Escribe una función que devuelva como salida el número de años que han transcurrido entre dos fechas que se reciben como parámetros de entrada. 
Por ejemplo, si pasamos como parámetros de entrada las fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que han pasado 10 años.

Para realizar esta función puede hacer uso de las siguientes funciones que nos proporciona MySQL:

DATEDIFF
TRUNCATE*/


DELIMITER $$
DROP FUNCTION IF EXISTS getYearDifference $$
CREATE FUNCTION getYearDifference(fecha_1 DATE, fecha_2 DATE) RETURNS DOUBLE 
	BEGIN
		DECLARE diferencia DOUBLE DEFAULT 0;
		SET diferencia = ABS(TRUNCATE((DATEDIFF(fecha_1,fecha_2)/365),0));
		RETURN diferencia;
	END 
$$

SELECT getYearDifference('2019-01-01','2019-12-01')$$


/*7. Escribe una función que reciba una cadena de entrada y devuelva la misma cadena pero sin acentos. 
La función tendrá que reemplazar todas las vocales que tengan acento por la misma vocal pero sin acento.
Por ejemplo, si la función recibe como parámetro de entrada la cadena María la función debe devolver la cadena Maria.*/

DELIMITER $$
DROP FUNCTION IF EXISTS get_sin_acentos $$
CREATE FUNCTION get_sin_acentos(frase VARCHAR(50)) RETURNS VARCHAR(50)
    BEGIN
        DECLARE frase_sin_acentos VARCHAR(50);
        SET frase_sin_acentos= REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(frase, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u');
        RETURN frase_sin_acentos;
    END
$$

SELECT get_sin_acentos('Buenos días María de los Doólóres.')$$
		



/*Funciones con sentencia SQL

1. Escribe una función para la base de datos tienda que devuelva el número total de productos 
que hay en la tabla productos.*/

DELIMITER $$
USE tienda $$
DROP FUNCTION IF EXISTS getCountProductos $$
CREATE FUNCTION getCountProductos() RETURNS INT
	BEGIN 
		RETURN(
					SELECT COUNT(codigo) 
					FROM producto
				);
	END
$$
SELECT getCountProductos() $$


/*2. Escribe una función para la base de datos tienda que devuelva el valor medio del precio de los productos 
de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del
fabricante.*/

DELIMITER $$
USE tienda $$
DROP FUNCTION IF EXISTS getValorMedio $$
CREATE FUNCTION getValorMedio(f VARCHAR(15)) RETURNS DOUBLE
	BEGIN 
		RETURN 	(
						SELECT AVG(precio)
						FROM producto
						INNER JOIN fabricante
						ON producto.codigo_fabricante = fabricante.codigo
						WHERE fabricante.nombre = f
					);
	END 
$$
SELECT getValorMedio('Asus') $$


/*3. Escribe una función para la base de datos tienda que devuelva el valor máximo del precio de los productos de un determinado 
fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.*/

DELIMITER $$
DROP FUNCTION IF EXISTS getMaxPrice $$
CREATE FUNCTION getMaxPrice(fabricante_consulta VARCHAR(100)) RETURNS DOUBLE
	BEGIN
		DECLARE max_precio DOUBLE DEFAULT 0;
		SELECT MAX(precio)
		INTO max_precio
		FROM producto
		INNER JOIN fabricante
		ON fabricante.codigo = producto.codigo_fabricante
		WHERE fabricante_consulta = fabricante.nombre;
		RETURN max_precio;
	END
$$

SELECT getMaxPrice('Asus')$$


/*4. Escribe una función para la base de datos tienda que devuelva el valor mínimo del precio de los productos de un determinado 
fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.*/

DELIMITER $$
DROP FUNCTION IF EXISTS getMinPrice $$
CREATE FUNCTION getMinPrice(fabricante_consulta VARCHAR(100)) RETURNS DOUBLE
	BEGIN
		DECLARE min_precio DOUBLE DEFAULT 0;
		SELECT MIN(precio)
		INTO min_precio
		FROM producto
		INNER JOIN fabricante
		ON fabricante.codigo = producto.codigo_fabricante
		WHERE fabricante_consulta = fabricante.nombre;
		RETURN min_precio;
	END
$$

SELECT getMinPrice('Asus')$$ 


