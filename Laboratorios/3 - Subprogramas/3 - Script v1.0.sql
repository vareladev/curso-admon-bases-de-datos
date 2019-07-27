CREATE TABLE categoria
(
    id INT,
    nombre VARCHAR2(60)
);

CREATE TABLE pelicula
(
    id INT,
    titulo VARCHAR2(150),
    fecha_lanzamiento DATE,
    valoracion DECIMAL(2,1),
    duracion_min INT
);

CREATE TABLE categoriaXpelicula
(
    categoria_id INT,
    pelicula_id INT
);

CREATE TABLE idioma
(
    id CHAR(2),
    nombre VARCHAR2(30)
);

CREATE TABLE idiomaXpelicula
(
    pelicula_id INT,
    idioma_id CHAR(2),
    tipo VARCHAR2(8)
);

CREATE TABLE actor
(
    id INT,
    nombre VARCHAR2(120)
);

CREATE TABLE elenco
(
    actor_id INT,
    pelicula_id INT,
    rol VARCHAR2(10)
);

-- Agregando llaves primarias y foráneas
ALTER TABLE categoria ADD CONSTRAINT PK_categoria PRIMARY KEY (id);
ALTER TABLE pelicula ADD CONSTRAINT PK_pelicula PRIMARY KEY (id);
ALTER TABLE idioma ADD CONSTRAINT PK_idioma PRIMARY KEY (id);
ALTER TABLE actor ADD CONSTRAINT PK_actor PRIMARY KEY (id);
ALTER TABLE categoriaXpelicula ADD CONSTRAINT PK_categoriaXpelicula PRIMARY KEY (categoria_id, pelicula_id);
ALTER TABLE idiomaXpelicula ADD CONSTRAINT PK_idiomaXpelicula PRIMARY KEY (idioma_id, pelicula_id);
ALTER TABLE elenco ADD CONSTRAINT PK_elenco PRIMARY KEY (actor_id, pelicula_id);
ALTER TABLE categoriaXpelicula ADD CONSTRAINT FK_categoria_pelicula FOREIGN KEY (categoria_id) REFERENCES categoria (id);
ALTER TABLE categoriaXpelicula ADD CONSTRAINT FK_pelicula_categoria FOREIGN KEY (pelicula_id) REFERENCES pelicula (id);
ALTER TABLE idiomaXpelicula ADD CONSTRAINT FK_idiomaXpelicula_idioma FOREIGN KEY (idioma_id) REFERENCES idioma (id);
ALTER TABLE idiomaXpelicula ADD CONSTRAINT FK_idiomaXpelicula_pelicula FOREIGN KEY (pelicula_id) REFERENCES pelicula (id);
ALTER TABLE elenco ADD CONSTRAINT FK_elenco_actor FOREIGN KEY (actor_id) REFERENCES actor (id);
ALTER TABLE elenco ADD CONSTRAINT FK_elenco_pelicula FOREIGN KEY (pelicula_id) REFERENCES pelicula (id);

-- Agregando validaciones
ALTER TABLE pelicula ADD CONSTRAINT CK_pelicula_valoracion CHECK (valoracion BETWEEN 0 AND 5);
ALTER TABLE idiomaXpelicula ADD CONSTRAINT CK_idiomaXpelicula_tipo CHECK (tipo IN ('original', 'doblado'));
ALTER TABLE elenco ADD CONSTRAINT CK_elenco_rol CHECK (rol IN ('principal', 'secundario'));

INSERT INTO categoria VALUES (1, 'Acción');
INSERT INTO categoria VALUES (2, 'Animada');
INSERT INTO categoria VALUES (3, 'Ciencia ficción');
INSERT INTO categoria VALUES (4, 'Comedia');
INSERT INTO categoria VALUES (5, 'Drama');
INSERT INTO categoria VALUES (6, 'Infantil');
INSERT INTO categoria VALUES (7, 'Policíaca');
INSERT INTO categoria VALUES (8, 'Suspenso');
INSERT INTO categoria VALUES (9, 'Romántica');

INSERT INTO idioma VALUES ('EN', 'Inglés');
INSERT INTO idioma VALUES ('ES', 'Español');
INSERT INTO idioma VALUES ('FR', 'Francés');

INSERT INTO actor VALUES (1, 'Vin Diesel');
INSERT INTO actor VALUES (2, 'Paul Walker');
INSERT INTO actor VALUES (3, 'Dwayne Johnson');
INSERT INTO actor VALUES (4, 'Michelle Rodríguez');
INSERT INTO actor VALUES (5, 'Gal Galdot');
INSERT INTO actor VALUES (6, 'Elsa Pataky');
INSERT INTO actor VALUES (7, 'Tego Calderón');
INSERT INTO actor VALUES (8, 'Eva Mendes');
INSERT INTO actor VALUES (9, 'Tyrese Gibson');

