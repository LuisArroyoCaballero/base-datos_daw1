DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE paciente 
(
	nif_paciente VARCHAR(9) PRIMARY KEY,
	nombre_paciente VARCHAR(40),
	email VARCHAR(32),
	compania_medica VARCHAR(15),
	CONSTRAINT ck_compania CHECK(compania_medica IN ('DKV', 'ASISA', 'SANITAS', 'ADESLAS'))
);

CREATE TABLE habitacion
(
	num_habitacion INT(3) PRIMARY KEY,
	planta INT(2),
	especialidad VARCHAR(20),
	precio INT(4),
	ocupada VARCHAR(2) CHECK (ocupada IN ('SI', 'NO'))
);

CREATE TABLE estancia
(
	nif_paciente VARCHAR(9) ,
	num_habitacion INT(3),
	fecha_entrada DATE,
	fecha_salida DATE,
	CONSTRAINT pk_estancia PRIMARY KEY(nif_paciente, num_habitacion, fecha_entrada),
	CONSTRAINT fk_paciente_estancia FOREIGN KEY(nif_paciente) REFERENCES paciente(nif_paciente) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_habitacion_estancia FOREIGN KEY(num_habitacion) REFERENCES habitacion(num_habitacion) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE contabilidad_estancia
(
	nif_paciente VARCHAR(9),
	num_habitacion INT(3),
	dias_estancia INT (4),
	importe_estancia INT(4)
);

INSERT INTO paciente VALUES ('10', 'Andrés Guillén', 'aguillen@gmail.com', 'DKV');
INSERT INTO paciente VALUES ('20', 'Joserra De Los Santos', 'jsantos@gmail.com', 'DKV');
INSERT INTO paciente VALUES ('30', 'José María Durán', 'jduran@gmail.com', 'ASISA');
INSERT INTO paciente VALUES ('40', 'Reyes Montes', 'rmontes@gmail.com', 'ASISA');

INSERT INTO habitacion VALUES (10, 1, 'ginecología', 300, 'NO');
INSERT INTO habitacion VALUES (11, 1, 'ginecología', 300, 'NO');
INSERT INTO habitacion VALUES (12, 1, 'neurología', 500, 'NO');
INSERT INTO habitacion VALUES (13, 1, 'neurología', 500, 'NO');
INSERT INTO habitacion VALUES (14, 1, 'UCI', 5000, 'NO');

INSERT INTO estancia VALUES ('30', 10, '2020-01-12', '2021-01-20');
INSERT INTO estancia VALUES ('40', 10, '2020-02-12', '2021-03-20');
INSERT INTO estancia VALUES ('30', 14, '2020-02-10', '2021-02-05');
INSERT INTO estancia VALUES ('10', 14, '2020-02-24', '2021-02-24');
INSERT INTO estancia VALUES ('20', 13, '2020-03-12', '2021-03-20');



















