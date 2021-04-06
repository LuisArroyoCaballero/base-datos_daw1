DROP SCHEMA IF EXISTS 100Montaditos;
CREATE SCHEMA 100Montaditos;
USE 100Montaditos;

CREATE TABLE Bares(
    nombre VARCHAR(30),
    tlf VARCHAR(9),
    direccion VARCHAR(50),
    capacidad INT,
    tieneTerraza BOOLEAN,
    CONSTRAINT PRIMARY KEY(nombre)
);

CREATE TABLE Vinos (
    cod INT,
    nombre VARCHAR(30),
    precio DECIMAL(6,2),
    tipo VARCHAR(20),
    CONSTRAINT PRIMARY KEY(cod)
);

CREATE TABLE Empleados (
    dni VARCHAR(9),
    nombre VARCHAR(30),
    tlf VARCHAR(9),
    sueldo DECIMAL(6,2),
    bar VARCHAR(30),
    CONSTRAINT PRIMARY KEY(dni),
    CONSTRAINT FOREIGN KEY (bar) REFERENCES Bares(nombre) 
);

CREATE TABLE Bodega (
    bar VARCHAR(30),
    vino INT,
    existencias INT,
    CONSTRAINT PRIMARY KEY (bar,vino)
);