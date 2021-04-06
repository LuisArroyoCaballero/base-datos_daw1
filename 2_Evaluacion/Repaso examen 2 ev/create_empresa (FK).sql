SET FOREIGN_KEY_CHECKS = 0;

DROP DATABASE IF EXISTS Empresa;
CREATE DATABASE IF NOT EXISTS Empresa
  CHARACTER SET utf8 COLLATE utf8_spanish2_ci;
USE Empresa;
-- -------------------------------------
-- Tablas

CREATE TABLE Empleados (
  numemp INT(10),
  nombre VARCHAR(30) NULL,
  edad INT(10) NULL,
  oficina INT(10) NULL,
  puesto VARCHAR(20) NULL,
  contrato DATE NULL,
  jefe INT(10) NULL,
  cuota INT(10) NULL,
  ventas INT(10) NULL,
  CONSTRAINT PRIMARY KEY (numemp)
)ENGINE = INNODB;

ALTER TABLE Empleados ADD CONSTRAINT fkJefe FOREIGN KEY(jefe) REFERENCES Empleados(numemp);

CREATE TABLE Clientes (
  numclie INT(10) NOT NULL,
  nombre VARCHAR(30) NULL,
  resp INT(10) NULL,
  limitecredito INT(10) NULL,
  CONSTRAINT fkNumclie PRIMARY KEY(numclie),
  CONSTRAINT fkRepclie FOREIGN KEY(resp) REFERENCES Empleados(numemp)
)ENGINE = INNODB;


CREATE TABLE Oficinas (
  oficina INT(10) NOT NULL,
  ciudad VARCHAR(30) NULL,
  region VARCHAR(20) NULL,
  dir INT(10) NULL,
  objetivo DECIMAL(19, 4) NULL,
  ventas DECIMAL(19, 4) NULL,
  CONSTRAINT PRIMARY KEY (oficina),
  CONSTRAINT fkDir FOREIGN KEY (dir) REFERENCES Empleados(numemp)	
)ENGINE = INNODB;

ALTER TABLE Empleados ADD CONSTRAINT fkOficina FOREIGN KEY (oficina) REFERENCES Oficinas(oficina);

CREATE TABLE Productos (
  idfab VARCHAR(10),
  idproducto VARCHAR(20),
  descripcion VARCHAR(30) NULL,
  precio DECIMAL(19, 4) NULL,
  existencias INT(10) NULL,
  CONSTRAINT PRIMARY KEY (idfab, idproducto)
)ENGINE = INNODB;

CREATE TABLE Pedidos (
  numpedido INT(10) NOT NULL,
  fechapedido DATETIME NULL,
  clie INT(10) NULL,
  resp INT(10) NULL,
  fab VARCHAR(10) NULL,
  producto VARCHAR(20) NULL,
  cant INT(10) NULL,
  importe DECIMAL(19, 4) NULL,
  CONSTRAINT PRIMARY KEY (numpedido),
  CONSTRAINT fkRep FOREIGN KEY (resp) REFERENCES Empleados(numemp),
  CONSTRAINT fkProductos FOREIGN KEY (fab, producto) REFERENCES Productos(idfab, idproducto)
)ENGINE = INNODB;




SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------
-- EOF

