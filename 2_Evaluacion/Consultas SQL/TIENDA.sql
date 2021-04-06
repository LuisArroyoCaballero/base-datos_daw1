SELECT producto.nombre
FROM producto
INNER JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre='Asus' OR fabricante.nombre='Hawlett-Packard' OR fabricante.nombre='Seagate';

SELECT producto.nombre
FROM producto
INNER JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre IN ('Asus','Hawlett-Packard','Seagate');

SELECT fabricante.nombre, COUNT(producto.codigo_fabricante)
FROM producto
INNER JOIN fabricante
ON fabricante.codigo=producto.codigo_fabricante
GROUP BY producto.codigo_fabricante;

SELECT fabricante.nombre
FROM fabricante
INNER JOIN producto
ON producto.codigo_fabricante = fabricante.codigo
GROUP BY producto.codigo_fabricante
HAVING COUNT(codigo_fabricante) = (
												SELECT COUNT(codigo_fabricante)
												FROM producto
												INNER JOIN fabricante
												ON fabricante.codigo=producto.codigo_fabricante
												WHERE fabricante.nombre='Lenovo'
												);
												
SELECT nombre
FROM fabricante
WHERE codigo = ANY 	(
								SELECT codigo_fabricante
								FROM producto
							);	
							
SELECT nombre
FROM fabricante
WHERE codigo <> ALL 	(
								SELECT codigo_fabricante
								FROM producto
							);	
							
SELECT f.nombre, p.nombre, p.precio
FROM fabricante f
INNER JOIN producto p
ON f.codigo = p.codigo_fabricante
WHERE p.precio = (
									SELECT MAX(p2.precio)
									FROM producto p2
									WHERE p.codigo_fabricante = 	p2.codigo_fabricante
								)
GROUP BY f.nombre;						