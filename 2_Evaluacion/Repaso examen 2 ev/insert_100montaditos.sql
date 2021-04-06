DELETE 
FROM Bodega;
DELETE 
FROM Empleados;
DELETE 
FROM Bares;
DELETE 
FROM Vinos;

INSERT INTO Bares VALUES 
("Bar Manolo",   "95432323", "C/Larga 18",            30, false),
("Come y calla", "67890123", "Avd. de la Sardina 23", 10, true),
("La Taberna",   "65432109", "Plaza del Boquerón 7",  25, true),
("Hambre",       "95544332", "Callejón del Pulpo 22",  2, false),
("Muy caro",     "90010020", "Bulevar del Choco 45",  40, true),
("Churrería",    "90010021", "Bulevar del Choco 46",  10, true)
;

INSERT INTO Empleados VALUES
("12345678A", "Antonio Almanaque", "67890123", 1200.0,  "Bar Manolo"),
("11111111B", "Bea Boniato",       "66666666",   25.12, "Bar Manolo"),
("22222222C", "Cristina Cristal",  "67777777", 2400.50, "Bar Manolo"),
("33333333D", "Daniel Dado",       "68888888", 1100.18, "Come y calla"),
("44444444E", "Ernesto Entrada",   "95444444",  800.80, "Come y calla"),
("55555555F", "Fran Feo",          "94444444",  990.90, "Hambre"),
("66666666G", "Gema Gigante",      null,       1650.50, "Hambre"),
("77777777H", "Heidi Hielo",       "95432109", 1518.18, "Hambre"),
("88888888I", "Inés Hignorante",   "67676767", 1000.00, "Muy caro")
;

INSERT INTO Vinos VALUES
(1001, "Condado de Camas", 15.67, "Albariño"),
(1002, "Don Raimo",        12.12, "Rioja"),
(1003, "Borrachera",      125.50, "Blanco"),
(1004, "Palacomida",        3.75, "Rioja"),
(1005, "Uvas redondas",   225.25, "Albariño"),
(1006, "Y se fue",         18.00, "Albariño"),
(1007, "Uvas cuadradas",    5.25, "Mosto"),
(1008, "Copa blanca",      19.00, "Albariño"),
(1009, "Terra Gallega",    20.00, "Albariño"),
(1010, "Peleón",            3.75, "Ribera")

;

INSERT INTO Bodega VALUES
("Bar Manolo", 1001, 3),
("Bar Manolo", 1002, 20),
("Bar Manolo", 1003, 50),
("Bar Manolo", 1004, 30),
("Come y calla", 1001, 50),
("Come y calla", 1005, 60),
("La Taberna", 1001, 10),
("La Taberna", 1002, 25),
("La Taberna", 1003, 33),
("La Taberna", 1004, 44),
("Hambre", 1001, 30),
("Hambre", 1002, 35),
("Hambre", 1006, 35),
("Muy caro", 1004, 15),
("Muy caro", 1005, 20)
;

