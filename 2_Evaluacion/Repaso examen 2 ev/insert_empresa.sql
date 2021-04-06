-- Disable foreign key checks
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
USE Empresa;

INSERT INTO Clientes(numclie, nombre, resp, limitecredito)
VALUES (2101,'Luis Garcia Antón', 106, 6500),
  (2102,'Alvaro Rodríguez', 101, 6500),
  (2103,'Jaime Jamás', 105, 5000),
  (2105,'Antonio Ardilla', 101, 4500),
  (2106,'Pepita Piña', 102, 6500),
  (2107,'Julian López', 110, 3500),
  (2108,'Marina Melón', 109, 5500),
  (2109,'Alberto Andorra', 103, 2500),
  (2111,'Cristóbal Colón', 103, 5000),
  (2112,'María Silva', 108, 5000),
  (2113,'Luisa Marrón', 104, 2000),
  (2114,'Cristina Pérez', 102, 2000),
  (2115,'Vicente Martínez', 101, 2000),
  (2117,'Carlos Tena', 106, 35000),
  (2118,'Junípero Álvarez', 108, 6000),
  (2119,'Salomón Bueno', 109, 2500),
  (2120,'Juan Malo', 102, 50000),
  (2121,'Vicente Ríos', 103, 4500),
  (2122,'José Marchante', 105, 3000),
  (2123,'Leandro Libros', 102, 4000),
  (2124,'Juan Bolto', 107, 4000);

INSERT INTO Empleados(numemp, nombre, edad, oficina, puesto, contrato, jefe, cuota, ventas)
VALUES (101,'Antonio Viguer', 45, 12,'Representante','2006-10-20', 104, 3000, 3050),
  (104,'José González', 33, 12,'Dir ventas','2007-05-19', 106, 20000, 14300),
  (103,'Francisco Frio', 29, 12,'Representante','2007-03-01', 104, 27500, 28600),
  (102,'Alvaro Aluminio', 48, 21,'Representante','2015-12-10', 108, 350000, 474000),
  (105,'Vicente Vino', 37, 13,'Representante','2008-02-12', 104, 3500, 3680),
  (106,'Luis León', 52, 11,'Dir general','2008-06-14', NULL, 27500, 29900),
  (107,'Jorge Gutiérrez', 49, 22,'Representante','2011-11-14', 108, 30000, 18600),
  (108,'Ana Bustamante', 62, 21,'Dir ventas','2009-10-12', 106, 35000, 35100),
  (109,'María Melocotón', 31, 11,'Representante','2009-10-12', 105, 30000, 39200),
  (110,'Veronica Vic', 41, NULL,'Representante','2000-01-13', 104, NULL, 76000);

INSERT INTO Oficinas(oficina, ciudad, region, dir, objetivo, ventas)
VALUES (11,'Sevilla','sur', 106, 57500.0000, 69300.0000),
  (12,'Cádiz','oeste', 104, 80000.0000, 73500.0000),
  (13,'Castellón','este', 105, 35000.0000, 36800.0000),
  (21,'Badajoz','oeste', 108, 72500.0000, 83600.0000),
  (22,'La Coruña','norte', 108, 30000.0000, 18600.0000),
  (23,'Sevilla','sur', 108, NULL, NULL),
  (24,'Sevilla','sur', 108, 25000.0000, 15000.0000),
  (26,'Huelva','sur', NULL, NULL, NULL),
  (28,'Almeria','este', NULL, 900000.0000, 0.0000);

