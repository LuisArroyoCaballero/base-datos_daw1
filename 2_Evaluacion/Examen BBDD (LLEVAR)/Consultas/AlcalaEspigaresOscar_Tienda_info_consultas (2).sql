/*-----------------------------------1.1.4 Consultas multitabla (Composición interna)----------------------------*/
/*---------------------------Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.--------------------------*/

/*1.Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.*/
SELECT p.nombre, p.precio, f.nombre
FROM fabricante f, producto p
WHERE p.codigo_fabricante=f.codigo;


SELECT p.nombre, p.precio, f.nombre
FROM fabricante f INNER JOIN producto p
ON p.codigo_fabricante=f.codigo;

/*2.Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
 Ordene el resultado por el nombre del fabricante, por orden alfabético.*/
SELECT p.nombre, p.precio, f.nombre
FROM fabricante f, producto p
WHERE p.codigo_fabricante=f.codigo
ORDER BY p.nombre ASC;


SELECT p.nombre, p.precio, f.nombre
FROM fabricante f INNER JOIN producto p
ON p.codigo_fabricante=f.codigo
ORDER BY p.nombre ASC;


/*3.Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.*/
SELECT p.codigo, p.nombre, f.codigo, f.nombre
FROM fabricante f, producto p
WHERE p.codigo_fabricante=f.codigo;



SELECT p.codigo, p.nombre, f.codigo, f.nombre
FROM fabricante f INNER JOIN producto p
ON p.codigo_fabricante=f.codigo;



/*4.Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.*/
SELECT p.nombre, p.precio, f.nombre
FROM fabricante f, producto p
WHERE p.codigo_fabricante=f.codigo AND p.precio=
	(
		SELECT MIN(precio) 
		FROM producto 
	);




SELECT p.nombre, p.precio, f.nombre
FROM fabricante f INNER JOIN producto p
ON p.codigo_fabricante=f.codigo 
WHERE p.precio=
	(
		SELECT MIN(precio) 
		FROM producto 
	);




/*5.Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.*/
SELECT p.nombre, p.precio, f.nombre
FROM fabricante f, producto p
WHERE p.codigo_fabricante=f.codigo AND p.precio=
	(
		SELECT MAX(precio) 
		FROM producto 
	);


SELECT p.nombre, p.precio, f.nombre
FROM fabricante f INNER JOIN producto p
ON p.codigo_fabricante=f.codigo 
WHERE p.precio=
	(
		SELECT MAX(precio) 
		FROM producto 
	);

/*6.Devuelve una lista de todos los productos del fabricante Lenovo.*/
SELECT p.codigo, p.nombre
FROM fabricante f, producto p
WHERE f.codigo=p.codigo_fabricante AND f.nombre='Lenovo';


SELECT p.codigo, p.nombre
FROM fabricante f INNER JOIN producto p
ON f.codigo=p.codigo_fabricante 
WHERE f.nombre='Lenovo';




/*7.Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.*/
SELECT p.codigo, p.nombre
FROM fabricante f, producto p
WHERE f.codigo=p.codigo_fabricante AND f.nombre='Crucial' AND p.precio>200;


SELECT p.codigo, p.nombre
FROM fabricante f INNER JOIN producto p
ON f.codigo=p.codigo_fabricante 
WHERE f.nombre='Crucial' AND p.precio>200;




/*8.Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.*/
SELECT p.codigo, p.nombre
FROM fabricante f, producto p
WHERE f.codigo=p.codigo_fabricante AND (f.nombre='Asus' OR f.nombre='Hewlett-Packard' OR f.nombre='Seagate');


SELECT p.codigo, p.nombre
FROM fabricante f INNER JOIN producto p
ON f.codigo=p.codigo_fabricante 
WHERE f.nombre='Asus' OR f.nombre='Hewlett-Packard' OR f.nombre='Seagate';



/*9.Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.*/
SELECT p.codigo, p.nombre
FROM fabricante f, producto p
WHERE f.codigo=p.codigo_fabricante AND f.nombre IN('Asus','Hewlett-Packard','Seagate');


SELECT p.codigo, p.nombre
FROM fabricante f INNER JOIN producto p
ON f.codigo=p.codigo_fabricante 
WHERE f.nombre IN('Asus','Hewlett-Packard','Seagate');


/*10.Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.*/
SELECT p.nombre, p.precio
FROM fabricante f, producto p
WHERE f.codigo=p.codigo_fabricante AND f.nombre LIKE '%e';


SELECT p.nombre, p.precio
FROM fabricante f INNER JOIN producto p
ON f.codigo=p.codigo_fabricante 
WHERE f.nombre LIKE '%e';



/*11.Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.*/
SELECT p.nombre, p.precio
FROM fabricante f, producto p
WHERE f.codigo=p.codigo_fabricante AND f.nombre LIKE '%w%';



SELECT p.nombre, p.precio
FROM fabricante f INNER JOIN producto p
ON f.codigo=p.codigo_fabricante 
WHERE f.nombre LIKE '%w%';


/*12.Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€.
 Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)*/
SELECT p.nombre, p.precio, f.nombre
FROM fabricante f, producto p
WHERE f.codigo=p.codigo_fabricante AND p.precio>=180
ORDER BY p.precio DESC, p.nombre ASC;



SELECT p.nombre, p.precio, f.nombre
FROM fabricante f INNER JOIN producto p
ON f.codigo=p.codigo_fabricante 
WHERE p.precio>=180
ORDER BY p.precio DESC, p.nombre ASC;



/*13.Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.*/
SELECT f.codigo, f.nombre
FROM fabricante f, producto p
WHERE f.codigo=p.codigo_fabricante
GROUP BY f.codigo;

