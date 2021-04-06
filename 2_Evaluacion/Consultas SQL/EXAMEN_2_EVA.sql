SELECT empleados.*
FROM empleados
INNER JOIN bares
ON bares.nombre = empleados.bar
WHERE bares.tieneTerraza = 1;

SELECT vinos.*
FROM vinos
WHERE precio <= ALL (
								SELECT precio
								FROM vinos
							);
							
SELECT vinos.*
FROM vinos
WHERE precio <= ALL (
								SELECT precio
								FROM vinos
							);
							
							
SELECT bares.nombre, vinos.cod, bodega.existencias
FROM bares
INNER JOIN bodega
ON bodega.bar = bares.nombre
INNER JOIN vinos
ON bodega.vino = vinos.cod
WHERE precio >= ALL (
								SELECT precio
								FROM vinos
							);

SELECT bares.nombre, COUNT()
FROM bares
INNER JOIN empleados
ON bares.nombre = empleados.bar


SELECT bares.nombre, empleados.nombre, empleados.sueldo
FROM bares
INNER JOIN empleados
ON bares.nombre = empleados.bar
WHERE bares.nombre = empleados.bar;

SELECT vinos.nombre, vinos.precio, vinos.tipo
FROM vinos
INNER JOIN bodega
ON vinos.cod = bodega.vino
INNER JOIN bares
ON bares.nombre = bodega.bar
WHERE bodega.bar = 'Bar Manolo'
ORDER BY vinos.precio DESC;

SELECT bares.nombre, empleados.nombre, empleados.tlf
FROM bares
INNER JOIN empleados
ON bares.nombre = empleados.bar
WHERE bares.tieneTerraza = ALL(
											SELECT bares.tieneTerraza
											FROM bares
											WHERE tieneTerraza = 0								
										);


SELECT bar, nombre, tlf
FROM empleados
WHERE bar = ANY (
					SELECT nombre
					FROM bares
					WHERE tieneTerraza = 0											
				);
										
SELECT vinos.*
FROM vinos
INNER JOIN bodega
ON bodega.vino = vinos.cod
INNER JOIN empleados
ON empleados.bar = bodega.bar
WHERE empleados.nombre = 'Daniel Dado';

SELECT bares.nombre, COUNT(empleados.bar), bares.capacidad
FROM bares
INNER JOIN empleados
ON empleados.bar = bares.nombre
GROUP BY bares.nombre
HAVING COUNT(empleados.bar) >= bares.capacidad;