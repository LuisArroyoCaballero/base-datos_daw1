DROP DATABASE IF EXISTS tienda10;
CREATE DATABASE tienda10 CHARACTER SET utf8mb4;
USE tienda10;
CREATE TABLE fabricante (
codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL
);
CREATE TABLE producto (
codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio DOUBLE NOT NULL,
codigo_fabricante INT UNSIGNED NOT NULL,
FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);
INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');
INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

SELECT * FROM fabricante;
SELECT * FROM producto;

SELECT nombre 
FROM producto 
WHERE codigo_fabricante=
(
SELECT codigo FROM fabricante WHERE nombre='Lenovo'
);

SELECT * 
FROM producto
WHERE precio=
(
SELECT MAX(precio) 
FROM producto WHERE codigo_fabricante=
(
SELECT codigo FROM fabricante WHERE nombre='Lenovo'
)
);

SELECT nombre
FROM producto
WHERE precio=
(
SELECT MAX(precio) FROM producto WHERE codigo_fabricante=
(
SELECT codigo FROM fabricante WHERE nombre='Lenovo'
)
)
;

SELECT nombre
FROM producto
WHERE precio=
(
SELECT MIN(precio) FROM producto WHERE codigo_fabricante=
(
SELECT codigo FROM fabricante WHERE nombre='Hewlett-Packard'
)
)
;


SELECT nombre 
FROM producto
WHERE precio >=
(
SELECT MAX(precio) 
FROM producto WHERE codigo_fabricante=
(
SELECT codigo FROM fabricante WHERE nombre='Lenovo'
)
);

SELECT nombre
FROM producto
WHERE codigo_fabricante = 
(
SELECT codigo
FROM fabricante 
WHERE nombre = 'Asus'
)
AND precio > 
( 
SELECT AVG(precio) 
FROM producto
);

SELECT COUNT(nombre) 
FROM producto;

SELECT COUNT(codigo) FROM fabricante;

SELECT COUNT(DISTINCT(codigo_fabricante)) FROM producto; 

SELECT AVG(precio) AS Media FROM producto;

SELECT MIN(precio) AS barato FROM producto;

SELECT MAX(precio) AS barato FROM producto;

SELECT nombre,precio FROM producto WHERE precio = (SELECT MIN(precio) FROM producto);

SELECT nombre,precio FROM producto WHERE precio = (SELECT MAX(precio) FROM producto);

SELECT SUM(precio) FROM producto;

SELECT * FROM producto WHERE codigo_fabricante=1 OR codigo_fabricante=3 OR codigo_fabricante=5;

SELECT * FROM producto WHERE codigo_fabricante IN (1,3,5);

SELECT nombre,(precio*100) AS centimos FROM producto;

SELECT nombre FROM fabricante WHERE nombre LIKE 'S%';

SELECT nombre FROM fabricante WHERE nombre LIKE '%e';

SELECT nombre FROM fabricante WHERE nombre LIKE '%w%';

SELECT nombre FROM fabricante WHERE LENGTH(nombre)=4;

SELECT nombre FROM producto WHERE nombre LIKE '%Portatil%';

SELECT nombre FROM producto WHERE nombre LIKE '%Monitor%' AND precio < 215;

SELECT nombre, precio 
FROM producto 
WHERE precio>=180 
ORDER BY precio DESC, nombre ASC;

SELECT nombre AS nombre_de_producto,precio AS Euros, (precio*1.21) AS Dolares 
FROM producto;

