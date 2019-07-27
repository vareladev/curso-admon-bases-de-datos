

--Primeramente Creamos un nuevo tablespace
CREATE TABLESPACE db_ejemplo
    DATAFILE 'db_ejemplo.dbf'
    SIZE 10M AUTOEXTEND ON;

--CREAMOS USUARIO
CREATE USER trigger_user
IDENTIFIED BY root --password de user
DEFAULT TABLESPACE db_ejemplo-- en que tablesppace estara
TEMPORARY TABLESPACE temp--como buena practica se asigna un tabelspace temporal
QUOTA unlimited on db_ejemplo;

--le damos privilegios al usuario

GRANT CONNECT,RESOURCE,DBA TO trigger_user;
GRANT CREATE SESSION TO trigger_user;

--ingresamos a nuestro nuevo usuario
--CREAMOS UNA NUEVA CONEXION, con el nombre de usuario rol basico, se mostrara en en el laboratorio cmo se hara

-----------------------------------------------------------------------------------------------------------------------
--Ejercicio 1
--Crear un trigger que se dispare cuando se quiera ingresar un valor menor a 0 para el stock
--en este caso forzaremos uan excepcion 
CREATE OR REPLACE TRIGGER   stock_trigger
BEFORE INSERT ON video_juego
FOR EACH ROW
BEGIN
    IF :NEW.cantidadstock < 0 then
        raise_application_error(-20010, 'STOCK MENOR QUE 0');
    END IF;
END;
---Trataremos de insertar un nuevo video juego con un valor negativo de stock
--lo cual forzara un error y el trigger se levantara
INSERT INTO video_juego VALUES(19,'P1',3,-4,1,19.99);
------------------------------------------------------------------------------------------------------------
--EJERCICIO 2
--Crear un trigger en el cual se active cuando se quiere borrar un juego, que conste que se debe auditorar
--que usuario lo hizo, que dia lo hizo, y los valores que se borraron
--tabla de auditoria
CREATE TABLE AUDIT_DELETE(
        preid int,
        nombre varchar2(20),
        genero int,
        stock int ,
        developer int,
        preciojuego FLOAT,
        loguser varchar2(30),
        fechamodificacion date
);
--trigger
CREATE OR REPLACE TRIGGER delete_trigger
BEFORE DELETE ON video_juego
FOR EACH ROW
BEGIN
    INSERT INTO AUDIT_DELETE VALUES(:OLD.Idjuego,:OLD.nombreJuego,:OLD.GeneroJuego,:OLD.CantidadStock,:OLD.EmpresaDesarrolladoraId,:OLD.Precio_Juego,ora_login_user,sysdate);
END;   
-----PRUEBAS 

DELETE FROM video_juego WHERE idjuego=19;
SELECT*FROM AUDIT_DELETE;

--EJERCICIO 3 
--CREAR UN TRIGGER QUE MODIFICANDO UNA EMPRESA EXISTENTE
--NO PUEDA SER LA FECHA MENOR A 13/03/1990
--ejercicio 3
CREATE OR REPLACE TRIGGER update_trigger_date
BEFORE UPDATE OF FechaContratacion  ON EmpresaDesarrolladora
FOR EACH ROW
BEGIN
    IF(:NEW.FechaContratacion<= TO_DATE('13/03/1990','dd/mm/yyyy')) THEN
    raise_application_error(-20010, 'NO EXISTE EMPRESA DESAROLLADORA ANTES DE 1990');
    END IF;
END;
----PRUEBAS
select*from EmpresaDesarrolladora;
--haremos un insert mas
INSERT INTO empresadesarrolladora VALUES(7,'RAVEN','rip',TO_DATE('10/09/2010 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
--ahora probaremos cambiar la fecha de esa empresa
UPDATE empresadesarrolladora SET FechaContratacion=TO_DATE('10/09/1989 00:00:00', 'dd/mm/yyyy hh24:mi:ss') where empresadesarrolladoraid=7;0

--------------------------------------------------------------------------------------------------------------------------------------------------






