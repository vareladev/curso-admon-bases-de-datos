--****************************************************
-- Administración de bases de datos relacionales
-- Tablas particionadas
-- Autor: Erick Varela
-- Git: https://github.com/vareladev/administracion-bases-de-datos
-- Versión: 1.0
-- Fecha: Agosto 2018
--****************************************************

--*******************************************************
--TABLAS PARTICIONADAS
--NOTA: Para poder ejecutar las consultas con tablas particionadas, es necesario tener licencia de Oracle.
--Una alternativa es utilizar el compilador de Oracle Online: https://livesql.oracle.com/apex/f?p=590:1000
--*******************************************************
CREATE OR REPLACE PROCEDURE insert_into_factura
AS
BEGIN 
    INSERT INTO factura VALUES (1,5,1,'49.73',TO_DATE('08-11-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (2,5,8,'95.76',TO_DATE('28-06-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (3,5,5,'98.14',TO_DATE('19-06-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (4,2,5,'74.71',TO_DATE('10-11-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (5,7,3,'80.21',TO_DATE('14-04-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (6,7,7,'92.96',TO_DATE('28-09-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (7,4,3,'41.62',TO_DATE('20-06-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (8,4,4,'79.30',TO_DATE('06-11-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (9,4,7,'92.80',TO_DATE('23-06-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (10,1,1,'41.44',TO_DATE('01-05-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (11,6,6,'56.19',TO_DATE('30-05-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (12,5,3,'40.36',TO_DATE('30-12-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (13,7,1,'79.11',TO_DATE('16-07-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (14,10,8,'56.13',TO_DATE('20-02-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (15,7,9,'72.64',TO_DATE('24-04-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (16,10,2,'52.55',TO_DATE('16-04-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (17,10,2,'38.32',TO_DATE('15-05-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (18,10,6,'93.59',TO_DATE('05-06-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (19,5,6,'81.44',TO_DATE('30-01-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (20,6,10,'61.27',TO_DATE('31-08-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (21,3,5,'60.24',TO_DATE('27-07-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (22,7,4,'43.62',TO_DATE('14-07-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (23,9,10,'42.61',TO_DATE('16-09-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (24,7,6,'53.48',TO_DATE('08-06-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (25,5,10,'66.46',TO_DATE('11-07-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (26,9,3,'51.42',TO_DATE('19-08-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (27,1,3,'97.44',TO_DATE('16-10-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (28,3,9,'44.07',TO_DATE('21-05-2017','dd-MM-yyyy'));
    INSERT INTO factura VALUES (29,10,8,'85.47',TO_DATE('11-07-2016','dd-MM-yyyy'));
    INSERT INTO factura VALUES (30,5,5,'54.05',TO_DATE('04-10-2016','dd-MM-yyyy'));
    COMMIT;
END;



-- PARTICION POR RANGO
DROP TABLE factura;
CREATE TABLE factura(
    codigo INT PRIMARY KEY,
    idVendedor INT,
    idCliente INT,
    total FLOAT,
    fecha DATE    
) PARTITION BY RANGE (fecha)
(
    PARTITION facturas_s1_2016 VALUES LESS THAN (TO_DATE('30-06-2016','dd-MM-yyyy')),
    PARTITION facturas_s2_2016 VALUES LESS THAN (TO_DATE('31-12-2016','dd-MM-yyyy')),
    PARTITION facturas_s1_2017 VALUES LESS THAN (TO_DATE('30-06-2017','dd-MM-yyyy')),
    PARTITION facturas_s2_2017 VALUES LESS THAN (TO_DATE('31-12-2017','dd-MM-yyyy'))
);

EXEC insert_into_factura;

SELECT * FROM factura;
SELECT * FROM factura PARTITION (facturas_s1_2016);
SELECT * FROM factura PARTITION (facturas_s2_2016);
SELECT * FROM factura PARTITION (facturas_s1_2017);
SELECT * FROM factura PARTITION (facturas_s2_2017);



-- PARTICION POR HASH
DROP TABLE factura;
CREATE TABLE factura(
    codigo INT PRIMARY KEY,
    idVendedor INT,
    idCliente INT,
    total FLOAT,
    fecha DATE    
) PARTITION BY HASH (codigo)
(
    PARTITION fac_part1,
    PARTITION fac_part2,
    PARTITION fac_part3
);


EXEC insert_into_factura;

SELECT * FROM factura
SELECT * FROM factura PARTITION (fac_part1);
SELECT * FROM factura PARTITION (fac_part2);
SELECT * FROM factura PARTITION (fac_part3);


--PARTICION POR LISTA
DROP TABLE factura;
CREATE TABLE factura(
    codigo INT PRIMARY KEY,
    idVendedor INT,
    idCliente INT,
    total FLOAT,
    fecha DATE    
) PARTITION BY LIST (idVendedor)
(
    PARTITION vendedor_central VALUES(1, 2, 3, 4),
    PARTITION vendedor_Santa_ana VALUES(5, 6, 7),
    PARTITION vendedor_La_union VALUES(8, 9, 10)
);

EXEC insert_into_factura;

SELECT * FROM factura
SELECT * FROM factura PARTITION (vendedor_central);
SELECT * FROM factura PARTITION (vendedor_Santa_ana);
SELECT * FROM factura PARTITION (vendedor_La_union);


--SUBPARTICIONES: particion por rango con subparticiones con hash
DROP TABLE factura;
CREATE TABLE factura(
    codigo INT PRIMARY KEY,
    idVendedor INT,
    idCliente INT,
    total FLOAT,
    fecha DATE    
)
  PARTITION BY RANGE(fecha)
  SUBPARTITION BY HASH(codigo)
   ( PARTITION facturas_2016 VALUES LESS THAN (TO_DATE('31-12-2016','dd-MM-yyyy'))
     ( SUBPARTITION facturas_2016_h1,
       SUBPARTITION facturas_2016_h2,
       SUBPARTITION facturas_2016_h3,
       SUBPARTITION facturas_2016_h4
     ),
     PARTITION facturas_2017 VALUES LESS THAN (TO_DATE('31-12-2017','dd-MM-yyyy'))
     ( SUBPARTITION facturas_2017_h1,
       SUBPARTITION facturas_2017_h2,
       SUBPARTITION facturas_2017_h3,
       SUBPARTITION facturas_2017_h4
     )
   );
   

EXEC insert_into_factura;

SELECT * FROM factura
SELECT * FROM factura PARTITION (facturas_2016);
SELECT * FROM factura SUBPARTITION (facturas_2016_h1);
SELECT * FROM factura SUBPARTITION (facturas_2016_h2);
SELECT * FROM factura SUBPARTITION (facturas_2016_h3);
SELECT * FROM factura SUBPARTITION (facturas_2016_h4);
SELECT * FROM factura PARTITION (facturas_2017);
SELECT * FROM factura SUBPARTITION (facturas_2017_h1);
SELECT * FROM factura SUBPARTITION (facturas_2017_h2);
SELECT * FROM factura SUBPARTITION (facturas_2017_h3);
SELECT * FROM factura SUBPARTITION (facturas_2017_h4);