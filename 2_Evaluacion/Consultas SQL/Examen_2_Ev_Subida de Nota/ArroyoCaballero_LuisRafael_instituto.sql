/*CONSULTAS*/

/*1. Mostrar todos los datos de los profesores que dan clase en DAW1.*/

SELECT persona.*
FROM persona
INNER JOIN profesor
ON profesor.id_profesor = persona.id
INNER JOIN modulo
ON modulo.id_profesor = profesor.id_profesor
INNER JOIN curso
ON curso.id = modulo.id_curso
WHERE persona.tipo = 'profesor'
AND curso.nombre = 'DAW1';

/*2. Devuelve un listado con los datos de todos los alumnos que, habiendo nacido antes de 1996, 
se han matriculado alguna vez en “Programación” de 1º de DAW.*/

SELECT persona.*
FROM persona
INNER JOIN alumno_se_matricula_modulo
ON alumno_se_matricula_modulo.id_alumno = persona.id
WHERE persona.tipo = 'alumno'
AND MONTH(fecha_nacimiento) < 1996 
AND alumno_se_matricula_modulo.id_modulo = 1;


/*3. Devuelve un listado con el curso escolar y el nombre de los módulos en los que se
ha matriculado el alumno con id 4 */

SELECT curso_escolar.anio, modulo.nombre
FROM curso_escolar
INNER JOIN alumno_se_matricula_modulo
ON alumno_se_matricula_modulo.id_curso_escolar = curso_escolar.id
INNER JOIN modulo
ON modulo.id = alumno_se_matricula_modulo.id_modulo
WHERE id_alumno = 4;


/*4. Muestra el listado de módulos que están adscritos al departamento de “Desarrollo”.
Solo debes mostrar el nombre de los módulos ordenados de forma descendente.*/

SELECT modulo.nombre
FROM modulo
INNER JOIN profesor
ON profesor.id_profesor = modulo.id_profesor
INNER JOIN departamento
ON departamento.id = profesor.id_departamento
WHERE departamento.nombre = 'Desarrollo'
ORDER BY modulo.nombre DESC;

/*5. Calcula cuántos alumnos se han matriculado en el instituto en el curso actual (2020).*/

SELECT COUNT(DISTINCT alumno_se_matricula_modulo.id_alumno)
FROM alumno_se_matricula_modulo
INNER JOIN curso_escolar
ON curso_escolar.id = alumno_se_matricula_modulo.id_curso_escolar
WHERE curso_escolar.anio = 2020;


/*MANIPULACION LOGICA DE LOS DATOS*/

/*1. Diseña una función a la que le pasemos el id del módulo y nos devuelva el nombre
del profesor que lo imparte*/

DELIMITER $$
DROP FUNCTION IF EXISTS getProfByModulo$$
CREATE FUNCTION getProfByModulo(id_modulo_funcion INT(10)) RETURNS VARCHAR(25)
	BEGIN 
		DECLARE nombre_profesor VARCHAR(25);
		SELECT persona.nombre
		INTO nombre_profesor
		FROM persona
		INNER JOIN modulo
		ON modulo.id_profesor = persona.id
		WHERE persona.tipo = 'profesor'
		AND modulo.id = id_modulo_funcion;
		RETURN nombre_profesor;
		
	END
$$

SELECT getProfByModulo(1)$$

