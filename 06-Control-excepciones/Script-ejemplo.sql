--****************************************************
-- Administración de bases de datos relacionales
-- Control de excepciones
-- Autor: Erick Varela
-- Git: https://github.com/vareladev/administracion-bases-de-datos
-- Versión: 1.0
-- Fecha: Agosto 2018
--****************************************************


--************************** EXCEPCIONES **************************
--*** EJEMPLO 1 ***
--¿El siguiente bloque genera algun error?
DECLARE
    nombre_emp empleado.nombreEmpleado%TYPE;
BEGIN
    SELECT nombreEmpleado INTO nombre_emp 
    FROM empleado
    WHERE idDepto = 1; 
    DBMS_OUTPUT.PUT_LINE ('resultado:' ||nombre_emp);
END;

--controlando error con excepciones pre-definidas
DECLARE
    nombre_emp empleado.nombreEmpleado%TYPE;
BEGIN
    SELECT nombreEmpleado INTO nombre_emp 
    FROM empleado
    WHERE idDepto = 1; 
    DBMS_OUTPUT.PUT_LINE ('resultado:' ||nombre_emp);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
      DBMS_OUTPUT.PUT_LINE ('ERROR: la consulta retorna mas de una fila de datos.');
END;

--*** EJEMPLO 2 ***
--Excepciones definidas para códigos ORA.
--Hacer un sub programa que muestre las ganancias obtenidas entre 2 fechas dadas por el usuario
CREATE OR REPLACE FUNCTION GETBENEFITSBETWEEN(MINDATE IN DATE, MAXDATE IN DATE)
RETURN FLOAT IS
    ventas FLOAT := 0.0;
    ventasAux FLOAT := 0.0;
    CURSOR detalleFactura IS 
        SELECT  SUM(pro.precioUnidad*vf.cantidad) as total
        FROM FACTURA factu, ventaFactura vf, producto pro
        WHERE factu.idFactura = vf.idFactura 
            AND vf.idProducto = pro.idProducto
            AND factu.fecha >= MINDATE
            AND factu.fecha <= MAXDATE
        GROUP BY factu.idFactura
        ORDER BY factu.idFactura ASC, total ASC;
BEGIN
    OPEN detalleFactura;
    LOOP
        ventasAux := 0.0;
        FETCH detalleFactura INTO ventasAux;
        EXIT WHEN detalleFactura%NOTFOUND;
        ventas := ventas + ventasAux;
    END LOOP;
    RETURN ventas;
END;
CREATE OR REPLACE PROCEDURE GETBENEFITS (MINDATE IN VARCHAR2, MAXDATE IN VARCHAR2) IS
    ventas FLOAT;
BEGIN
    ventas := GETBENEFITSBETWEEN(TO_DATE(MINDATE, 'DD/MM/YYYY'), TO_DATE(MAXDATE, 'DD/MM/YYYY'));
	DBMS_OUTPUT.put_line('Las ganancias entre '|| MINDATE ||' y '|| MAXDATE ||' son: $' || ventas);
END;
--el procedimiento anterior funciona pero al ingresar una fecha con el formato MES/DIA/AÑO:
EXEC GETBENEFITS('11/15/2017','02/11/2017');
--existe el error:
/*
Error que empieza en la línea: 58 del comando :
BEGIN GETBENEFITS('11/15/2017','02/11/2017'); END;
Informe de error -
ORA-01843: mes no válido
ORA-06512: en "USRCLASE5.GETBENEFITS", línea 4
ORA-06512: en línea 1
01843. 00000 -  "not a valid month"
*Cause:    
*Action:
*/
--Modificando el procedimiento almacenado:
CREATE OR REPLACE PROCEDURE GETBENEFITS (MINDATE IN VARCHAR2, MAXDATE IN VARCHAR2) IS
    ventas FLOAT;
    DATEFORMAT01830 EXCEPTION;
    PRAGMA EXCEPTION_INIT(DATEFORMAT01830,-01843);
BEGIN
    ventas := GETBENEFITSBETWEEN(TO_DATE(MINDATE, 'DD/MM/YYYY'), TO_DATE(MAXDATE, 'DD/MM/YYYY'));
	DBMS_OUTPUT.put_line('Las ganancias entre '|| MINDATE ||' y '|| MAXDATE ||' son: $' || ventas);
EXCEPTION 
    WHEN DATEFORMAT01830 THEN 
        DBMS_OUTPUT.PUT_LINE('ERROR: La fecha tiene un formato incorrecto, formato: (DD/MM/YYYY)');
END;
--Ejecutando procedimiento
EXEC GETBENEFITS('11/15/2017','02/11/2017');

--*** EJEMPLO 2 ***
--Excepciones personalizadas.
CREATE OR REPLACE PROCEDURE GETBENEFITS (MINDATE IN VARCHAR2, MAXDATE IN VARCHAR2) IS
    ventas FLOAT;
    DATEFORMAT01830 EXCEPTION;
    PRAGMA EXCEPTION_INIT(DATEFORMAT01830,-01843);
    e_date_check EXCEPTION;
BEGIN
    IF TO_DATE(MINDATE, 'DD/MM/YYYY') >  TO_DATE(MAXDATE, 'DD/MM/YYYY') THEN
        RAISE e_date_check;
    END IF; 
    ventas := GETBENEFITSBETWEEN(TO_DATE(MINDATE, 'DD/MM/YYYY'), TO_DATE(MAXDATE, 'DD/MM/YYYY'));
	DBMS_OUTPUT.put_line('Las ganancias entre '|| MINDATE ||' y '|| MAXDATE ||' son: $' || ventas);
EXCEPTION
    WHEN DATEFORMAT01830 THEN 
        DBMS_OUTPUT.PUT_LINE('ERROR: La fecha tiene un formato incorrecto, formato: (DD/MM/YYYY)');
    WHEN e_date_check THEN
        DBMS_OUTPUT.PUT_LINE ('ERROR: el orden de las fechas ingresadas en incorrecto (Codigo: '||SQLCODE||', '||SQLERRM||')');
END;

--Ejemplo correcto: primer fecha debe ser mas antigua con respecto a la segunda
EXEC GETBENEFITS('01/11/2017','02/11/2017');
--Ejemplo con error:
EXEC GETBENEFITS('02/11/2017','01/11/2017');