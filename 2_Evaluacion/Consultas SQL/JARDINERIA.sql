SELECT codigo_oficina, ciudad
FROM oficina
WHERE ciudad IS NOT NULL;

SELECT ciudad, telefono
FROM oficina;

SELECT estado
FROM pedido 
GROUP BY estado;

SELECT codigo_cliente
FROM pago
WHERE YEAR(fecha_pago) = 2008;

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido 
WHERE fecha_entrega > fecha_esperada;

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE ADDDATE(fecha_entrega,2) <= fecha_esperada;

SELECT pago.fecha_pago, cliente.nombre_cliente, empleado.codigo_empleado
FROM cliente 
INNER JOIN pago 
ON cliente.codigo_cliente=pago.codigo_cliente
INNER JOIN empleado
ON cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado;

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2
FROM cliente
INNER JOIN empleado
ON cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado;

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2
FROM cliente
INNER JOIN empleado
ON cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado;