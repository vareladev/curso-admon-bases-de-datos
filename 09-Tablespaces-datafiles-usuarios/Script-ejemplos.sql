--****************************************************
-- Administración de bases de datos relacionales
-- Tablespaces, datafiles y usuarios
-- Autor: Erick Varela
-- Git: https://github.com/vareladev/administracion-bases-de-datos
-- Versión: 1.0
-- Fecha: Agosto 2018
--****************************************************

--Creando tablespace
CREATE TABLESPACE ts_clase09_1
    DATAFILE 'C:/clase09/ts_clase09_1.dbf' 
    SIZE 4M 
    AUTOEXTEND ON 
    NEXT 2M MAXSIZE 16M;
    
--Creando un tablespace temporal
CREATE TEMPORARY TABLESPACE ts_clase09_2
    TEMPFILE 'C:/clase09/ts_clase09_2.dbf' 
    SIZE 4M 
    AUTOEXTEND ON 
    NEXT 2M MAXSIZE 16M;
    
--Creando un tablespace con multiples datafiles asociados.
CREATE TABLESPACE ts_clase09_3
    DATAFILE    'C:/clase09/ts_clase09_3_1.dbf' SIZE 2M AUTOEXTEND OFF,
                'C:/clase09/ts_clase09_3_2.dbf' SIZE 2M AUTOEXTEND OFF,
                'C:/clase09/ts_clase09_3_3.dbf' SIZE 2M AUTOEXTEND OFF;
                
    
--Mostrando tablespaces
SELECT TABLESPACE_NAME, STATUS, CONTENTS 
    FROM USER_TABLESPACES
    WHERE TABLESPACE_NAME = 'TS_CLASE09_1'
        OR TABLESPACE_NAME = 'TS_CLASE09_2'
        OR TABLESPACE_NAME = 'TS_CLASE09_3';
    
--mostrando datafiles ¿Porque no se muestra el datafile del tablespace ts_clase09_2?
SELECT FILE_ID, FILE_NAME, TABLESPACE_NAME, BYTES/1024/1024  || ' MB' as "SIZE"
FROM dba_data_files
WHERE FILE_NAME LIKE ('%TS_CLASE09%');

--Mostrando temp files
SELECT FILE_ID, FILE_NAME, TABLESPACE_NAME, BYTES/1024/1024  || ' MB' as "SIZE"
FROM dba_temp_files
WHERE FILE_NAME LIKE ('%TS_CLASE09%');

--Borrando tablespace ¿Que sucede con su datafile?
DROP TABLESPACE ts_clase09_1;

--Borrando datafiles ¿Que sucede con el archivo fisico en disco?
ALTER TABLESPACE TS_CLASE09_3 DROP DATAFILE 'C:/CLASE09/TS_CLASE09_3_3.DBF';  
SELECT FILE_ID, FILE_NAME, TABLESPACE_NAME, BYTES/1024/1024  || ' MB' as "SIZE"
FROM dba_data_files
WHERE FILE_NAME LIKE ('%TS_CLASE09%');

--Agrandando espacio del datafile
--Agregando datafile existente (al tablespace 3 se le asigna el datafile del tablespace 1 anteriormente eliminado)
ALTER TABLESPACE ts_clase09_3 ADD DATAFILE 'C:/clase09/TS_CLASE09_1.dbf';
SELECT FILE_ID, FILE_NAME, TABLESPACE_NAME, BYTES/1024/1024  || ' MB' as "SIZE"
FROM dba_data_files
WHERE FILE_NAME LIKE ('%TS_CLASE09%');

--Creando nuevo datafile
ALTER TABLESPACE ts_clase09_3 ADD DATAFILE 'C:/clase09/ts_clase09_3_4.dbf' SIZE 4M AUTOEXTEND OFF;
SELECT FILE_ID, FILE_NAME, TABLESPACE_NAME, BYTES/1024/1024  || ' MB' as "SIZE"
FROM dba_data_files
WHERE FILE_NAME LIKE ('%TS_CLASE09%');

--Modificando tamaño de algun datafile
ALTER DATABASE DATAFILE 'C:/clase09/TS_CLASE09_1.DBF' RESIZE 16M;
SELECT FILE_ID, FILE_NAME, TABLESPACE_NAME, BYTES/1024/1024  || ' MB' as "SIZE"
FROM dba_data_files
WHERE FILE_NAME LIKE ('%TS_CLASE09%');
    
--Modificando la disponibilidad de un tablespace
ALTER TABLESPACE ts_clase09_3 OFFLINE NORMAL;
SELECT TABLESPACE_NAME, STATUS, CONTENTS 
    FROM USER_TABLESPACES
    WHERE TABLESPACE_NAME = 'TS_CLASE09_3';
--o tambien:
/*ALTER TABLESPACE ts_clase09_3 OFFLINE TEMPORARY;
ALTER TABLESPACE ts_clase09_3 OFFLINE IMMEDIATE;
¿Cual es la diferencia?
Ejercicio: ¿Que pasa si se intenta poner offline el tablespace system
*/


--Borrando un tablespace incluyendo su contenido y datafiles.
DROP TABLESPACE TS_CLASE09_3 INCLUDING CONTENTS AND DATAFILES;


--*******************************************************
--USUARIOS
--*******************************************************
CREATE TABLESPACE ts_clase09_4
    DATAFILE 'C:/clase09/ts_clase09_4.dbf' 
    SIZE 4M 
    AUTOEXTEND ON 
    NEXT 2M MAXSIZE 16M;
    
CREATE USER usr_clase9_1
    IDENTIFIED BY root
    DEFAULT TABLESPACE TS_CLASE09_4
    QUOTA 10M ON SYSTEM
    TEMPORARY TABLESPACE TEMP;
    
--Intentar iniciar sesión con el usuario.-
--Estado: Fallo:Fallo de la prueba: ORA-01045: user USR_CLASE9_1 lacks CREATE SESSION privilege; logon denied

--dando permisos para crear una sesión al usuario
GRANT CREATE SESSION TO usr_clase9_1;
--Intentar iniciar sesión con el usuario.-

--Intentar crear una tabla.-
/*Informe de error -
ORA-01031: insufficient privileges
01031. 00000 -  "insufficient privileges"
*Cause:    An attempt was made to perform a database operation without
           the necessary privileges.
*Action:   Ask your database administrator or designated security
           administrator to grant you the necessary privileges
*/		   

--Dando permisos
GRANT UNLIMITED TABLESPACE TO usr_clase9_1;
GRANT RESOURCE to usr_clase9_1;

    
--mostrando lista de usuarios y detalles
SELECT * FROM dba_users;

CREATE USER usr_clase9_2
    IDENTIFIED BY root
    DEFAULT TABLESPACE SYSTEM
    QUOTA 10M ON SYSTEM
    TEMPORARY TABLESPACE TEMP;

--Modificando un usuario
ALTER USER usr_clase9_2
	IDENTIFIED BY 12345
	QUOTA 5K ON SYSTEM;
    
--accediendo a los datos del usuario
SELECT * FROM usr_clase9_1.tabla;
INSERT INTO usr_clase9_1.tabla VALUES(5,5);
COMMIT;


    
