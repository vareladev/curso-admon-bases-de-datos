--****************************************************
-- Administración de bases de datos relacionales
-- System change number
-- Autor: Erick Varela
-- Git: https://github.com/vareladev/administracion-bases-de-datos
-- Versión: 1.0
-- Fecha: Agosto 2018
--****************************************************

DROP TABLE CUENTA;
CREATE TABLE CUENTA(
	numeroCuenta VARCHAR2(26) PRIMARY KEY,
	cliente VARCHAR2(50) NOT NULL,
	saldo VARCHAR2(50)
);

INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SE-05-MVSK-000001850171-17','Charles Mcconnell','7238.68');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SA-81-OVCT-000002885615-15','Rhona Robert Joseph','3450.03');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SO-44-HURK-000006044369-78','Ivory Nero Nielsen','3761.14');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SI-84-IMCJ-000000748800-12','Mariam Simpson','5458.02');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SE-63-FYON-000004495175-83','Jada Austin Hays','5477.12');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SE-18-YFHD-000009973004-99','Zoe Wells','1528.96');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SU-79-XFSE-000006370191-77','Salvador Monroe','2004.92');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SI-84-XNGL-000001205709-60','Daquan Erich Randall','5553.85');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SA-15-FYOL-000005689538-59','Roth Espinoza','1608.21');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SO-62-UOCI-000006057434-44','Dorothy Acton Lee','2877.88');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SE-97-CIKA-000006933134-97','Leroy Knowles','266.02');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SU-24-OIUI-000009316623-73','Nolan Reilly','2257.48');
COMMIT;
SELECT * FROM cuenta;

--Contando cuantos registros hay en la tabla
SELECT count(*) FROM cuenta;
--Verificando SCN
SELECT dbms_flashback.get_system_change_number FROM dual; -- en la preparacion de clases el resultado fue: 2268805
--Contando cuantos registros hay en la tabla utilizando el SCN
SELECT count (*) FROM cuenta AS OF SCN 2268805;

--Eliminar todo y confirmar cambios :(
DELETE FROM cuenta;
COMMIT

--formas de obtener SCN
--Ver SCN actual Opción 1
SELECT dbms_flashback.get_system_change_number FROM dual;
--Ver SCN actual Opción 2
SELECT CURRENT_SCN FROM V$DATABASE;
--Ver SCN actual Opción 3 (Correspondiendo con una fecha)
SELECT timestamp_to_scn (sysdate) from dual;
--Ver fecha correspondiente a un SCN
SELECT scn_to_timestamp (2268805) FROM dual;

INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SO-80-VSDD-000001962667-63','Malachi Walker Foreman','14.32');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SO-04-WINW-000003378434-98','Reagan Maddox','7494.08');
INSERT INTO CUENTA (numeroCuenta,cliente,saldo) VALUES ('SI-45-IOCM-000009236058-38','Lester Gisela Chase','148.69');
COMMIT;

--Verificando SCN luego de haber realizado los 3 inserts
SELECT dbms_flashback.get_system_change_number FROM dual; --en la clase: 2269032
--¿Cuantos registros hay con el SCN anterior?
SELECT count (*) FROM cuenta AS OF SCN 2269032;


--Eliminar todo y confirmar cambios :(
DELETE FROM cuenta;
COMMIT;
SELECT * FROM cuenta;

--recuperando informacion en base a SCN
--Recuperando primer bloque de datos:
INSERT INTO cuenta SELECT * FROM cuenta AS OF SCN 2268805;
--Recuperando segundo bloque de datos:
INSERT INTO cuenta SELECT * FROM cuenta AS OF SCN 2269032;

--Verificando datos ( me salvé de perder mi trabajo :'D )
SELECT * FROM cuenta;