INSERT INTO pelicula VALUES (1, 'Rápido y furioso', TO_DATE('22/06/2001', 'dd/mm/yyyy'), 5.0, 107);
INSERT INTO pelicula VALUES (2, 'Más rápido y más furioso', TO_DATE('06/06/2003', 'dd/mm/yyyy'), 4.8, 107);
INSERT INTO pelicula VALUES (3, 'Rápido y furioso: Reto Tokio', TO_DATE('16/06/2006', 'dd/mm/yyyy'), 3.2, 104);
INSERT INTO pelicula VALUES (4, 'Rápidos y furiosos', TO_DATE('02/04/2009', 'dd/mm/yyyy'), 3.8, 107);
INSERT INTO pelicula VALUES (5, 'Rápidos y furiosos: 5in control', TO_DATE('29/04/2011', 'dd/mm/yyyy'), 4.3, 130);
INSERT INTO pelicula VALUES (6, 'Rápidos y furiosos 6', TO_DATE('24/05/2013', 'dd/mm/yyyy'), 4.5, 130);
INSERT INTO pelicula VALUES (7, 'Rápidos y furiosos 7', TO_DATE('03/04/2015', 'dd/mm/yyyy'), 4.7, 137);
INSERT INTO pelicula VALUES (8, 'Rápidos y furiosos 8', TO_DATE('14/04/2017', 'dd/mm/yyyy'), 4.6, 136);

INSERT INTO idiomaXpelicula VALUES (1,'EN','original');
INSERT INTO idiomaXpelicula VALUES (2,'EN','original');
INSERT INTO idiomaXpelicula VALUES (3,'EN','original');
INSERT INTO idiomaXpelicula VALUES (4,'EN','original');
INSERT INTO idiomaXpelicula VALUES (5,'EN','original');
INSERT INTO idiomaXpelicula VALUES (6,'EN','original');
INSERT INTO idiomaXpelicula VALUES (7,'EN','original');
INSERT INTO idiomaXpelicula VALUES (8,'EN','original');
INSERT INTO idiomaXpelicula VALUES (1,'ES','doblado');
INSERT INTO idiomaXpelicula VALUES (2,'ES','doblado');
INSERT INTO idiomaXpelicula VALUES (3,'ES','doblado');
INSERT INTO idiomaXpelicula VALUES (6,'ES','doblado');
INSERT INTO idiomaXpelicula VALUES (7,'ES','doblado');
INSERT INTO idiomaXpelicula VALUES (8,'ES','doblado');
INSERT INTO idiomaXpelicula VALUES (1,'FR','doblado');
INSERT INTO idiomaXpelicula VALUES (2,'FR','doblado');
INSERT INTO idiomaXpelicula VALUES (3,'FR','doblado');

INSERT INTO categoriaXpelicula VALUES (1,1);
INSERT INTO categoriaXpelicula VALUES (1,2);
INSERT INTO categoriaXpelicula VALUES (1,3);
INSERT INTO categoriaXpelicula VALUES (1,4);
INSERT INTO categoriaXpelicula VALUES (1,5);
INSERT INTO categoriaXpelicula VALUES (1,6);
INSERT INTO categoriaXpelicula VALUES (1,7);
INSERT INTO categoriaXpelicula VALUES (1,8);
INSERT INTO categoriaXpelicula VALUES (8,1);
INSERT INTO categoriaXpelicula VALUES (8,2);
INSERT INTO categoriaXpelicula VALUES (8,3);
INSERT INTO categoriaXpelicula VALUES (8,4);
INSERT INTO categoriaXpelicula VALUES (8,5);
INSERT INTO categoriaXpelicula VALUES (8,6);
INSERT INTO categoriaXpelicula VALUES (8,7);
INSERT INTO categoriaXpelicula VALUES (8,8);
INSERT INTO categoriaXpelicula VALUES (3,6);
INSERT INTO categoriaXpelicula VALUES (3,7);
INSERT INTO categoriaXpelicula VALUES (3,8);

INSERT INTO elenco VALUES (1,1,'principal');
INSERT INTO elenco VALUES (1,3,'secundario');
INSERT INTO elenco VALUES (1,4,'principal');
INSERT INTO elenco VALUES (1,5,'principal');
INSERT INTO elenco VALUES (1,6,'principal');
INSERT INTO elenco VALUES (1,7,'principal');
INSERT INTO elenco VALUES (1,8,'principal');
INSERT INTO elenco VALUES (2,1,'principal');
INSERT INTO elenco VALUES (2,2,'principal');
INSERT INTO elenco VALUES (2,4,'principal');
INSERT INTO elenco VALUES (2,5,'principal');
INSERT INTO elenco VALUES (2,6,'principal');
INSERT INTO elenco VALUES (2,7,'principal');
INSERT INTO elenco VALUES (3,5,'principal');
INSERT INTO elenco VALUES (3,6,'principal');
INSERT INTO elenco VALUES (3,7,'principal');
INSERT INTO elenco VALUES (3,8,'principal');
INSERT INTO elenco VALUES (4,1,'secundario');
INSERT INTO elenco VALUES (4,6,'principal');
INSERT INTO elenco VALUES (4,7,'principal');
INSERT INTO elenco VALUES (4,8,'principal');
INSERT INTO elenco VALUES (5,4,'secundario');
INSERT INTO elenco VALUES (5,5,'principal');
INSERT INTO elenco VALUES (5,6,'principal');
INSERT INTO elenco VALUES (6,5,'principal');
INSERT INTO elenco VALUES (6,6,'secundario');
INSERT INTO elenco VALUES (6,7,'secundario');
INSERT INTO elenco VALUES (6,8,'secundario');
INSERT INTO elenco VALUES (7,4,'secundario');
INSERT INTO elenco VALUES (7,5,'secundario');
INSERT INTO elenco VALUES (8,2,'secundario');
INSERT INTO elenco VALUES (9,2,'principal');
INSERT INTO elenco VALUES (9,5,'principal');
INSERT INTO elenco VALUES (9,6,'principal');
INSERT INTO elenco VALUES (9,7,'principal');
INSERT INTO elenco VALUES (9,8,'principal');