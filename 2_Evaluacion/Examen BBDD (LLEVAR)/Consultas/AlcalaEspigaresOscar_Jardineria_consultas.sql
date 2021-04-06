/*------------------------------------------------------Consultas sobre una tabla--------------------------------------------------------*/

/*1.Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.*/
SELECT codigo_oficina, ciudad 
FROM oficina;

/*2.Devuelve un listado con la ciudad y el teléfono de las oficinas de España.*/
SELECT ciudad, telefono 
FROM oficina
WHERE pais='España';

/*3.Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.*/
SELECT nombre, apellido1, apellido2, email 
FROM empleado 
WHERE codigo_jefe=7;

/*4.Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.*/
SELECT nombre, apellido1, apellido2, email 
FROM empleado
WHERE codigo_jefe IS NULL;

/*5.Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.*/
SELECT nombre, apellido1, apellido2, puesto 
FROM empleado
WHERE NOT puesto='Representante Ventas';

/*6.Devuelve un listado con el nombre de los todos los clientes españoles.*/
SELECT nombre 
FROM clientes
WHERE pais='Spain';

/*7.Devuelve un listado con los distintos estados por los que puede pasar un pedido.*/
SELECT estado 
FROM pedido
GROUP BY estado;

/*8.Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008.
Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos.*/
SELECT DISTINCT codigo_cliente 
FROM pago
WHERE YEAR(fecha_pago)=2008;

SELECT DISTINCT codigo_cliente 
FROM pago
WHERE DATE_FORMAT(fecha_pago, '%Y')=2008; 

SELECT DISTINCT codigo_cliente 
FROM pago
WHERE fecha_pago BETWEEN '2008/01/01' AND '2008/12/31';

/*9.Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.*/
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
FROM pedido
WHERE  fecha_entrega>fecha_esperada;

/*10.Devuelve un listado con el código de pedido, código de cliente, fecha esperada
 y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.*/
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
FROM pedido 
WHERE ADDDATE(fecha_entrega, 2)<=fecha_esperada;

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
FROM pedido 
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >=2;

/*11.Devuelve un listado de todos los pedidos que fueron rechazados en 2009*/
SELECT * 
FROM pedido
WHERE estado='Rechazado' AND YEAR(fecha_entrega)=2009;

/*12.Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.*/
SELECT * 
FROM pedido
WHERE estado='Entregado' AND MONTH(fecha_entrega)=01;

/*13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.*/
SELECT id_transaccion 
FROM pago 
WHERE YEAR(fecha_pago)=2008 AND forma_pago='Paypal'
ORDER BY id_transaccion DESC;

/*14.Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.*/
SELECT forma_pago FROM pago
GROUP BY forma_pago;

/*15.Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock.
 El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.*/
SELECT * 
FROM producto
WHERE gama='Ornamentales' AND cantidad_en_stock > 100
ORDER BY precio_venta DESC;

/*16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.*/
SELECT codigo_cliente 
FROM cliente 
WHERE ciudad='Madrid' AND (codigo_empleado_rep_ventas=11 OR codigo_empleado_rep_ventas=30);








/*-------------------------------------Consultas multitabla (Composición interna)------------------------------------------------------*/

/*1.Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.*/
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 
FROM cliente c, empleado e
WHERE c.codigo_empleado_rep_ventas=e.codigo_empleado;

SELECT nombre_cliente, nombre, apellido1, apellido2 
FROM cliente INNER JOIN empleado
ON codigo_empleado_rep_ventas=codigo_empleado;



/*2.Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.*/
SELECT c.nombre_cliente, e.nombre 
FROM cliente c,pago p, empleado e
WHERE c.codigo_cliente=p.codigo_cliente AND c.codigo_empleado_rep_ventas=e.codigo_empleado;

SELECT nombre_cliente, nombre 
FROM cliente INNER JOIN pago INNER JOIN empleado 
ON cliente.codigo_cliente=pago.codigo_cliente
WHERE codigo_empleado_rep_ventas=codigo_empleado;



/*3.Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.*/
SELECT c.nombre_cliente, e.nombre FROM cliente c, empleado e
WHERE c.codigo_empleado_rep_ventas=e.codigo_empleado AND c.codigo_cliente NOT IN 
	(
		SELECT codigo_cliente FROM pago
	);
 
SELECT nombre_cliente, nombre 
FROM cliente INNER JOIN empleado
ON codigo_empleado_rep_ventas=codigo_empleado 
WHERE codigo_cliente NOT IN 
	(
		SELECT codigo_cliente FROM pago
	);



