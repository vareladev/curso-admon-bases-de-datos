-- Habilitando la salida DBMS
SET SERVEROUTPUT ON;

-- Ejemplo 1
-- Procedimiento que modifique el titulo de una pelicula segun su id
CREATE OR REPLACE PROCEDURE update_title_proc
(pelicula_id INT, title VARCHAR2)
IS
BEGIN
    UPDATE pelicula SET titulo = title WHERE id = pelicula_id;
END;
/

SELECT * FROM pelicula WHERE id = 1;
EXEC update_title_proc(1, 'The Fast and The Furious');
SELECT * FROM pelicula WHERE id = 1;
EXEC update_title_proc(1, 'Rápido y furioso');
-- Fin ejemplo 1


-- Ejemplo 2
-- Procedimiento "retornando" un valor
CREATE OR REPLACE PROCEDURE potencia
(base IN INT, exponente IN INT, resultado OUT INT)
IS
BEGIN
    resultado := base ** exponente;
END;
/

DECLARE
    base INT := 6;
    exponente INT := 2;
    resultado INT;
BEGIN
    potencia(base, exponente, resultado);
    DBMS_OUTPUT.PUT_LINE(base || '**' || exponente || ' = ' || resultado);
END;
/
-- Fin ejemplo 2


-- Ejemplo 3
-- Mismo ejemplo anterior pero con funciones
CREATE OR REPLACE FUNCTION pow
(base IN INT, exponente IN INT)
RETURN INT
IS
    resultado INT;
BEGIN
    resultado := base ** exponente;
    RETURN resultado;
END;
/

SELECT pow(7, 2) FROM DUAL;

-- Alternativamente se puede llamar de la siguiente forma
DECLARE
    base INT := 7;
    exponente INT := 2;
    resultado INT := pow(base, exponente);
BEGIN
    DBMS_OUTPUT.PUT_LINE(base || '**' || exponente || ' = ' || resultado);
END;
/
-- Fin ejemplo 3


-- Ejemplo 4
-- Ejemplo básico usando excepciones
-- Modificar el valor de "d" por 0, y luego por 4, para probar cada una de las excepciones y el resultado exitoso
DECLARE
    menor_que_0 EXCEPTION; -- Declaracion de una exception
    b INT := 20;
    d INT := -4;
    e INT;
BEGIN
    e := b/d;
    IF e < 0 THEN -- Condicion de fallo
        RAISE menor_que_0;
    END IF;
    DBMS_OUTPUT.PUT_LINE(e);
EXCEPTION
    WHEN ZERO_DIVIDE THEN -- Instrucciones cuando detecta una excepcion de oracle
        DBMS_OUTPUT.PUT_LINE('No se puede dividir entre 0');
    WHEN menor_que_0 THEN -- Instrucciones cuando detecta una excepcion personalizada
        DBMS_OUTPUT.PUT_LINE('El numerador o denominador es negativo');
END;
/
-- Fin ejemplo 4


-- Ejemplo 5
-- Probar la siguiente instrucción DML
INSERT INTO IDIOMAXPELICULA VALUES ('ES', 3, 'principal');
/*
Preguntar: ¿Cómo se maneja una excepción que se lanza de forma automática en instrucciones DML?
Respuesta: Asociamos una excepción propia a un código de error de Oracle.
Se ocupa:
    PRAGMA EXCEPTION_INIT(<nombre_excepcion>, -ORACLE_CODE_ERROR_WITHOUT_LEFT_ZEROS);
*/
DECLARE
    invalid_number_exception EXCEPTION; -- Declarando la excepcion
    PRAGMA EXCEPTION_INIT(invalid_number_exception, -1722); -- Asociando nuestra excepcion a un codigo de error
BEGIN
    INSERT INTO IDIOMAXPELICULA VALUES ('ES', 3, 'principal');
EXCEPTION
    WHEN invalid_number_exception THEN -- Manejando el error
        DBMS_OUTPUT.PUT_LINE('El parametro no es un número');
END;
/
-- Fin ejemplo 5

/*********************************************
EJERCICIOS

1. Crear un procedimiento que reciba todos los parametros necesarios y agregue una pelicula

2. Crear una funcion que dados dos id de peliculas diferentes, devuelva la diferencia
   de tiempo (en años) entre las dos peliculas

3. Crear una función que dados dos id (a y b) de peliculas, y usando cursores, devuelva cuanto tiempo (en horas)
   tomaria ver todas las peliculas que hay entre dichos id [a, b]

4. Crear un procedimiento que dado una cantidad de minutos n, obtenga todas las peliculas cuya
   duracion sea menor que n y que le aumente su valoracion en 0.1. Realice las validaciones correspondientes.

5. Crear un procedimiento que modifique el rol de un actor en una pelicula. Agregue una excepcion
   por si el valor indicado no es valido.

*********************************************/