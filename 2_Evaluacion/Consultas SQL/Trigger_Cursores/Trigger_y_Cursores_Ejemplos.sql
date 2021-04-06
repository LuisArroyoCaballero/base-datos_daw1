/* EJEMPLO CURSORES */

-- Paso 1 creamos la BD
DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

-- Paso 2 creamos las tablas e insertamos los datos
CREATE TABLE t1 (
  id INT UNSIGNED PRIMARY KEY,
    data VARCHAR(16)
);

CREATE TABLE t2 (
  i INT UNSIGNED
);

CREATE TABLE t3 (
  data VARCHAR(16),
    i INT UNSIGNED
);

INSERT INTO t1 VALUES (10, 'A');
INSERT INTO t1 VALUES (20, 'B');

INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (2);

-- Paso 3 creamos el procedimiento con el cursor

DELIMITER $$
DROP PROCEDURE IF EXISTS curdemo$$ 
CREATE PROCEDURE curdemo()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE a CHAR(16);
  DECLARE b, c INT;

  -- declaramos los cursores
  DECLARE cur1 CURSOR FOR SELECT id,data FROM test.t1;
  DECLARE cur2 CURSOR FOR SELECT i FROM test.t2;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE; -- cuando no hay más registros, done se pone a TRUE

  -- abrimos los cursores
  OPEN cur1;
  OPEN cur2;

  WHILE done = FALSE DO
    FETCH cur1 INTO b, a; -- recorremos el cursor, guardando en las variables lo que devuelve cada fila de la consulta
    FETCH cur2 INTO c;
  
    IF done = FALSE THEN
    IF b < c THEN
      INSERT INTO test.t3 VALUES (a,b); -- podemos hacer comprobaciones antes de hacer la inserción de los datos en la BD
    ELSE
      INSERT INTO test.t3 VALUES (a,c);
    END IF;
  END IF;
  END WHILE;

  CLOSE cur1;
  CLOSE cur2;
END;

-- Paso 4
DELIMITER ;
CALL curdemo();

SELECT * FROM t3;

/* EJEMPLO TRIGGERS */
-- Paso 1
DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

-- Paso 2 
CREATE TABLE alumnos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50), 
    nota FLOAT
);

-- Paso 3
DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert$$
CREATE TRIGGER trigger_check_nota_before_insert
BEFORE INSERT -- se ejecuta antes de realizar el INSERT
ON alumnos FOR EACH ROW
BEGIN
  IF NEW.nota < 0 THEN
    set NEW.nota = 0;
  ELSEIF NEW.nota > 10 THEN
    set NEW.nota = 10;
  END IF;
END
$$

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_update$$
CREATE TRIGGER trigger_check_nota_before_update
BEFORE UPDATE -- se ejecuta antes de realizar el UPDATE
ON alumnos FOR EACH ROW
BEGIN
  IF NEW.nota < 0 THEN
    set NEW.nota = 0;
  ELSEIF NEW.nota > 10 THEN
    set NEW.nota = 10;
  END IF;
END
$$
-- Paso 4
DELIMITER ;
INSERT INTO alumnos VALUES (1, 'Pepe', 'López', 'López', -1);
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez', 'Sánchez', 11);
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez', 'Pérez', 8.5);

-- Paso 5
SELECT * FROM alumnos;

-- Paso 6
UPDATE alumnos SET nota = -4 WHERE id = 1;
UPDATE alumnos SET nota = 14 WHERE id = 2;
UPDATE alumnos SET nota = 9.5 WHERE id = 3;

-- Paso 7
SELECT * FROM alumnos;