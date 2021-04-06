-- EJERCICIOS PDF

USE jardineria;

/*1. Crear un procedimiento que sirva para listar los códigos y nombres de los clientes*/

DELIMITER $$
CREATE PROCEDURE getCodNombreCliente()
	BEGIN 
		SELECT codigo_cliente, nombre_cliente
		FROM cliente;
	END 
$$
	
/*2. Mostrar el procedimiento del apartado 1*/

SHOW PROCEDURE STATUS 
WHERE DB = 'jardineria';

/*3. Invocar (llamar) al procedimiento del apartado 1*/

CALL jardineria.getCodNombreCliente;

/*4. Modificar el procedimiento (comentario)*/

ALTER PROCEDURE getCodNombreCliente
COMMENT 'MUESTRA EL CODIGO Y NOMBRE DE LOS CLIENTES';

/*5. Crear un procedimiento de prueba y borrarlo*/

DELIMITER $$

CREATE PROCEDURE getNombre()
	BEGIN 
		SELECT nombre_cliente
		FROM cliente;
	END
$$

DROP PROCEDURE getNombre;

/*6. Crea un procedimiento que muestre cuántos productos pertenecen a la gama ‘Herbáceas’*/

DELIMITER $$

CREATE PROCEDURE getProductosHerramientas()
	BEGIN 
		DECLARE numHerramienta INT DEFAULT 0;
		SELECT COUNT(gama)
		INTO numHerramienta
		FROM producto
		WHERE gama = 'Herramientas';
		SELECT numHerramienta;
	END
$$

/* a. Modifica el procedimiento anterior y añádele un comentario que describa lo
que devuelve el procedimiento.*/

ALTER PROCEDURE getProductosHerbaceos 
COMMENT 'Muestra el numero de productos que son de la gama Herramienta.';

/* b. Ejecuta el procedimiento para comprobar que funciona*/

CALL getProductosHerbaceos;

/* c. Muestra con una orden SQL, el contenido del procedimiento*/

SHOW PROCEDURE STATUS
WHERE DB = 'jardineria';


/*7. Crea un procedimiento que muestre el nombre de los empleados que estén
trabajando en la oficina de Barcelona*/
 
DELIMITER $$

CREATE PROCEDURE getNombreEmpleados()
	BEGIN 
		SELECT empleado.nombre
		FROM empleado
		INNER JOIN oficina
		ON empleado.codigo_oficina = oficina.codigo_oficina
		WHERE oficina.ciudad = 'Barcelona';
	END
$$

/*a. Ejecuta el procedimiento para comprobar que funciona*/	

CALL getNombreEmpleados();


/*8. Crea un procedimiento que muestre el listado de los productos cuyo stock supere los 100*/

DELIMITER $$

CREATE PROCEDURE getProductosList(x INT)
	BEGIN 
		SELECT *
		FROM producto
		WHERE cantidad_en_stock > x;
	END 
$$

/*a. Ejecuta el procedimiento para comprobar que funciona*/

CALL getProductosList(100);


/*9. Crea y muestra un procedimiento que nos de todos los datos de los productos que
tienen un precio mayor a x (x se va a recibir por parámetro en el procedimiento)*/

DELIMITER $$

CREATE PROCEDURE getProductosList_precio(x INT)
	BEGIN 
		SELECT *
		FROM producto
		WHERE precio_venta > x;
	END 
$$


/*10. Crea un procedimiento al que se le pase como parámetro la ciudad del cliente y nos
muestre el nombre y teléfono de esos clientes*/

DELIMITER $$
DROP PROCEDURE IF EXISTS getNombreTelefono $$
CREATE PROCEDURE getNombreTelefono(x VARCHAR(25))
	BEGIN 
		SELECT nombre_cliente, telefono
		FROM cliente 
		WHERE x IN (
								SELECT ciudad
								FROM cliente
							);
	END
$$


/*11. Crea e invoca a un procedimiento que salude con la frase “Hola, buenos días”,
tantas veces como indique el parámetro num que recibe por parámetro.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS holaBuenosDias $$
CREATE PROCEDURE holaBuenosDias(x INT)
	BEGIN 
		DECLARE contador INT;
		SET contador = 0;
		WHILE (contador <> x) DO
			SELECT 'Hola, buenos dias';
			SET contador = contador + 1;
		END WHILE;
	END
$$
CALL holaBuenosDias(3) $$