/*4.Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.*/
SELECT c.nombre_cliente, e.nombre, o.ciudad  FROM cliente c,pago p, empleado e, oficina o
WHERE c.codigo_cliente=p.codigo_cliente AND c.codigo_empleado_rep_ventas=e.codigo_empleado AND e.codigo_oficina=o.codigo_oficina;



SELECT nombre_cliente, nombre, o.ciudad  
FROM cliente c INNER JOIN pago p 
ON c.codigo_cliente=p.codigo_cliente
INNER JOIN empleado e 
ON c.codigo_empleado_rep_ventas=e.codigo_empleado
INNER JOIN oficina o
ON e.codigo_oficina=o.codigo_oficina;




/*5.Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.*/
SELECT c.nombre_cliente, e.nombre, o.ciudad 
FROM cliente c, empleado e, oficina o
WHERE c.codigo_empleado_rep_ventas=e.codigo_empleado AND e.codigo_oficina=o.codigo_oficina AND c.codigo_cliente 
NOT IN
	(
		SELECT codigo_cliente FROM pago
	);



SELECT nombre_cliente, nombre, o.ciudad 
FROM cliente c INNER JOIN empleado e 
ON c.codigo_empleado_rep_ventas=e.codigo_empleado
INNER JOIN oficina o
ON e.codigo_oficina=o.codigo_oficina 
WHERE codigo_cliente 
NOT IN
	(
		SELECT codigo_cliente FROM pago
	);



/*6.Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.*/
SELECT DISTINCT o.linea_direccion1, o.linea_direccion2 
FROM oficina o, cliente c, empleado e
WHERE o.codigo_oficina=e.codigo_oficina AND c.codigo_empleado_rep_ventas=e.codigo_empleado AND c.ciudad='Fuenlabrada';



SELECT DISTINCT o.linea_direccion1, o.linea_direccion2 
FROM oficina o INNER JOIN cliente c 
ON o.codigo_oficina=e.codigo_oficina
INNER JOIN empleado e
ON c.codigo_empleado_rep_ventas=e.codigo_empleado 
WHERE c.ciudad='Fuenlabrada';



/*7.Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.*/
SELECT c.nombre_cliente, e.nombre, o.ciudad 
FROM cliente c, empleado e, oficina o
WHERE c.codigo_empleado_rep_ventas=e.codigo_empleado AND e.codigo_oficina= o.codigo_oficina;

SELECT nombre_cliente, nombre, o.ciudad 
FROM cliente c INNER JOIN empleado e 
ON codigo_empleado_rep_ventas=codigo_empleado
INNER JOIN oficina o
ON e.codigo_oficina= o.codigo_oficina;


/*8.Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.*/
SELECT e.nombre AS nombre_empleado, j.nombre AS nombre_jefe 
FROM empleado e, empleado j
WHERE j.codigo_empleado=e.codigo_jefe;

SELECT e.nombre AS nombre_empleado, j.nombre AS nombre_jefe 
FROM empleado e INNER JOIN empleado j
ON j.codigo_empleado=e.codigo_jefe;


/*9.Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.*/
SELECT c.nombre_cliente 
FROM cliente c, pedido p
WHERE p.fecha_entrega>p.fecha_esperada AND c.codigo_cliente=p.codigo_cliente;


SELECT c.nombre_cliente 
FROM cliente c INNER JOIN pedido p
ON c.codigo_cliente=p.codigo_cliente
WHERE p.fecha_entrega>p.fecha_esperada;




/*10.Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.*/
SELECT DISTINCT g.gama, c.nombre_cliente 
FROM gama_producto g, cliente c, pedido p, detalle_pedido d, producto k
WHERE c.codigo_cliente= p.codigo_cliente AND p.codigo_pedido=d.codigo_pedido AND d.codigo_producto=k.codigo_producto;


SELECT DISTINCT g.gama, c.nombre_cliente 
FROM gama_producto g INNER JOIN cliente c INNER JOIN pedido p 
ON c.codigo_cliente= p.codigo_cliente
INNER JOIN detalle_pedido d 
ON p.codigo_pedido=d.codigo_pedido
INNER JOIN producto k
ON d.codigo_producto=k.codigo_producto;







/*-----------------------------------------------------------------------Consultas resumen----------------------------------------------------------*/

/*1.¿Cuántos empleados hay en la compañía?*/
SELECT COUNT(codigo_empleado) AS NumeroEmpleados 
FROM empleado;

