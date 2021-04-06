DROP DATABASE IF EXISTS DDL_Proyecto;
CREATE DATABASE DDL_Proyecto;
USE DDL_Proyecto;

CREATE TABLE arma	(
								id_arma VARCHAR(5),
								calidad_arma INT(1) CHECK(calidad_arma = 1 OR calidad_arma = 2 OR calidad_arma = 3 OR calidad_arma = 4 OR calidad_arma = 5),
								tipo_arma VARCHAR(15) CHECK(tipo_arma = 'Espada Pesada' OR tipo_arma = 'Espada Ligera' OR tipo_arma = 'Arco' OR tipo_arma = 'Lanza' OR tipo_arma = 'Catalizador'),
								CONSTRAINT pk_arma PRIMARY KEY (id_arma)
							);
							
CREATE TABLE elemento	(
									id_elemento VARCHAR(5),
									tipo_elemento VARCHAR(7) CHECK(tipo_elemento = 'Electro' OR tipo_elemento = 'Dendro' OR tipo_elemento = 'Cryo' OR tipo_elemento = 'Pyro' OR tipo_elemento = 'Anemo' OR tipo_elemento = 'Geo' OR tipo_elemento = 'Hydro'),
									CONSTRAINT pk_elemento PRIMARY KEY (id_elemento)
								);

CREATE TABLE personaje	(
									id_personaje VARCHAR(5),
									calidad_pj VARCHAR(1) CHECK(calidad_pj = 4 OR calidad_pj = 5),
									id_arma VARCHAR(5),
									id_elemento VARCHAR(5),
									CONSTRAINT pk_personaje PRIMARY KEY (id_personaje),
									CONSTRAINT fk_arma_personaje FOREIGN KEY (id_arma) REFERENCES arma(id_arma) ON DELETE CASCADE ON UPDATE CASCADE,
									CONSTRAINT fk_elemento_personaje FOREIGN KEY (id_elemento) REFERENCES elemento(id_elemento) ON DELETE CASCADE ON UPDATE CASCADE
								);

CREATE TABLE habilidad	(
										id_habilidad VARCHAR(5),
										tiempo_espera DOUBLE(3,2),
										tipo_hab VARCHAR(1),
										id_personaje VARCHAR(5),
										CONSTRAINT pk_habilidad PRIMARY KEY (id_habilidad),
										CONSTRAINT fk_personaje_habilidad FOREIGN KEY (id_personaje) REFERENCES personaje(id_personaje) ON DELETE CASCADE ON UPDATE CASCADE
									);
									
CREATE TABLE habilidad_q	(
										id_habilidad VARCHAR(5),
										energia INT(2),
										CONSTRAINT pk_habilidad_q PRIMARY KEY (id_habilidad),
										CONSTRAINT fk_habilidad_habilidad_q FOREIGN KEY (id_habilidad) REFERENCES habilidad(id_habilidad) ON DELETE CASCADE ON UPDATE CASCADE
									);
																					
CREATE TABLE artefacto	(
									id_artefacto VARCHAR(5),
									tipo_artefacto VARCHAR(15) CHECK(tipo_artefacto = 'Casco' OR tipo_artefacto = 'Pechera' OR  tipo_artefacto = 'Guantes' OR  tipo_artefacto = 'Cinturon' OR  tipo_artefacto = 'Botas'),
									CONSTRAINT pk_artefacto PRIMARY KEY (id_artefacto)
								);

CREATE TABLE material	(
									id_material VARCHAR(5),
									tipo_material VARCHAR(10) CHECK(tipo_material = 'Piedra' OR tipo_material = 'Libros' OR tipo_material = 'Plantas'),
									CONSTRAINT pk_material PRIMARY KEY (id_material)
								);

CREATE TABLE mat_mejora_pj	(
											id_material VARCHAR(5),
											id_personaje VARCHAR(5),
											CONSTRAINT pk_mat_mejoran_pj PRIMARY KEY (id_material, id_personaje),
											CONSTRAINT fk_material_mat_mejoran_pj FOREIGN KEY (id_material) REFERENCES material(id_material) ON DELETE CASCADE ON UPDATE CASCADE,
											CONSTRAINT fk_personaje_mat_mejoran_pj FOREIGN KEY (id_personaje) REFERENCES personaje(id_personaje) ON DELETE CASCADE ON UPDATE CASCADE
										);

CREATE TABLE mat_mejora_arma	(
												id_material VARCHAR(5),
												id_arma VARCHAR(5),
												CONSTRAINT pk_mat_mejora_arma PRIMARY KEY (id_material, id_arma),
												CONSTRAINT fk_material_mat_mejora_arma FOREIGN KEY (id_material) REFERENCES material(id_material) ON DELETE CASCADE ON UPDATE CASCADE,
												CONSTRAINT fk_arma_mat_mejora_arma FOREIGN KEY (id_arma) REFERENCES arma(id_arma) ON DELETE CASCADE ON UPDATE CASCADE
											);

CREATE TABLE pj_usa_art	(
									id_artefacto VARCHAR(5),
									id_personaje VARCHAR(5),
									CONSTRAINT pk_pj_usa_art PRIMARY KEY (id_artefacto, id_personaje),
									CONSTRAINT fk_artefacto_pj_usa_art FOREIGN KEY (id_artefacto) REFERENCES artefacto(id_artefacto) ON DELETE CASCADE ON UPDATE CASCADE,
									CONSTRAINT fk_personaje_pj_usa_art FOREIGN KEY (id_personaje) REFERENCES personaje(id_personaje) ON DELETE CASCADE ON UPDATE CASCADE
								);

CREATE TABLE art_se_mejora	(
										id_artefacto VARCHAR(5),
										id_artefacto_usado VARCHAR(5),
										CONSTRAINT pk_art_se_mejora PRIMARY KEY (id_artefacto, id_artefacto_usado),
										CONSTRAINT fk_artefacto_art_se_mejora FOREIGN KEY (id_artefacto) REFERENCES artefacto(id_artefacto) ON DELETE CASCADE ON UPDATE CASCADE,
										CONSTRAINT fk_artefacto_art_se_mejora_usado FOREIGN KEY (id_artefacto_usado) REFERENCES artefacto(id_artefacto) ON DELETE CASCADE ON UPDATE CASCADE
									);
									