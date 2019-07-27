CREATE TABLE video_juego(
		Idjuego INT,
		nombreJuego VARCHAR(20),
		GeneroJuego INT,
		CantidadStock INT,
		EmpresaDesarrolladoraId INT,
		Precio_Juego FLOAT
);

CREATE TABLE GeneroJuego(
		GeneroJuego INT,
		Nombre_genero varchar(30),
		Informacion_genero varchar(60)
);

CREATE TABLE EmpresaDesarrolladora(
		EmpresaDesarrolladoraId INT,
		Nombre_empresa varchar(15),
		Descripcion_Empresa varchar(50),
		FechaContratacion DATE
);

ALTER TABLE video_juego ADD CONSTRAINT PK_Juego PRIMARY KEY (Idjuego);
ALTER TABLE GeneroJuego ADD CONSTRAINT PK_Genero PRIMARY KEY (GeneroJuego);
ALTER TABLE EmpresaDesarrolladora ADD CONSTRAINT PK_empresa PRIMARY KEY (EmpresaDesarrolladoraId);
ALTER TABLE video_juego ADD CONSTRAINT FK_juego_genero FOREIGN KEY (GeneroJuego) REFERENCES GeneroJuego(GeneroJuego);
ALTER TABLE video_juego ADD CONSTRAINT FK_juego_Empresa FOREIGN KEY (EmpresaDesarrolladoraId) REFERENCES EmpresaDesarrolladora(EmpresaDesarrolladoraId);

INSERT INTO GeneroJuego VALUES (1,'First Person Shooter','Genero en primera persona de disparos');
INSERT INTO GeneroJuego VALUES (2,'Survival Horror','Genero de supervivencia, poca vida,municion,etc.');
INSERT INTO GeneroJuego VALUES (3,'Pelea','Genero de peleas tipo arcade');
INSERT INTO GeneroJuego VALUES (4,'Tercera persona','Involucra un juego de pespectiva de espalda');
INSERT INTO GeneroJuego VALUES (5,'Carreras','Simulan el volante del conductor');
INSERT INTO GeneroJuego VALUES (6,'RPG-FPS','Combinacion de ambos generos');
INSERT INTO GeneroJuego VALUES (7,'deportes','deportes de cualqueir tipo');
INSERT INTO GeneroJuego VALUES (8,'JRPG','RPG JAPONES');

INSERT INTO EmpresaDesarrolladora values(1,'Valve','empresa muy respetada hace pocos juegos ',TO_DATE('10/09/2010 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO EmpresaDesarrolladora values(2,'From Software','Japonesa, hace juegos muy dificiles ',TO_DATE('21/03/2009 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO EmpresaDesarrolladora values(3,'EA','gran demanda de videojuegos ',TO_DATE('11/10/2007 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO EmpresaDesarrolladora values(4,'Activison','Importante en el ambito de competencia ',TO_DATE('21/03/2009 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO EmpresaDesarrolladora values(5,'Square Enix','Japonesa,conocida por sus juegos RPG ',TO_DATE('21/03/2009 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO EmpresaDesarrolladora values(6,'Bethesda','Adquiere cualqueir franquicia antes de quebrar',TO_DATE('21/03/2009 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
--BETHESDA
INSERT INTO video_juego VALUES(1,'FALLOUT3',6,30,6,39.99);
INSERT INTO video_juego VALUES(3,'DOOM ETERNAL',1,100,6,59.99);
INSERT INTO video_juego VALUES(4,'SKYRIM',6,200,6,59.99);
--VALVE
INSERT INTO video_juego VALUES(2,'Half-life 2',1,10,1,19.99);
INSERT INTO video_juego VALUES(5,'Portal 2',6,50,1,19.99);
INSERT INTO video_juego VALUES(6,'Left 4 dead',2,80,1,9.99);
--FROM SOFTWARE
INSERT INTO video_juego VALUES(7,'Dark Souls 1',4,600,2,39.99);
INSERT INTO video_juego VALUES(8,'Dark Souls 2',4,300,2,39.99);
INSERT INTO video_juego VALUES(9,'Bloodborne',4,100,2,59.99);
--EA
INSERT INTO video_juego VALUES(10,'Dead Space 1',2,50,3,19.99);
INSERT INTO video_juego VALUES(11,'Battlefield3',1,24,3,29.99);
INSERT INTO video_juego VALUES(12,'Need for Speed',5,50,3,29.99);
--ACTIVISON
INSERT INTO video_juego VALUES(13,'Call of duty 3',1,600,4,44.99);
INSERT INTO video_juego VALUES(14,'Tony Hawk',7,2,4,14.99);
INSERT INTO video_juego VALUES(15,'EA UFC',3,500,4,20.99);
--SQUARE ENIX
INSERT INTO video_juego VALUES(16,'Tomb Raider',4,200,5,13.99);
INSERT INTO video_juego VALUES(17,'Final Fantasy XIII',8,600,5,59.99);
INSERT INTO video_juego VALUES(18,'Nier Automata',4,100,5,59.99);