/*2.¿Cuántos clientes tiene cada país?*/
SELECT COUNT(codigo_cliente) AS numeroClientes, pais 
FROM cliente
GROUP BY pais;

/*3.¿Cuál fue el pago medio en 2009?*/
SELECT AVG(total) AS media2009 
FROM pago
WHERE YEAR(fecha_pago)=2009;

/*4.¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.*/
SELECT COUNT(codigo_pedido) AS numeroPedidos, estado 
FROM pedido
GROUP BY estado
ORDER BY numeroPedidos DESC;


/*5.Calcula el precio de venta del producto más caro y más barato en una misma consulta.*/
SELECT MAX(precio_venta) AS maximoPrecio, MIN(precio_venta) AS minimoPrecio 
FROM producto;


/*6.Calcula el número de clientes que tiene la empresa.*/
SELECT COUNT(codigo_cliente) AS numeroClientes 
FROM cliente;


/*7.¿Cuántos clientes tiene la ciudad de Madrid?*/
SELECT COUNT(codigo_cliente) AS numeroClientes 
FROM cliente
WHERE ciudad='Madrid';


/*8.¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?*/
SELECT COUNT(codigo_cliente) AS numeroClientes, ciudad 
FROM cliente
WHERE ciudad LIKE 'M%'
GROUP BY ciudad;


/*9.Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.*/
SELECT DISTINCT e.nombre, COUNT(c.codigo_cliente) 
FROM empleado e, cliente c
WHERE e.codigo_empleado=c.codigo_empleado_rep_ventas
GROUP BY nombre;



/*10.Calcula el número de clientes que no tiene asignado representante de ventas.*/
SELECT COUNT(codigo_cliente) 
FROM cliente 
WHERE codigo_empleado_rep_ventas IS NULL;


/*11.Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.*/
SELECT c.nombre_contacto, MIN(p.fecha_pago) AS primer_pago, MAX(p.fecha_pago) AS segundo_pago
FROM cliente c INNER JOIN pago p  
ON p.codigo_cliente=c.codigo_cliente
GROUP BY c.nombre_contacto;


/*12.Calcula el número de productos diferentes que hay en cada uno de los pedidos.*/
SELECT DISTINCT codigo_pedido, COUNT(codigo_producto) AS numeroProductosDiferentes
FROM detalle_pedido
GROUP BY codigo_pedido;



/*13.Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.*/
SELECT DISTINCT codigo_pedido, SUM(cantidad) AS cantidadProductos 
FROM detalle_pedido
GROUP BY codigo_pedido;



/*14.Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.*/
SELECT codigo_producto, SUM(cantidad) AS cantidadTotal 
FROM detalle_pedido
GROUP BY codigo_producto
ORDER BY cantidadTotal DESC
LIMIT 0,20;



/*15.La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. 
La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. 
El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.*/
SELECT SUM(d.precio_unidad*d.cantidad) AS baseImponible, SUM(d.precio_unidad*d.cantidad*21/100) AS IVA, SUM(d.precio_unidad*d.cantidad+d.precio_unidad*d.cantidad*21/100) AS totalFacturado
FROM detalle_pedido d;




/*16.La misma información que en la pregunta anterior, pero agrupada por código de producto.*/
SELECT d.codigo_producto, SUM(d.precio_unidad*d.cantidad) AS baseImponible, SUM(d.precio_unidad*d.cantidad*21/100) AS IVA, SUM(d.precio_unidad*d.cantidad+d.precio_unidad*d.cantidad*21/100) AS totalFacturado
FROM detalle_pedido d
GROUP BY d.codigo_producto;




/*17.La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.*/
SELECT d.codigo_producto, SUM(d.precio_unidad*d.cantidad) AS baseImponible, SUM(d.precio_unidad*d.cantidad*21/100) AS IVA, SUM(d.precio_unidad*d.cantidad+d.precio_unidad*d.cantidad*21/100) AS totalFacturado
FROM detalle_pedido d
WHERE d.codigo_producto LIKE 'OR%'
GROUP BY d.codigo_producto;





/*18.Lista las ventas totales de los productos que hayan facturado más de 3000 euros.
 Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).*/
 SELECT p.nombre, SUM(d.cantidad) AS unidadesVendidas, (d.precio_unidad*d.cantidad) AS totalFacturado, (d.precio_unidad*d.cantidad-(d.precio_unidad*d.cantidad*21/100)) AS totalFacturadoConImpuestos
 FROM detalle_pedido d INNER JOIN producto p
 ON d.codigo_producto=p.codigo_producto 
 WHERE (d.precio_unidad*d.cantidad)>3000
 GROUP BY p.nombre;
 
 
 
