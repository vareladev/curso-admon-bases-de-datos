--****************************************************
-- Administración de bases de datos relacionales
-- Estructuras de control de flujo
-- Autor: Erick Varela
-- Git: https://github.com/vareladev/administracion-bases-de-datos
-- Versión: 1.0
-- Fecha: Agosto 2018
--****************************************************

--Estructuras de control
--IF basico
DECLARE
	nota DECIMAL(4,2) := 5.01;
BEGIN
	IF nota > 6.0 THEN
		DBMS_OUTPUT.PUT_LINE('Aprobado'||nota);
	ELSE
		DBMS_OUTPUT.PUT_LINE('Reprobado');
	END IF;
END;
   

--IF/ELSIF
DECLARE
	nota CHAR(1);
BEGIN
	nota := 'A';
	IF nota = 'A' THEN
		DBMS_OUTPUT.PUT_LINE('Excelente');
	ELSIF nota = 'B' THEN
		DBMS_OUTPUT.PUT_LINE('Muy bien');
	ELSIF nota = 'C' THEN
		DBMS_OUTPUT.PUT_LINE('Bien');
	ELSIF nota = 'D' THEN
		DBMS_OUTPUT. PUT_LINE('deficiente');
	ELSIF nota = 'F' THEN
		DBMS_OUTPUT.PUT_LINE('Muy deficiente');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Formato no permitido');
	END IF;
END;
   
--CASE 
DECLARE
	nota CHAR(1);
BEGIN
	nota := &nota;
    CASE nota  
		WHEN 'A' THEN
			DBMS_OUTPUT.PUT_LINE('Excelente');
		WHEN 'B' THEN
			DBMS_OUTPUT.PUT_LINE('Muy bien');
		WHEN 'C' THEN
			DBMS_OUTPUT.PUT_LINE('Bien');
		WHEN 'D' THEN
			DBMS_OUTPUT. PUT_LINE('deficiente');
		WHEN 'F' THEN
			DBMS_OUTPUT.PUT_LINE('Muy deficiente');
		ELSE
			DBMS_OUTPUT.PUT_LINE('Formato no permitido');
	END CASE;
END;

--LOOP
DECLARE
	x NUMBER := 0;
BEGIN
	LOOP
        x := x + 1;
		DBMS_OUTPUT.PUT_LINE ('LOOP:  x = ' || x);
		IF x > 4 THEN
			EXIT;
		END IF;
    END LOOP;
END;


-- Instrucciones CONTINUE/BREAK
DECLARE
	x NUMBER := 0;
BEGIN
	LOOP
        x := x + 1;
        IF x = 2 THEN
            CONTINUE;
        END IF;
		DBMS_OUTPUT.PUT_LINE ('LOOP:  x = ' || x);
		IF x > 4 THEN
			EXIT;
		END IF;
    END LOOP;
END;
 
 -- Instrucciones CONTINUE WHEN/BREAK WHEN
DECLARE
	x NUMBER := 0;
BEGIN
	LOOP
        x := x + 1;
        CONTINUE WHEN x = 2;
		DBMS_OUTPUT.PUT_LINE ('LOOP:  x = ' || x);
		EXIT WHEN x > 4;
    END LOOP;
END;
 
-- Instrucción WHILE
DECLARE
	x NUMBER := 0;
BEGIN
	WHILE x <= 4 LOOP
        x := x + 1;
        CONTINUE WHEN x = 2;
		DBMS_OUTPUT.PUT_LINE ('LOOP:  x = ' || x);
    END LOOP;
END;

-- Instruccion FOR
BEGIN
	FOR x IN 1..5 LOOP
        CONTINUE WHEN x = 2;
		DBMS_OUTPUT.PUT_LINE ('LOOP:  x = ' || x);
    END LOOP;
END;
 

--Cursores
DECLARE
    CURSOR emp_cursor IS  
        SELECT * FROM emp WHERE sal > 1500;
    emp_data emp_cursor%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Salarios arriba de $1500:');
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_data;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('nombre:  x = ' || emp_data.ENAME || ', Cargo: ' || emp_data.JOB || ', Salario: ' || emp_data.SAL);
    END LOOP;
    CLOSE emp_cursor;
END;