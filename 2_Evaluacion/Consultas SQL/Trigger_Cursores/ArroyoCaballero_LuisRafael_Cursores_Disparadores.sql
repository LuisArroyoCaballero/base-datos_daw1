/*CURSORES*/

/*EJERCICIO 1*/

/*CREACION DE LA BASE DE DATOS*/

DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

/*CREACION E INSERCION EN LA TABLA*/

DROP TABLE IF EXISTS alumnos;
CREATE TABLE alumnos	(
								id INT(3) UNSIGNED PRIMARY KEY,
								nombre VARCHAR(50),
								apellido1 VARCHAR(50),
								apellido2 VARCHAR(50),
								fecha_nacimiento DATE
							);

INSERT INTO test.alumnos VALUES (111,'Alvaro','Martinez','Suarez','1999/07/27');
INSERT INTO test.alumnos VALUES (222,'Luis','Ruiz','Romero','1999/02/10');
INSERT INTO test.alumnos VALUES (333,'Antonio','Lopez','Fuentes','1999/08/06');
INSERT INTO test.alumnos VALUES (444,'Ivan','Valdenebro','Jimenez','1999/05/15');

/*MODIFICACION DE LA TABLA CON LA COLUMNA EDAD*/

ALTER TABLE alumnos
ADD edad INT;

/*FUNCION CALCULAR LA EDAD*/

DELIMITER $$

DROP FUNCTION IF EXISTS calcular_edad $$
CREATE FUNCTION calcular_edad(fecha_funcion DATE) RETURNS INT
	BEGIN
		DECLARE num_anios INT;
		SET num_anios = ABS(TRUNCATE((DATEDIFF(CURDATE(),fecha_funcion)/365),0));
		RETURN num_anios;
	END
$$

/*PROCEDIMIENTO ACTUALIZAR COLUMNA*/

DELIMITER $$

DROP PROCEDURE IF EXISTS actualizar_columna_edad $$
CREATE PROCEDURE actualizar_columna_edad()
	BEGIN
		DECLARE fecha_procedimiento, id_edad DATE;
		DECLARE done INT DEFAULT 0;
		DECLARE cur CURSOR FOR SELECT fecha_nacimiento, id FROM alumnos ;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

		OPEN cur ;
		REPEAT
			FETCH cur INTO fecha_procedimiento, id_edad;
			IF NOT done THEN
				UPDATE alumnos
				SET edad = calcular_edad(fecha_procedimiento)
				WHERE id = id_edad;
			END IF;
		UNTIL done END REPEAT ;
		CLOSE cur ;
	END
$$

CALL actualizar_columna_edad$$

/*MODIFICAR PARA EL E-MAIL*/

ALTER TABLE alumnos
ADD email VARCHAR(100)$$

/*FUNCION CREAR EMAIL*/

DELIMITER $$

DROP FUNCTION IF EXISTS crear_email $$
CREATE FUNCTION crear_email(nombre_funcion VARCHAR(30), apellido1_funcion VARCHAR(30), apellido2_funcion VARCHAR(30), dominio VARCHAR(30)) RETURNS VARCHAR(100)
	BEGIN
		DECLARE correo_funcion VARCHAR(100);
		SELECT CONCAT((SUBSTRING(nombre_funcion,1)),(SUBSTRING(apellido1_funcion,1,3)),(SUBSTRING(apellido2_funcion,1,3)),'@',dominio)
		INTO correo_funcion;
		RETURN correo_funcion;
	END
$$


/*PROCEDIMIENTO ACTUALIZAR EMAIL*/

DELIMITER $$

DROP PROCEDURE IF EXISTS actualizar_columna_email $$
CREATE PROCEDURE actualizar_columna_email()
	BEGIN
		DECLARE nombre_procedimiento, apellido1_procedimiento, apellido2_procedimiento, dni_email VARCHAR(30);
		DECLARE done INT DEFAULT 0;
		DECLARE cur CURSOR FOR SELECT nombre, apellido1, apellido2, id FROM alumnos ;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

		OPEN cur;
		REPEAT
			FETCH cur INTO nombre_procedimiento, apellido1_procedimiento, apellido2_procedimiento, dni_email;
			IF NOT done THEN
				UPDATE alumnos
				SET email = crear_email(nombre_procedimiento, apellido1_procedimiento, apellido2_procedimiento,'gmail.com')
				WHERE id = dni_email;
			END IF;
		UNTIL done END REPEAT;
		CLOSE cur;
	END
$$

CALL actualizar_columna_email $$

/*PROCEDIMIENTO CREAR LISTA DE EMAILS*/

DELIMITER $$

DROP FUNCTION IF EXISTS crear_lista_emails_alumnos $$
CREATE FUNCTION crear_lista_emails_alumnos() RETURNS VARCHAR(1000)
	BEGIN
		DECLARE email_actual VARCHAR(30);
		DECLARE email_lista VARCHAR(1000) DEFAULT '';
		DECLARE done INT DEFAULT 0;
		DECLARE cur CURSOR FOR SELECT email FROM alumnos ;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

		OPEN cur;
		
		FETCH cur INTO email_lista;
		
		
		REPEAT
			FETCH cur INTO email_actual;
			IF NOT done THEN
				SET email_lista = CONCAT(email_lista,';',email_actual);
			END IF;
		UNTIL done END REPEAT;
		CLOSE cur;
		RETURN email_lista;
	END