/*--------------------------------------------------Subconsultas-------------------------------------------------------*/

/*---------------------------------------Con operadores básicos de comparación--------------------------------------------*/
 
 
 
/*1.Devuelve el nombre del cliente con mayor límite de crédito.*/
SELECT nombre_cliente
FROM cliente 
WHERE limite_credito=
	(
		SELECT MAX(limite_credito) FROM cliente
	);	



/*2.Devuelve el nombre del producto que tenga el precio de venta más caro.*/
SELECT nombre 
FROM producto
WHERE precio_venta=
	(
		SELECT MAX(precio_venta) 
		FROM producto
	);


/*3.Devuelve el nombre del producto del que se han vendido más unidades.
(Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido.
Una vez que sepa cuál es el código del producto, puede obtener su nombre fácilmente.)*/


SELECT t.nombre, t.cantidad
FROM (SELECT p.nombre nombre, SUM(d.cantidad) cantidad FROM producto p
LEFT JOIN detalle_pedido d 
ON d.codigo_producto = p.codigo_producto
GROUP BY p.codigo_producto
ORDER BY cantidad DESC LIMIT 1) AS t;


SELECT p.nombre, SUM(cantidad) AS vendidos
FROM detalle_pedido d INNER JOIN producto p
ON d.codigo_producto=p.codigo_producto
GROUP BY p.codigo_producto
ORDER BY vendidos DESC
LIMIT 1;


/*4.Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).*/
SELECT codigo_cliente 
FROM cliente
WHERE limite_credito> 
	(
		SELECT SUM(total)
		FROM pago
		WHERE pago.codigo_cliente=cliente.codigo_cliente 
	);


/*5.Devuelve el producto que más unidades tiene en stock.*/
SELECT codigo_producto 
FROM producto
WHERE cantidad_en_stock=
	(
		SELECT MAX(cantidad_en_stock)
		FROM producto
	);


/*6.Devuelve el producto que menos unidades tiene en stock.*/
SELECT codigo_producto 
FROM producto
WHERE cantidad_en_stock=
	(
		SELECT MIN(cantidad_en_stock)
		FROM producto
	);



/*7.Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.*/
SELECT nombre, apellido1, apellido2
FROM empleado 
WHERE codigo_jefe=
	(
		SELECT codigo_empleado 
		FROM empleado
		WHERE nombre='Alberto' AND apellido1='Soria'
	);
	
	
	
 
/*----------------------------------------Subconsultas con ALL y ANY------------------------------------------------*/


/*8.Devuelve el nombre del cliente con mayor límite de crédito.*/
SELECT nombre_cliente
FROM cliente 
WHERE limite_credito= ALL
	(
		SELECT MAX(limite_credito) 
		FROM cliente
	);



/*9.Devuelve el nombre del producto que tenga el precio de venta más caro.*/
SELECT nombre 
FROM producto
WHERE precio_venta= ALL
	(
		SELECT MAX(precio_venta) 
		FROM producto
	);



/*10.Devuelve el producto que menos unidades tiene en stock.*/
SELECT codigo_producto
FROM producto
WHERE cantidad_en_stock= ALL 
	(
		SELECT MIN(cantidad_en_stock)
		FROM producto
	);


/*--------------------------------------------Subconsultas con IN y NOT IN------------------------------------------*/

/*11.Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.*/
SELECT nombre, apellido1, puesto
FROM empleado
WHERE codigo_empleado 
NOT IN
	(
		SELECT codigo_empleado_rep_ventas
		FROM cliente
	);



/*12.Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.*/
SELECT * 
FROM cliente 
WHERE codigo_cliente
NOT IN 
	(
		SELECT codigo_cliente 
		FROM pago
	);



/*13.Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.*/
SELECT * 
FROM cliente 
WHERE codigo_cliente 
IN 
	(
		SELECT codigo_cliente 
		FROM pago
	);



/*14.Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
SELECT * 
FROM producto 
WHERE codigo_producto 
NOT IN
	(
		SELECT codigo_producto
		FROM detalle_pedido
	);



/*15.Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.*/
SELECT nombre, apellido1, apellido2, puesto, telefono 
FROM empleado e 
INNER JOIN oficina o
ON e.codigo_oficina=o.codigo_oficina
WHERE codigo_empleado 
NOT IN
	(
		SELECT codigo_empleado_rep_ventas
		FROM cliente
	);




