USE jardineria;

/*CREAR PROCEDIMIENTO*/

DELIMITER $$

CREATE PROCEDURE clientes_getList()
BEGIN 
	SELECT codigo_cliente, nombre_cliente
	FROM cliente;
END 
$$

/*LLAMAMOS AL PROCEDIMIENTO*/

CALL clientes_getList();

/*MOSTRAR PROCEDIMIENTOS*/

SHOW PROCEDURE STATUS
WHERE DB = 'jardineria';

/*ALTERAR PROCEDIMIENTO*/

ALTER PROCEDURE clientes_getList
COMMENT 'MUESTRA EL LISTADO DE LOS CLIENTES';

/*BORRAR PROCEDIMIENTO*/

DROP PROCEDURE IF EXISTS clientes_getList;


/*CREAR PROCEDIMIENTOS AL QUE SE LE PASEN VALORES*/

DELIMITER $$

CREATE PROCEDURE productos_getListMayores(x INT)
BEGIN 
	SELECT *
	FROM producto
	WHERE precio_venta > x;
END
$$

CALL productos_getListMayores(50);

