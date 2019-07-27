CREATE TABLE disp_mamifero (
  nombreCientifico VARCHAR2(50) PRIMARY KEY,
  nombreComun VARCHAR2(50) default NULL,
  color VARCHAR2(50) default NULL,
  fotografia varchar2(255),
  encuentros INT
);

INSERT INTO disp_mamifero (nombreCientifico,nombreComun,color,fotografia,encuentros) VALUES ('Micromys minutus','Ratón espiguero.','cafe','GB074.jpg',3);
INSERT INTO disp_mamifero (nombreCientifico,nombreComun,color,fotografia,encuentros) VALUES ('Nyctalus noctula','Nóctulo mediano','cafe','DF230.jpg',3);
INSERT INTO disp_mamifero (nombreCientifico,nombreComun,color,fotografia,encuentros) VALUES ('Eliomys quercinus','liron careto','gris','MX167.jpg',6);

CREATE TABLE central_mamifero (
  nombreCientifico VARCHAR2(50) PRIMARY KEY,
  nombreComun VARCHAR2(50) default NULL,
  color VARCHAR2(50) default NULL,
  fotografia varchar2(255),
  encuentros INT
);

INSERT INTO central_mamifero (nombreCientifico,nombreComun,color,fotografia,encuentros) VALUES ('Eliomys quercinus','liron careto','gris','MX167.jpg',6);

------------------------------------------------------------------
SELECT * FROM central_mamifero;
SELECT * FROM disp_mamifero;
------------------------------------------------------------------

MERGE INTO central_mamifero USING disp_mamifero
  ON (central_mamifero.nombreCientifico = disp_mamifero.nombreCientifico)
  WHEN MATCHED THEN
    UPDATE SET 
      central_mamifero.encuentros =  central_mamifero.encuentros +  disp_mamifero.encuentros
  WHEN NOT MATCHED THEN
    INSERT (nombreCientifico,nombreComun,color,fotografia,encuentros)
    VALUES (disp_mamifero.nombreCientifico,disp_mamifero.nombreComun,disp_mamifero.color,disp_mamifero.fotografia,disp_mamifero.encuentros);
    
    


CREATE TABLE disp_ave (
  nombreCientifico VARCHAR2(50) primary key,
  nombreComun VARCHAR2(50),
  color VARCHAR2(50) default NULL,
  fotografia varchar2(255),
  envergadura float,
  encuentros INT
);

INSERT INTO disp_ave (nombreCientifico,nombreComun,color,fotografia,envergadura,encuentros) VALUES ('Merops persicus','abejaruco persa','verde','MK098.jpg',0.77,5);
INSERT INTO disp_ave (nombreCientifico,nombreComun,color,fotografia,envergadura,encuentros) VALUES ('Hieraaetus pennatus','Águila calzada','cafe','HP143.jpg','1.35',3);
INSERT INTO disp_ave (nombreCientifico,nombreComun,color,fotografia,envergadura,encuentros) VALUES ('Limosa lapponica','aguja colipinta','gris','DZ733.jpg',0.72,6);
INSERT INTO disp_ave (nombreCientifico,nombreComun,color,fotografia,envergadura,encuentros) VALUES ('Morus bassanus','alcatraz común','blanco','ZX047.jpg',1.80,8);

CREATE TABLE central_ave (
  nombreCientifico VARCHAR2(50) primary key,
  nombreComun VARCHAR2(50),
  color VARCHAR2(50) default NULL,
  fotografia varchar2(255),
  envergadura float,
  encuentros INT
);
INSERT INTO central_ave (nombreCientifico,nombreComun,color,fotografia,envergadura,encuentros) VALUES ('Limosa lapponica','aguja colipinta','gris','DZ733.jpg',0.72,13);
INSERT INTO central_ave (nombreCientifico,nombreComun,color,fotografia,envergadura,encuentros) VALUES ('Morus bassanus','alcatraz común','blanco','ZX047.jpg',1.80,36);

---------------------------------------------------------------
select * from central_ave;
select * from disp_ave;
---------------------------------------------------------------

MERGE INTO central_ave USING disp_ave
  ON (central_ave.nombreCientifico = disp_ave.nombreCientifico)
  WHEN MATCHED THEN
    UPDATE SET 
      central_ave.encuentros =  central_ave.encuentros +  disp_ave.encuentros
  WHEN NOT MATCHED THEN
    INSERT (nombreCientifico,nombreComun,color,fotografia,envergadura,encuentros)
    VALUES (disp_ave.nombreCientifico,disp_ave.nombreComun,disp_ave.color,disp_ave.fotografia,disp_ave.envergadura,disp_ave.encuentros);
    

BEGIN
    MERGE INTO central_mamifero USING disp_mamifero
      ON (central_mamifero.nombreCientifico = disp_mamifero.nombreCientifico)
      WHEN MATCHED THEN
        UPDATE SET 
          central_mamifero.encuentros =  central_mamifero.encuentros +  disp_mamifero.encuentros
      WHEN NOT MATCHED THEN
        INSERT (nombreCientifico,nombreComun,color,fotografia,encuentros)
        VALUES (disp_mamifero.nombreCientifico,disp_mamifero.nombreComun,disp_mamifero.color,disp_mamifero.fotografia,disp_mamifero.encuentros);
    MERGE INTO central_ave USING disp_ave
      ON (central_ave.nombreCientifico = disp_ave.nombreCientifico)
      WHEN MATCHED THEN
        UPDATE SET 
      WHEN NOT MATCHED THEN
        INSERT (nombreCientifico,nombreComun,color,fotografia,envergadura,encuentros)
        VALUES (disp_ave.nombreCientifico,disp_ave.nombreComun,disp_ave.color,disp_ave.fotografia,disp_ave.envergadura,disp_ave.encuentros);
END;

select * from central_ave;
select * from central_mamifero;
select * from disp_ave;
select * from disp_mamifero;

DROP TABLE central_ave;
DROP TABLE central_mamifero;
DROP TABLE disp_ave;
DROP TABLE disp_mamifero;