INSERT INTO Pedidos(numpedido, fechapedido, clie, resp, fab, producto, cant, importe)
VALUES (110035,'2007-01-02', 2107, 110,'aci','4100z', 9, 2250.0000),
  (110036,'2008-06-14', 2117, 106,'rei','2a44i', 7, 3150.0000),
  (112963,'2007-05-10', 2103, 105,'aci','41004', 28, 327.0000),
  (112968,'2000-01-11', 2102, 101,'aci','41004', 34, 397.0000),
  (112975,'2007-02-11', 2111, 103,'rei','2a44g', 6, 210.0000),
  (112979,'1989-10-12', 2114, 108,'aci','4100z', 6, 1500.0000),
  (112983,'2007-05-10', 2103, 105,'aci','41004', 6, 702.0000),
  (112987,'2007-01-01', 2103, 105,'aci','4100y', 11, 2750.0000),
  (112989,'2007-12-10', 2101, 106,'fea','114', 6, 1458.0000),
  (112992,'2000-04-15', 2118, 108,'aci','41002', 10, 760.0000),
  (112993,'2009-03-10', 2106, 102,'rei','2a45c', 24, 1896.0000),
  (112997,'2009-04-04', 2124, 107,'bic','41003', 1, 652.0000),
  (113003,'2009-02-05', 2108, 109,'imm','779c', 3, 5625.0000),
  (113007,'2009-01-01', 2112, 108,'imm','773c', 3, 2925.0000),
  (113012,'2010-05-05', 2111, 105,'aci','41003', 35, 3745.0000),
  (113013,'2006-08-06', 2118, 108,'bic','41003', 1, 652.0000),
  (113024,'2007-07-04', 2114, 108,'qsa','xk47', 20, 7100.0000),
  (113027,'2011-02-05', 2103, 105,'aci','41002', 54, 5104.0000),
  (113034,'2011-11-05', 2107, 110,'rei','2a45c', 8, 632.0000),
  (113042,'2011-01-01', 2113, 101,'rei','2a44r', 5, 2250.0000),
  (113045,'2010-07-02', 2112, 108,'rei','2a44r', 10, 4500.0000),
  (113048,'2016-02-02', 2120, 102,'imm','779c', 2, 375.0000),
  (113049,'2016-04-04', 2118, 108,'qsa','xk47', 2, 776.0000),
  (113051,'2015-07-06', 2118, 108,'qsa','xk47', 4, 142.0000),
  (113055,'2014-04-01', 2108, 101,'aci','4100x', 6, 15.0000),
  (113057,'2015-11-01', 2111, 103,'aci','4100x', 24, 60.0000),
  (113058,'2014-07-04', 2108, 109,'fea','112', 10, 1480.0000),
  (113062,'2013-07-04', 2124, 107,'bic','41003', 10, 2430.0000),
  (113065,'2007-06-03', 2106, 102,'qsa','xk47', 6, 2130.0000),
  (113069,'2007-08-01', 2109, 107,'imm','773c', 22, 31350.0000);

INSERT INTO Productos(idfab, idproducto, descripcion, precio, existencias)
VALUES ('aci','41001','arandela', 58.0000, 277),
  ('aci','41002','bisagra', 80.0000, 167),
  ('aci','41003','bombín llave', 112.5000, 207),
  ('aci','41004','palanca', 123.7000, 139),
  ('aci','4100x','junta tórica', 26.7000, 37),
  ('aci','4100y','extractor', 2888.0000, 25),
  ('aci','4100z','monedero', 2625.0000, 28),
  ('bic','41003','manivela', 652.0000, 3),
  ('bic','41089','rodamiento', 225.0000, 78),
  ('bic','41672','plato', 180.0000, 0),
  ('fea','112','junta de culata', 148.0000, 115),
  ('fea','114','cubo', 243.0000, 15),
  ('imm','773c','reostato', 975.0000, 28),
  ('imm','775c','giroscopio', 1425.0000, 5),
  ('imm','779c','bargueño', 1875.0000, 0),
  ('imm','887h','caja clavos', 54.0000, 223),
  ('imm','887p','perno', 25.0000, 24),
  ('imm','887x','manivela', 475.0000, 32),
  ('qsa','xk47','destornillador', 355.0000, 38),
  ('qsa','xk48','telescopio', 134.0000, 203),
  ('qsa','xk48a','llave inglesa', 117.0000, 37),
  ('rei','2a44g','condensador de fluzo', 350.0000, 14),
  ('rei','2a44i','bomba agua', 4500.0000, 12),
  ('rei','2a44r','bomba aceite', 4500.0000, 12),
  ('rei','2a45c','junta cartón', 79.0000, 210);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

-- End of script
