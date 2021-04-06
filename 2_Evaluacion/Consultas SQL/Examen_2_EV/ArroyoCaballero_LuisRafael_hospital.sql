/*CONSULTAS*/

/*1. Mostrar todos los datos de los pacientes que ya han terminado su estancia 0,75 puntos*/

SELECT paciente.*
FROM paciente
INNER JOIN estancia
ON estancia.nif_paciente = paciente.nif_paciente
WHERE estancia.fecha_salida > CURDATE();

/*2. Mostrar el número de la o las habitaciones más caras, junto con los nombres de los
pacientes que las han ocupado y el número de días de su estancia 0,75 puntos*/

SELECT habitacion.num_habitacion, paciente.nombre_paciente, DATEDIFF(estancia.fecha_salida,estancia.fecha_entrada)
FROM habitacion
INNER JOIN estancia
ON estancia.num_habitacion = habitacion.num_habitacion
INNER JOIN paciente
ON paciente.nif_paciente = estancia.nif_paciente
WHERE precio >= ALL	(
								SELECT precio
								FROM habitacion	
							);
							
/*3. Mostrar las compañías médicas y las especialidades de los ingresos que se han
producido en el mes de febrero. Muestra los datos ordenados de la A a la Z según la
compañía 0,75 puntos*/
							
SELECT paciente.compania_medica, habitacion.especialidad
FROM paciente
INNER JOIN estancia
ON estancia.nif_paciente = paciente.nif_paciente
INNER JOIN habitacion
ON habitacion.num_habitacion = estancia.num_habitacion
WHERE MONTH(estancia.fecha_entrada) = 2
ORDER BY paciente.compania_medica ASC;

/*4. Calcula cuánto ha sido el coste de todas las estancias que se han producido en la
especialidad de ginecología 0,75 puntos*/

-- SELECT SUM(COUNT())

/*MODIFICACION LOGICA DE LOS DATOS*/

/*1. Diseña una función a la que le pasemos los datos de la estancia de un determinado
paciente y nos devuelva el importe de esta, teniendo en cuenta que si el el paciente
pertenece a la compañía de ASISA su precio se verá incrementado un 25%. 0,5
puntos*/

DELIMITER $$

DROP FUNCTION IF EXISTS getImporte_estancia $$
CREATE FUNCTION getImporte_estancia(identificador_paciente VARCHAR(9)) RETURNS INT(5)
	BEGIN 
		DECLARE importe_estancia INT(4) DEFAULT 0;
		DECLARE compania_del_paciente VARCHAR(15);
		SELECT paciente.compania_medica
		INTO compania_del_paciente
		FROM paciente
		WHERE paciente.nif_paciente = identificador_paciente;
		SELECT SUM(habitacion.precio)
		INTO importe_estancia
		FROM habitacion
		INNER JOIN estancia
		ON habitacion.num_habitacion = estancia.num_habitacion
		INNER JOIN paciente
		ON paciente.nif_paciente = estancia.nif_paciente
		WHERE paciente.nif_paciente = identificador_paciente;
		
		IF (compania_del_paciente = 'ASISA') THEN
			SET importe_estancia = (importe_estancia*1.25);
		END IF;
		RETURN importe_estancia;
	END
$$

SELECT getImporte_estancia(60)$$


/*2. Diseña un procedimiento al que pasemos el nombre de una determinada compañía y
nos muestre los datos de los pacientes afiliados a dicha compañía que hayan estado
ingresados en el hospital 0,5 puntos*/

DELIMITER $$

DROP PROCEDURE IF EXISTS getClientList_compania $$
CREATE PROCEDURE getClientList_compania(nombre_compania_procedimiento VARCHAR(15))
	BEGIN
		SELECT paciente.*
		FROM paciente
		INNER JOIN estancia
		ON estancia.nif_paciente = paciente.nif_paciente
		WHERE paciente.nif_paciente = estancia.nif_paciente
		AND paciente.compania_medica = nombre_compania_procedimiento;
	END
$$

CALL getClientList_compania('ASISA')$$


/*3. Diseña un disparador para controlar que no se pueda ocupar una habitación si el
valor de la columna “ocupada” está a “SI” 0,75 puntos*/

DELIMITER $$

DROP TRIGGER IF EXISTS comprobar_ocupada_before_update$$
CREATE TRIGGER comprobar_ocupada_before_update
BEFORE UPDATE
ON habitacion FOR EACH ROW
	BEGIN
		IF (NEW.ocupada = 'NO') THEN
			INSERT INTO habitacion(ocupada)
			VALUES ('SI');
		END IF;
	END
$$



/*4. Diseña un disparador para controlar que la fecha de salida sea mayor que la fecha
de entrada 0,75 puntos*/

DELIMITER $$

DROP TRIGGER IF EXISTS controlar_fecha_salida_y_entrada $$
CREATE TRIGGER controlar_fecha_salida_y_entrada
AFTER INSERT
ON estancia FOR EACH ROW
	BEGIN
		IF (DATEDIFF(NEW.fecha_salida, NEW.fecha_entrada)<0) THEN
			INSERT INTO estancia(nif_paciente,num_habitacion,fecha_entrada,fecha_salida)
			VALUES (NEW.nif_paciente, NEW.num_habitacion,NEW.fecha_entrada,NEW.fecha_salida);
		END IF;
	END
$$

/*5. Diseña un disparador para que cuando haya finalizado la estancia de un paciente en
el hospital, actualice la columna “ocupada” de la habitación a “NO” 0,75 puntos*/

DELIMITER $$

DROP TRIGGER IF EXISTS trigger_estancia_finalizada $$
CREATE TRIGGER trigger_estancia_finalizada
BEFORE UPDATE
ON estancia FOR EACH ROW
	BEGIN
		DECLARE fecha_actual DATE;
		DECLARE fecha_salida_trig DATE DEFAULT CURDATE();
		DECLARE done INT DEFAULT 0;
		DECLARE cur CURSOR FOR SELECT fecha_salida FROM estancia;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

		OPEN cur;		
		REPEAT
			FETCH cur INTO fecha_salida_trig;
			IF NOT done THEN
				IF (fecha_salida_trig = CURDATE()) THEN
					SET habitacion.ocupada = 'NO'
					WHERE fecha_salida = fecha_salida_trig;
				END IF;
			END IF;
		UNTIL done END REPEAT;
		CLOSE cur;
	END
$$