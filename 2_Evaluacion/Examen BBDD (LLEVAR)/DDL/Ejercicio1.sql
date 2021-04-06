DROP DATABASE IF EXISTS ADMINISTRADOR_FINCAS;
CREATE DATABASE ADMINISTRADOR_FINCAS;
USE ADMINISTRADOR_FINCAS;

CREATE TABLE edificios(
	nom_edif VARCHAR(20) PRIMARY KEY,
	drec_edif VARCHAR(30)
);

CREATE TABLE empresas(
	cif_empresa CHAR(9) PRIMARY KEY,
	nom_empre VARCHAR(20)
);

CREATE TABLE oficinas(
	num_ofi INT(10),
	nom_edif VARCHAR(20),
	CONSTRAINT oficina_pk PRIMARY KEY(num_ofi,nom_edif),
	CONSTRAINT edi_ofi_fk FOREIGN KEY(nom_edif) REFERENCES edificios(nom_edif) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE propietaria(
	cif_empresa CHAR(9),
	num_ofi INT(10),
	CONSTRAINT propietaria_pk PRIMARY KEY(cif_empresa,num_ofi),
	CONSTRAINT empre_propi_fk FOREIGN KEY(cif_empresa) REFERENCES empresas(cif_empresa) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ofi_propi_fk FOREIGN KEY(num_ofi) REFERENCES oficinas(num_ofi) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO edificios(nom_edif, drec_edif) VALUES('Edificio España','C/ManuelEsquivias');
INSERT INTO edificios(nom_edif, drec_edif) VALUES('Edificio Inglaterra','C/Camas');
INSERT INTO edificios(nom_edif, drec_edif) VALUES('Edificio Suecia','C/Aljarafe');

INSERT INTO empresas(cif_empresa, nom_empre) VALUES('V14970818','SERVINFORM');
INSERT INTO empresas(cif_empresa, nom_empre) VALUES('Q1030095B','C&G');
INSERT INTO empresas(cif_empresa, nom_empre) VALUES('H37444965','TEKNOSERVICE');

INSERT INTO oficinas(num_ofi, nom_edif) VALUES('1','Edificio España');
INSERT INTO oficinas(num_ofi, nom_edif) VALUES('2','Edificio Inglaterra');
INSERT INTO oficinas(num_ofi, nom_edif) VALUES('3','Edificio Suecia');

INSERT INTO propietaria(cif_empresa, num_ofi) VALUES('V14970818','1');
INSERT INTO propietaria(cif_empresa, num_ofi) VALUES('Q1030095B','2');
INSERT INTO propietaria(cif_empresa, num_ofi) VALUES('H37444965','3');

SELECT * FROM oficinas;

SELECT nom_edif, drec_edif FROM edificios
WHERE nom_edif='Edificio España';

SELECT * FROM empresas
WHERE cif_empresa=
	(
	SELECT cif_empresa FROM oficinas
	WHERE nom_edif='Edificio Suecia'
	);