/*2. Diseña un procedimiento al que pasemos el nombre de un módulo y nos muestre
todos los datos de los alumnos que se han matriculado en éste.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS getAlumnosMatriculadosEnModulo$$
CREATE PROCEDURE getAlumnosMatriculadosEnModulo(nombre_modulo_procedimiento VARCHAR(100))
	BEGIN 
		SELECT persona.*
		FROM persona
		INNER JOIN alumno_se_matricula_modulo
		ON alumno_se_matricula_modulo.id_alumno = persona.id
		INNER JOIN modulo
		ON modulo.id = alumno_se_matricula_modulo.id_modulo
		WHERE modulo.nombre = nombre_modulo_procedimiento;
	END
$$

CALL getAlumnosMatriculadosEnModulo('Seguridad Informática')$$


/*3. En nuestro instituto, se permite que haya un máximo de 3 profesores adscritos a
cada departamento. Diseña un disparador para controlar que no se pueda insertar a
un nuevo profesor en un determinado departamento si en éste ya hay 3 profesores.*/

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_max_profesores_depto$$
CREATE TRIGGER trigger_max_profesores_depto
AFTER INSERT
ON profesor FOR EACH ROW
	BEGIN
		DECLARE cuenta_prof_dept INT DEFAULT 0;
		SELECT COUNT(profesor.id_profesor)
		INTO cuenta_prof_dept
		FROM profesor
		WHERE profesor.id_departamento = NEW.id_departamento;
		
		IF (cuenta_prof_dept > 3) THEN
		DELETE FROM profesor WHERE id_profesor = NEW.id_profesor;
		END IF;
	END
$$


/*4. Diseña un disparador o disparadores para controlar que los alumnos se matriculan
en los módulos dentro de los rangos que la nos permite la normativa:

a. Solo se podrá matricular de módulos de un mismo ciclo (SMR o DAW)

b. Se podrá matricular de módulos de 2º curso, siempre que los créditos totales
de la matrícula no superen los 1000

Ten en cuenta que debemos controlarlo tanto si se inserta una nueva matrícula como
si se modifica una ya existente*/

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_matricula_de_alumnos$$
CREATE TRIGGER trigger_matricula_de_alumnos
AFTER INSERT
ON alumno_se_matricula_modulo FOR EACH ROW
	BEGIN
		DECLARE ciclo_del_alumno INT DEFAULT 0;
		DECLARE conteo_creditos INT DEFAULT 0;
		SELECT curso.nombre
		INTO ciclo_del_alumno
		FROM curso
		INNER JOIN modulo
		ON modulo.id_curso = curso.id
		INNER JOIN alumno_se_matricula_modulo
		ON alumno_se_matricula_modulo.id_modulo = modulo.id
		WHERE NEW.id_alumno = alumno_se_matricula_modulo.id_alumno
		LIMIT 1;
		
		IF (ciclo_del_alumno = 'DAW1' OR ciclo_del_alumno = 'DAW2') THEN
			SELECT SUM(modulo.creditos)
			INTO conteo_creditos
			FROM modulo
			INNER JOIN alumno_se_matricula_modulo
			ON alumno_se_matricula_modulo.id_modulo = modulo.id
			WHERE (modulo.id_curso = 1 OR modulo.id_curso = 2) 
			AND alumno_se_matricula_modulo.id_alumno = NEW.id_alumno;
			IF (conteo_creditos > 1000 AND ciclo_del_alumno = 'SMR1' OR ciclo_del_alumno = 'SMR2') THEN
				DELETE FROM alumno_se_matricula_modulo 
				WHERE id_alumno = NEW.id_alumno 
				AND id_modulo = NEW.id_modulo
				AND id_curso_escolar = NEW.id_curso_escolar;
			END IF;
		ELSEIF (ciclo_del_alumno = 'SMR1' OR ciclo_del_alumno = 'SMR2') THEN
			SELECT SUM(modulo.creditos)
			INTO conteo_creditos
			FROM modulo
			INNER JOIN alumno_se_matricula_modulo
			ON alumno_se_matricula_modulo.id_modulo = modulo.id
			WHERE (modulo.id_curso = 3 OR modulo.id_curso = 4) 
			AND alumno_se_matricula_modulo.id_alumno = NEW.id_alumno;
			IF (conteo_creditos > 1000 AND ciclo_del_alumno = 'DAW1' OR ciclo_del_alumno = 'DAW2') THEN
				DELETE FROM alumno_se_matricula_modulo 
				WHERE id_alumno = NEW.id_alumno 
				AND id_modulo = NEW.id_modulo
				AND id_curso_escolar = NEW.id_curso_escolar;
			END IF;
		END IF;
	END
$$