SELECT f.codigo, f.nombre
FROM fabricante f INNER JOIN producto p
ON f.codigo=p.codigo_fabricante
GROUP BY f.codigo;



/*-----------------------------------------------1.1.7 Subconsultas (En la cláusula WHERE)-----------------------------------------*/
/*-----------------------------------------------1.1.7.1 Con operadores básicos de comparación------------------------------------------*/


/*1.Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT codigo, nombre
FROM producto p
WHERE codigo_fabricante=
	(
		SELECT codigo 
		FROM fabricante
		WHERE nombre='Lenovo'
	);



/*2.Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT *
FROM producto
WHERE precio=
	(
		SELECT MAX(p.precio) 
		FROM fabricante f, producto p
		WHERE f.codigo=p.codigo_fabricante AND f.nombre='Lenovo'
	);


/*3.Lista el nombre del producto más caro del fabricante Lenovo.*/

SELECT nombre
FROM producto
WHERE codigo_fabricante=
	(
		SELECT codigo
		FROM fabricante 
		WHERE nombre='Lenovo'
	)
ORDER BY precio DESC
LIMIT 1;



/*4.Lista el nombre del producto más barato del fabricante Hewlett-Packard.*/
SELECT nombre
FROM producto
WHERE codigo_fabricante=
	(
		SELECT codigo
		FROM fabricante 
		WHERE nombre='Hewlett-Packard'
	)
ORDER BY precio ASC
LIMIT 1;


/*5.Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.*/
SELECT p.codigo, p.nombre
FROM producto p INNER JOIN fabricante f
ON p.codigo_fabricante=f.codigo
WHERE precio>=
	(
		SELECT MAX(p.precio)
		FROM producto p INNER JOIN fabricante f
		ON p.codigo_fabricante=f.codigo
		WHERE f.nombre='Lenovo'
	);





/*6.Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.*/
SELECT p.codigo, p.nombre 
FROM producto p INNER JOIN fabricante f
ON p.codigo_fabricante=f.codigo
WHERE f.nombre='Asus' AND precio>
	(
		SELECT AVG(p.precio)
		FROM producto p INNER JOIN fabricante f
		ON p.codigo_fabricante=f.codigo
		WHERE f.nombre='Asus'
	);


/*------------------------------------------1.1.7.2 Subconsultas con ALL y ANY------------------------------------------------*/

/*7.Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.*/
SELECT codigo, nombre 
FROM producto 
WHERE precio >= ALL
	(
		SELECT precio FROM producto
	);




/*8.Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.*/
SELECT codigo, nombre 
FROM producto 
WHERE precio <= ALL
	(
		SELECT precio FROM producto
	);



/*9.Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).*/
SELECT nombre
FROM fabricante
WHERE codigo= ANY
	(
		SELECT codigo_fabricante
		FROM producto
	);



/*10.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).*/
SELECT nombre
FROM fabricante
WHERE codigo<> ALL
	(
		SELECT codigo_fabricante
		FROM producto
	);




/*---------------------------------1.1.7.3 Subconsultas con IN y NOT IN---------------------------------------*/

/*11.Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).*/
SELECT nombre 
FROM fabricante 
WHERE codigo IN 
	(
		SELECT codigo_fabricante
		FROM producto
	);





/*12.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).*/
SELECT nombre 
FROM fabricante 
WHERE codigo NOT IN 
	(
		SELECT codigo_fabricante
		FROM producto
	);



/*----------------------------------1.1.7.4 Subconsultas con EXISTS y NOT EXISTS------------------------------*/

/*13.Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).*/
SELECT nombre 
FROM fabricante 
WHERE EXISTS 
	(
		SELECT codigo_fabricante
		FROM producto
		WHERE codigo_fabricante=fabricante.codigo
	);






/*14.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).*/
SELECT nombre 
FROM fabricante 
WHERE NOT EXISTS 
	(
		SELECT codigo_fabricante
		FROM producto
		WHERE codigo_fabricante=fabricante.codigo
	);




/*----------------------------------------1.1.7.5 Subconsultas correlacionadas------------------------------------*/
/*15.Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.*/
SELECT f.nombre,p.nombre, p.precio
FROM fabricante f INNER JOIN producto p
ON f.codigo=p.codigo_fabricante
WHERE precio=
	(
		SELECT MAX(p2.precio)
		FROM producto p2
		WHERE p2.codigo_fabricante=p.codigo_fabricante
	)
GROUP BY f.nombre;





/*16.Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de su mismo fabricante.*/
SELECT codigo, nombre, precio
FROM producto p1 
WHERE precio>=
	(
		SELECT AVG(p2.precio)
		FROM producto p2 
		WHERE p1.codigo_fabricante=p2.codigo_fabricante
	);




/*17.Lista el nombre del producto más caro del fabricante Lenovo.*/

/**//**//**//**//**//**/
/**//**//**//**//**//**/
/**//**//**//**//**//**/
/**//**//**//**//**//**/
/**//**//**//**//**//**/


/*-------------------------------------------1.1.8 Subconsultas (En la cláusula HAVING)-----------------------------------*/

/*18.Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.*/
SELECT f.nombre
FROM fabricante f INNER JOIN producto p
ON f.codigo=p.codigo_fabricante
GROUP BY f.nombre
HAVING COUNT(p.codigo_fabricante)=
	(
		SELECT COUNT(codigo_fabricante)
		FROM fabricante f INNER JOIN producto p
		ON f.codigo=p.codigo_fabricante 
		WHERE f.nombre='Lenovo'
	);








