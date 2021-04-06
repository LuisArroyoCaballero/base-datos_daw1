CREATE DATABASE EXAMEN_DDL;
USE EXAMEN_DDL;

CREATE TABLE Clientes 	(
									Dni CHAR(9) PRIMARY KEY,
									Nombre_Apellidos VARCHAR(50) NOT NULL
								);
								
																	
CREATE TABLE Vuelos	(
								id_vuelo INT(10) PRIMARY KEY,
								fecha_hora_salida DATE DEFAULT CURDATE(),
								origen VARCHAR(25),
								destino VARCHAR(25)
							);								
								
								
CREATE TABLE Reservan 	(
									Dni_clientes CHAR(9),
									id_vuelo INT(10),
									fecha_hora_reserva DATE DEFAULT CURDATE(),
									CONSTRAINT Reservan_pk PRIMARY KEY (Dni_clientes, id_vuelo, fecha_hora_reserva),
									CONSTRAINT id_vuelo FOREIGN KEY (id_vuelo) REFERENCES Vuelos (id_vuelo) ON DELETE CASCADE ON UPDATE CASCADE,
									CONSTRAINT Dni_clientes FOREIGN KEY (Dni_clientes) REFERENCES Clientes (Dni) ON DELETE CASCADE ON UPDATE CASCADE									
								);
								

CREATE TABLE Sucursales	(
									id_sucursal INT(10) PRIMARY KEY,
									ciudad_sucursal VARCHAR(25),
									poblacion_sucursales VARCHAR(25)
								);
								
CREATE TABLE Referencian	(
										id_sucursal INT(10),
										id_sucursal_ref INT(10) UNIQUE,
										CONSTRAINT sucursal_referenciada_id_fk FOREIGN KEY (id_sucursal_ref) REFERENCES Sucursales(id_sucursal) ON DELETE CASCADE ON UPDATE CASCADE,
										CONSTRAINT sucursal_referenciada FOREIGN KEY (id_sucursal_ref) REFERENCES Sucursales(id_sucursal) ON DELETE CASCADE ON UPDATE CASCADE
									);
								
																



CREATE TABLE Disponen	(
									id_vuelo INT(10),
									id_sucursal INT(10),
									CONSTRAINT Disponen_pk PRIMARY KEY (id_vuelo,id_sucursal),
									CONSTRAINT id_vuelo_fk_disponen FOREIGN KEY (id_vuelo) REFERENCES Vuelos(id_vuelo) ON DELETE CASCADE ON UPDATE CASCADE,
									CONSTRAINT id_sucursal_fk_disponen FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal) ON DELETE CASCADE ON UPDATE CASCADE
								);
								

CREATE TABLE Hoteles	(
								id_hotel INT(10) PRIMARY KEY,
								ciudad_hoteles VARCHAR(25),
								poblacion_hoteles VARCHAR(25),
								id_sucursal INT(10),
								CONSTRAINT id_sucursal_hoteles_fk FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal) ON DELETE CASCADE ON UPDATE CASCADE
							);
	
									
INSERT INTO clientes(Dni, Nombre_Apellidos) 
VALUES ('11111111A','Paco Alfonso');

INSERT INTO clientes(Dni, Nombre_Apellidos) 
VALUES ('11111111B','Ana Garcia');


INSERT INTO vuelos(id_vuelo, fecha_hora_salida, origen, destino)
VALUES ('1111112','2020/05/10','Sevilla','Malaga');

INSERT INTO vuelos(id_vuelo, fecha_hora_salida, origen, destino)
VALUES ('1111111','2020/05/11','Madrid','Barcelona');