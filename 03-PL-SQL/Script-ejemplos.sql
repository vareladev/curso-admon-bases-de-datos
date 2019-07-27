--****************************************************
-- Administración de bases de datos relacionales
-- Introducción pl/sql
-- Autor: Erick Varela
-- Git: https://github.com/vareladev/administracion-bases-de-datos
-- Versión: 1.0
-- Fecha: Agosto 2018
--****************************************************


-- SECUENCIAS
--Definición.
--Una secuencia se emplea para generar valores enteros secuenciales únicos y asignárselos a campos numéricos.

--Creando secuencias.
CREATE SEQUENCE secuencia1
START WITH 1 
INCREMENT BY 1 
MAXVALUE 100
NOCYCLE
CACHE 10;

--Parámetros por defecto.
/*CREATE SEQUENCE secuencia1
START WITH 1 
INCREMENT BY 1 
MAXVALUE 9999999999999999999999999999
NOCYCLE
NOCACHE;*/

--Nextval y Currval
SELECT secuencia1.currval FROM DUAL; --error?
SELECT secuencia1.nextval FROM DUAL;
SELECT secuencia1.currval FROM DUAL; --error?

SELECT * FROM ALL_SEQUENCES WHERE sequence_name =  'SECUENCIA1';

--¿Campos autoincrement, identity?
CREATE TABLE registro(
    idRegistro INT PRIMARY KEY,
    fecha DATE
);
INSERT INTO registro (idRegistro, fecha) VALUES (secuencia1.nextval, SYSDATE);
SELECT * FROM registro;

--Eliminar secuencia
DROP SEQUENCE secuencia1;


--INTRODUCCION A PL/SQL
DECLARE
    hire date; 
    job varchar2(80) := 'Salesman';
    emp_found boolean; 
    salary_incr constant number(3,2) := 1.5;
BEGIN 
    DBMS_OUTPUT.PUT_LINE(salary_incr);
END;
    

CREATE TABLE emp(
    empno int primary key,
    ename varchar(50) not null,
    job varchar(50) not null,
    mgr int,
    hiredate date,
    sal decimal(10,2),
	bonus decimal(10,2),
    comm decimal(10,2),
    deptno int not null
);

insert into emp values (7369,'SMITH','CLERK',7902,TO_DATE('1993-07-01','YYYY-MM-DD'),800,null,0.00,20);
insert into emp values (7499,'ALLEN','SALESMAN',7698,TO_DATE('1998-08-15','YYYY-MM-DD'),1600,null,300,30);
insert into emp values (7521,'WARD','SALESMAN',7698,TO_DATE('1996-03-26','YYYY-MM-DD'),1250,null,500,30);
insert into emp values (7566,'JONES','MANAGER',7839,TO_DATE('1995-10-31','YYYY-MM-DD'),2975,null,null,20);
drop table emp;

SELECT * FROM emp WHERE sal > 1500;
--definitiendo columnas y filas segun tipo de datos de una tabla
DECLARE
    empno INT;
    max_sal emp.sal%TYPE;
    emp_data emp%ROWTYPE;
BEGIN
    SELECT MAX(sal) INTO max_sal FROM emp;
    SELECT * INTO emp_data FROM emp WHERE sal = max_sal;
    DBMS_OUTPUT.PUT_LINE('Información: id:' || emp_data.empno || ', nombre: ' || emp_data.ename || ', salario: ' || emp_data.sal);
END;

--cursores
DECLARE
    emp_data emp%ROWTYPE;
    CURSOR emp_cursor IS  
        SELECT * FROM emp WHERE sal > 1500;
BEGIN
    DBMS_OUTPUT.PUT_LINE('declarando cursores');
END;