/*16.Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.*/
SELECT codigo_oficina 
FROM oficina
WHERE codigo_oficina 
NOT IN
	(
		SELECT codigo_oficina 
		FROM empleado
		WHERE codigo_empleado 
		IN
		(
			SELECT codigo_empleado_rep_ventas
			FROM cliente
			WHERE codigo_cliente
			IN
				(
					SELECT codigo_cliente
					FROM pedido
					WHERE codigo_pedido
					IN
						(
							SELECT codigo_pedido
							FROM detalle_pedido
							WHERE codigo_producto
							IN 
								(
									SELECT codigo_producto
									FROM producto
									WHERE gama='Frutales'
								)
						)
				)
		)
	);
	


/*17.Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.*/

SELECT codigo_cliente 
FROM cliente
WHERE codigo_cliente 
IN
	(
		SELECT codigo_cliente 
		FROM pedido
	)
AND codigo_cliente 
NOT IN
	(
		SELECT codigo_cliente 
		FROM pago
	);

/*-------------------------------------------------Subconsultas con EXISTS y NOT EXISTS----------------------------------------------------------*/

/*18.Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.*/
SELECT codigo_cliente 
FROM cliente 
WHERE NOT EXISTS 
	(
		SELECT codigo_cliente
		FROM pago
		WHERE cliente.codigo_cliente=pago.codigo_cliente
	);


/*19.Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.*/
SELECT codigo_cliente 
FROM cliente 
WHERE EXISTS 
	(
		SELECT codigo_cliente
		FROM pago
		WHERE cliente.codigo_cliente=pago.codigo_cliente
	);




/*20.Devuelve un listado de los productos que nunca han aparecido en un pedido.*/

SELECT codigo_producto, nombre
FROM producto
WHERE NOT EXISTS
	(
		SELECT codigo_producto
		FROM detalle_pedido
		WHERE producto.codigo_producto=detalle_pedido.codigo_producto
	);
	
	




/*21.Devuelve un listado de los productos que han aparecido en un pedido alguna vez.*/
SELECT codigo_producto, nombre
FROM producto
WHERE EXISTS
	(
		SELECT codigo_producto
		FROM detalle_pedido
		WHERE producto.codigo_producto=detalle_pedido.codigo_producto
	);





/*------------------------------------------------------------Consultas variadas---------------------------------------------------------------------*/



/*1.Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado.
 Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.*/
 
 SELECT c.codigo_cliente, COUNT(p.codigo_cliente) AS numero_pedidos_realizados
 FROM cliente c 
 INNER JOIN pedido p 
 ON c.codigo_cliente=p.codigo_cliente
 GROUP BY c.codigo_cliente;
 
 
 
/*2.Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos.
Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.*/

SELECT c.nombre_cliente, SUM(p.total)
FROM cliente c 
INNER JOIN pago p 
ON c.codigo_cliente=p.codigo_cliente
GROUP BY c.codigo_cliente;





/*3.Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.*/
SELECT nombre_cliente 
FROM cliente
WHERE codigo_cliente 
IN 
	(
		SELECT codigo_cliente FROM pedido
		WHERE YEAR(fecha_pedido)=2008
	)
ORDER BY nombre_cliente DESC;



/*4.Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.*/
SELECT c.nombre_cliente, e.nombre, e.apellido1 , o.telefono
FROM cliente c INNER JOIN empleado e 
ON c.codigo_empleado_rep_ventas=e.codigo_empleado 
INNER JOIN oficina o
ON e.codigo_oficina=o.codigo_oficina
WHERE c.codigo_cliente 
NOT IN
	(
		SELECT codigo_cliente 
		FROM pago  
	);



/*5.Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.*/
SELECT c.nombre_cliente, e.nombre, e.apellido1 , o.ciudad
FROM cliente c INNER JOIN empleado e 
ON c.codigo_empleado_rep_ventas=e.codigo_empleado 
INNER JOIN oficina o
ON e.codigo_oficina=o.codigo_oficina;




/*6.Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.*/
SELECT e.nombre, e.apellido1, e.apellido2, e.puesto, o.telefono 
FROM empleado e INNER JOIN oficina o
ON e.codigo_oficina=o.codigo_oficina
WHERE e.codigo_empleado 
NOT IN 
	(
		SELECT codigo_empleado_rep_ventas FROM cliente
	);


/*7.Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.*/
SELECT o.ciudad, COUNT(e.codigo_empleado) AS numero_empleados
FROM oficina o INNER JOIN empleado e
ON o.codigo_oficina=e.codigo_oficina
GROUP BY o.ciudad;









