DROP DATABASE IF EXISTS cursos;
CREATE DATABASE cursos;
USE cursos;

CREATE TABLE usuario(
	id_usuario INT(10) PRIMARY KEY,
	email VARCHAR(20)
);

CREATE TABLE archivos(
	cod_archivo INT(10) PRIMARY KEY,
	titulo VARCHAR(20) NOT NULL,
	contenido_archivo VARCHAR(20)
);

CREATE TABLE consulta(
	fecha_visualizacion DATE,
	id_usuario INT(10),
	cod_archivo INT(10),
	CONSTRAINT consulta_pk PRIMARY KEY (fecha_visualizacion, id_usuario, cod_archivo),
	CONSTRAINT archi_consulta_fk FOREIGN KEY (cod_archivo) REFERENCES archivos(cod_archivo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT usuario_consulta_fk FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE evaluadores(
	dni_evaluador CHAR(9) PRIMARY KEY,
	id_profesor INT(10) NOT NULL,
	telefono_profesor CHAR(9) NOT NULL
);

CREATE TABLE usuario_registrado(
	id_usuario INT(10) PRIMARY KEY,
	dni_evaluador CHAR(9),
	email VARCHAR(30) NOT NULL,
	contraseña VARCHAR(20) NOT NULL,
	CONSTRAINT usuario_usuregis_fk FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT evaluadores_usuregis_fk FOREIGN KEY (dni_evaluador) REFERENCES evaluadores(dni_evaluador) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE creador_contenido(
	dni_creador CHAR(9) PRIMARY KEY,
	id_profesor INT(10) NOT NULL,
	telefono_profesor CHAR(9) NOT NULL
);

CREATE TABLE videos(
	cod_video INT(10) PRIMARY KEY,
	duracion_video TIME NOT NULL,
	titulo_video VARCHAR(20) NOT NULL,
	imagen_video VARCHAR(10),
	dni_creador CHAR(9),
	fecha_subida DATE,
	CONSTRAINT creador_videos_fk FOREIGN KEY (dni_creador) REFERENCES creador_contenido(dni_creador) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ven(
	fecha_visualizacion DATE,
	cod_video INT(10),
	id_usuario INT(10),
	CONSTRAINT ven_pk PRIMARY KEY (fecha_visualizacion, cod_video, id_usuario),
	CONSTRAINT video_ven_fk FOREIGN KEY (cod_video) REFERENCES videos(cod_video) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT usuario_ven_fk FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO usuario(id_usuario, email) VALUES('1','usuario1@gmail.com');
INSERT INTO usuario(id_usuario, email) VALUES('2','usuario2@gmail.com');
INSERT INTO usuario(id_usuario, email) VALUES('3','usuario3@gmail.com');

INSERT INTO archivos(cod_archivo, titulo, contenido_archivo) VALUES('1','archivo1','texto1');
INSERT INTO archivos(cod_archivo, titulo, contenido_archivo) VALUES('2','archivo2','texto2');
INSERT INTO archivos(cod_archivo, titulo, contenido_archivo) VALUES('3','archivo3','texto3');

INSERT INTO consulta(fecha_visualizacion, id_usuario, cod_archivo) VALUES('2019/06/12','1','1');
INSERT INTO consulta(fecha_visualizacion, id_usuario, cod_archivo) VALUES('2017/02/23','2','2');
INSERT INTO consulta(fecha_visualizacion, id_usuario, cod_archivo) VALUES('2016/09/30','3','3');

INSERT INTO evaluadores(dni_evaluador, id_profesor, telefono_profesor) VALUES('15632498D','1','326598741');
INSERT INTO evaluadores(dni_evaluador, id_profesor, telefono_profesor) VALUES('23654789K','2','986326548');
INSERT INTO evaluadores(dni_evaluador, id_profesor, telefono_profesor) VALUES('23659874E','3','653298712');

INSERT INTO usuario_registrado(id_usuario, dni_evaluador, email, contraseña) VALUES('1','15632498D','usuario1@gmail.com','contraseña1');
INSERT INTO usuario_registrado(id_usuario, dni_evaluador, email, contraseña) VALUES('2','23654789K','usuario2@gmail.com','contraseña2');
INSERT INTO usuario_registrado(id_usuario, dni_evaluador, email, contraseña) VALUES('3','23659874E','usuario3@gmail.com','contraseña3');

INSERT INTO creador_contenido(dni_creador, id_profesor, telefono_profesor) VALUES('12365987Ñ','1','326598741');
INSERT INTO creador_contenido(dni_creador, id_profesor, telefono_profesor) VALUES('21569874N','5','563987452');
INSERT INTO creador_contenido(dni_creador, id_profesor, telefono_profesor) VALUES('23659874K','3','653298712');

INSERT INTO videos(cod_video, duracion_video, titulo_video, imagen_video, dni_creador, fecha_subida)
VALUES ('1','30:01','video1','imagen1','12365987Ñ','2019/02/10');
INSERT INTO videos(cod_video, duracion_video, titulo_video, imagen_video, dni_creador, fecha_subida)
VALUES ('2','25:20','video2','imagen3','21569874N','2015/09/16');
INSERT INTO videos(cod_video, duracion_video, titulo_video, imagen_video, dni_creador, fecha_subida)
VALUES ('3','42:20','video3','imagen4','23659874K','2015/01/25');

INSERT INTO ven(fecha_visualizacion, cod_video, id_usuario) VALUES('2012/06/12','1','1');
INSERT INTO ven(fecha_visualizacion, cod_video, id_usuario) VALUES('2017/02/30','2','2');
INSERT INTO ven(fecha_visualizacion, cod_video, id_usuario) VALUES('2016/09/30','3','3');


SELECT * FROM usuario_registrado
WHERE dni_evaluador LIKE '23%';

SELECT id_profesor, telefono_profesor FROM evaluadores
WHERE dni_evaluador=(
	SELECT dni_evaluador FROM usuario_registrado
	WHERE dni_evaluador='23659874E'); 
	
s