$$

SELECT crear_lista_emails_alumnos() $$



/*TRIGGERS*/

DROP TABLE IF EXISTS alumnos;
CREATE TABLE alumnos	(
								id INT(3) UNSIGNED PRIMARY KEY,
								nombre VARCHAR(50),
								apellido1 VARCHAR(50),
								apellido2 VARCHAR(50),
								nota DOUBLE
							);
							
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

INSERT INTO alumnos(id,nombre,apellido1,apellido2,nota) VALUES (111,'Alvaro','Martinez','Suarez',-1);
INSERT INTO alumnos(id,nombre,apellido1,apellido2,nota) VALUES (222,'Luis','Ruiz','Romero',16);
INSERT INTO alumnos(id,nombre,apellido1,apellido2,nota) VALUES (333,'Antonio','Lopez','Fuentes',5);
INSERT INTO alumnos(id,nombre,apellido1,apellido2,nota) VALUES (444,'Ivan','Valdenebro','Jimenez',3);

UPDATE alumnos SET nota = 2 WHERE id = 111;
UPDATE alumnos SET nota = 9.5 WHERE id = 222;
UPDATE alumnos SET nota = -4 WHERE id = 333;
UPDATE alumnos SET nota = 14 WHERE id = 444;


/*TRIIGER EMAIL*/

DROP TABLE IF EXISTS alumnos;
CREATE TABLE alumnos	(
								id INT(3) UNSIGNED PRIMARY KEY,
								nombre VARCHAR(50),
								apellido1 VARCHAR(50),
								apellido2 VARCHAR(50),
								email VARCHAR(100)
							);

DELIMITER $$

DROP FUNCTION IF EXISTS crear_email $$
CREATE FUNCTION crear_email(nombre_funcion VARCHAR(30), apellido1_funcion VARCHAR(30), apellido2_funcion VARCHAR(30), dominio VARCHAR(30)) RETURNS VARCHAR(100)
	BEGIN
		DECLARE correo_funcion VARCHAR(100);
		SELECT CONCAT((SUBSTRING(nombre_funcion,1)),(SUBSTRING(apellido1_funcion,1,3)),(SUBSTRING(apellido2_funcion,1,3)),'@',dominio)
		INTO correo_funcion;
		RETURN correo_funcion;
	END
$$

DELIMITER $$

DROP TRIGGER IF EXISTS trigger_crear_email_before_insert$$
CREATE TRIGGER trigger_crear_email_before_insert
BEFORE INSERT
ON alumnos FOR EACH ROW
	BEGIN
		IF (NEW.email IS NULL) THEN
			SET NEW.email = crear_email(NEW.nombre,NEW.apellido1,NEW.apellido2,'ejemplo.es');
		END IF;			
	END
$$

INSERT INTO alumnos(id,nombre,apellido1,apellido2) VALUES (111,'Alvaro','Martinez','Suarez');
INSERT INTO alumnos(id,nombre,apellido1,apellido2,email) VALUES (222,'Luis','Ruiz','Romero',NULL);
INSERT INTO alumnos(id,nombre,apellido1,apellido2,email) VALUES (333,'Antonio','Lopez','Fuentes','luisig@gmail.org');
INSERT INTO alumnos(id,nombre,apellido1,apellido2,email) VALUES (444,'Ivan','Valdenebro','Jimenez','hola@2');


/*GUARDAR EMAIL AFTER UPDATE*/

DELIMITER $$

DROP TABLE IF EXISTS log_cambios_email$$
CREATE TABLE log_cambios_email	(
												id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
												id_alumno INT,
												fecha_hora DATETIME DEFAULT SYSDATE(),
												old_email VARCHAR(100),
												new_email VARCHAR(100)
											);

DROP TRIGGER IF EXISTS trigger_guardar_email_after_update$$
CREATE TRIGGER trigger_guardar_email_after_update
AFTER UPDATE
ON alumnos FOR EACH ROW
	BEGIN
		INSERT INTO log_cambios_email (id_alumno,old_email,new_email)
		VALUES (OLD.id, OLD.email,NEW.email);
	END
$$

UPDATE alumnos SET email = 'alfonsoV@asd.eu' WHERE id = 111;


/*TRIGGER ALUMNOS ELIMINADOS*/

DELIMITER $$

DROP TABLE IF EXISTS log_alumnos_eliminados $$
CREATE TABLE log_alumnos_eliminados	(
													id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
													id_alumno INT,
													fecha_hora DATETIME DEFAULT SYSDATE(),
													nombre VARCHAR(50),
													apellido1 VARCHAR(50),
													apellido2 VARCHAR(50),
													email VARCHAR(100)													
												);

DELIMITER $$

DROP TRIGGER IF EXISTS trigger_guardar_alumnos_eliminados $$
CREATE TRIGGER trigger_guardar_alumnos_eliminados
AFTER DELETE
ON alumnos FOR EACH ROW
	BEGIN
		INSERT INTO log_alumnos_eliminados (id_alumno,nombre,apellido1,apellido2,email)
		VALUES (OLD.id, OLD.nombre,OLD.apellido1,OLD.apellido2,OLD.email);
	END
$$

DELETE FROM alumnos WHERE id=333;

		








