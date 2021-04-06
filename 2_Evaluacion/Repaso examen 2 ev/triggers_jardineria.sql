-- Diseña disparadores para controlar las siguientes acciones utilizando la BD jardineria https://gist.github.com/josejuansanchez/c408725e848afd64dd9a20ab37fba8c9

-- 1. Cuando se modifique el estado de alguno de los pedidos que están en la BD de "pendiente" a "entregado" se debe guardar como fecha de entrega la actual




-- 2. No se debe permitir insertar un pedido si la fecha esperada de entrega es anterior a la fecha de pedido


-- 3. Queremos modificar el stock de un producto cuando se realice la entrega de éste. Tener en cuenta que en detalle_pedido se detalla la cantidad que se compra del producto.


/* 4. El límite de crédito es un límite que se le asigna a cada cliente, según sus necesidades, para que no lo sobrepase al realizar 
compras. Vamos a comprobarlo de dos formas (la primera más sencilla):
a- Comprobamos que no se supera ese límite cuando el cliente realiza un pedido.
b- Consideremos que el límite es mensual, por tanto, tenemos que comprobar si el límite se ha superado teniendo en cuenta 
todos los pedidos que se han realizado en el mes en curso.
*/

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_credito_maximo_before_insert$$
CREATE TRIGGER trigger_check_credito_maximo_before_insert
BEFORE INSERT
ON detalle_pedido FOR EACH ROW
BEGIN
	DECLARE credito_max_cliente DOUBLE(15,2);
	SELECT cliente.limite_credito
	INTO credito_max_cliente
	FROM cliente
	INNER JOIN pedido
	ON pedido.codigo_cliente = cliente.codigo_cliente
	WHERE pedido.codigo_pedido = NEW.codigo_pedido;
	
	IF (credito_max_cliente < (NEW.cantidad*NEW.precio_unidad)) THEN
		UPDATE cliente
		SET cliente.limite_credito = (NEW.cantidad*precio_unidad);
	END IF;
END
$$