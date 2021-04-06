DROP DATABASE IF EXISTS appvideos;
CREATE DATABASE appvideos;
USE appvideos;

CREATE TABLE usuario(
	id_usuario INT(10) PRIMARY KEY,
	nombre_usuario VARCHAR(20) NOT NULL,
	email VARCHAR(30) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	contraseña VARCHAR(20) NOT NULL
);

CREATE TABLE videos(
	cod_video INT(10) PRIMARY KEY,
	titulo_video VARCHAR(30) NOT NULL,
	duracion_video TIME(5) NOT NULL,
	imagen_video VARCHAR(30) NOT NULL,
	video VARCHAR(30) NOT NULL
);

CREATE TABLE visualiza(
	fecha_hora_vis DATE PRIMARY KEY,
	id_usuario INT(10),
	cod_video INT(10),
	CONSTRAINT usu_visualiza_fk FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT videos_visualiza_fk FOREIGN KEY (cod_video) REFERENCES videos(cod_video) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE genero(
	cod_genero INT(5) PRIMARY KEY,
	nombre_genero VARCHAR(20) NOT NULL
);

CREATE TABLE pertenece(
	cod_video INT(10),
	cod_genero INT(5),
	CONSTRAINT pertenece_pk PRIMARY KEY (cod_video, cod_genero),
	CONSTRAINT videos_pertenece_fk FOREIGN KEY (cod_video) REFERENCES visualiza(cod_video) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT genero_pertenece_fk FOREIGN KEY (cod_genero) REFERENCES genero(cod_genero) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE premium(
	id_usuario INT(10) PRIMARY KEY,
	telefono_premium CHAR(9) UNIQUE,
	fecha_renovacion DATE DEFAULT SYSDATE(),
	CONSTRAINT usu_premium_fk FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE playlist(
	id_playlist INT(5) PRIMARY KEY,
	id_usuario INT(10),
	titulo_playlist VARCHAR(20) NOT NULL,
	num_vid_playlist INT(10) NOT NULL,
	CONSTRAINT usu_playlist_fk FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE guardan(
	cod_video INT(10),
	id_playlist INT(5),
	CONSTRAINT guardan_pk PRIMARY KEY (cod_video, id_playlist),
	CONSTRAINT video_guardan_fk FOREIGN KEY (cod_video) REFERENCES videos(cod_video) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT play_guardan_fk FOREIGN KEY (id_playlist) REFERENCES playlist(id_playlist) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE pelicula(
	cod_video INT(10) PRIMARY KEY,
	director_pelicula VARCHAR(15),
	CONSTRAINT video_pelicula_fk FOREIGN KEY (cod_video) REFERENCES videos(cod_video) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE serie(
	cod_serie INT(4) PRIMARY KEY,
	nombre_serie VARCHAR(20) NOT NULL
);

CREATE TABLE episodio(
	cod_video INT(10),
	numero_episodio INT(4) NOT NULL,
	temporada_episodio INT(2) NOT NULL,
	cod_serie INT(4),
	CONSTRAINT episodio_pk PRIMARY KEY (cod_video, cod_serie),
	CONSTRAINT episodio_serie_fk FOREIGN KEY (cod_serie) REFERENCES serie(cod_serie) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT episodio_video_fk FOREIGN KEY (cod_video) REFERENCES videos(cod_video) ON DELETE CASCADE ON UPDATE CASCADE
);

USE appvideos;

INSERT INTO usuario(id_usuario, nombre_usuario, email, fecha_nacimiento, contraseña)
VALUES('1', 'Pedro', 'Pedro_usu1@hotmail.com', '1995/10/5', 'usuario1');

INSERT INTO usuario(id_usuario, nombre_usuario, email, fecha_nacimiento, contraseña)
VALUES('2', 'Maria', 'Maria_usu2@hotmail.com', '1999/11/7', 'usuario2');

INSERT INTO usuario(id_usuario, nombre_usuario, email, fecha_nacimiento, contraseña)
VALUES('3', 'Luis', 'Luis_usu3@hotmail.com', '2000/05/12', 'usuario3');

INSERT INTO videos(cod_video, titulo_video, duracion_video, imagen_video, video)
VALUES ('1', 'video1', '26:20', 'imagen1', 'lectura');

INSERT INTO videos(cod_video, titulo_video, duracion_video, imagen_video, video)
VALUES ('2', 'video2', '32:10', 'imagen2', 'cocina');

INSERT INTO videos(cod_video, titulo_video, duracion_video, imagen_video, video)
VALUES ('3', 'video3', '51:20', 'imagen3', 'coches');

INSERT INTO visualiza(fecha_hora_vis, id_usuario, cod_video)
VALUES ('2015/05/03','1','3');

INSERT INTO visualiza(fecha_hora_vis,id_usuario, cod_video)
VALUES ('2018/02/05','2','1');

INSERT INTO visualiza(fecha_hora_vis,id_usuario, cod_video)
VALUES ('2019/02/07','3','2');

INSERT INTO genero(cod_genero, nombre_genero)
VALUES ('1','Drama');

INSERT INTO genero(cod_genero, nombre_genero)
VALUES ('2','Cocina');

INSERT INTO genero(cod_genero, nombre_genero)
VALUES ('3','Automovil');

INSERT INTO pertenece(cod_video, cod_genero)
VALUES ('1','1');

INSERT INTO pertenece(cod_video, cod_genero)
VALUES ('2','2');

INSERT INTO pertenece(cod_video, cod_genero)
VALUES ('3','3');

INSERT INTO premium(id_usuario, telefono_premium)
VALUES ('1','123456789');

INSERT INTO premium(id_usuario, telefono_premium)
VALUES ('2','213654789');

INSERT INTO premium(id_usuario, telefono_premium)
VALUES ('3','231569874');

INSERT INTO playlist(id_playlist, id_usuario, titulo_playlist, num_vid_playlist)
VALUES ('1', '1', 'ListaDrama' ,'12');

INSERT INTO playlist(id_playlist, id_usuario, titulo_playlist, num_vid_playlist)
VALUES ('2', '2', 'ListaCocina' ,'15');

INSERT INTO playlist(id_playlist, id_usuario, titulo_playlist, num_vid_playlist)
VALUES ('3', '3', 'ListaCoches' ,'17');

INSERT INTO guardan(cod_video, id_playlist)
VALUES ('1', '1');

INSERT INTO guardan(cod_video, id_playlist)
VALUES ('2', '2');

INSERT INTO guardan(cod_video, id_playlist)
VALUES ('3', '3');

INSERT INTO pelicula(director_pelicula)
VALUES ('Lasse Hallstrom');

INSERT INTO pelicula(director_pelicula)
VALUES ('Scott Hicks');

INSERT INTO pelicula(director_pelicula)
VALUES ('James Mangold');

INSERT INTO serie(cod_serie, nombre_serie)
VALUES ('1','Bones');

INSERT INTO serie(cod_serie, nombre_serie)
VALUES ('2','Arguiñano Hoy');

INSERT INTO serie(cod_serie, nombre_serie)
VALUES ('3','Driver To Survive');

INSERT INTO episodio(cod_video, numero_episodio, temporada_episodio, cod_serie)
VALUES ('1','20','2','1');

INSERT INTO episodio(cod_video, numero_episodio, temporada_episodio, cod_serie)
VALUES ('2','16','5','2');

INSERT INTO episodio(cod_video, numero_episodio, temporada_episodio, cod_serie)
VALUES ('3','14','2','3');

SELECT * FROM usuario;

SELECT nombre_usuario FROM usuario
WHERE id_usuario=(
	SELECT id_usuario FROM premium
	WHERE telefono_premium=231569874); 