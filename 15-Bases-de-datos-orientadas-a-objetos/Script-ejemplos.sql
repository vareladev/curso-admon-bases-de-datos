--****************************************************
-- Administración de bases de datos relacionales
-- Bases de datos orientadas a objetos
-- Autor: Erick Varela
-- Git: https://github.com/vareladev/administracion-bases-de-datos
-- Versión: 1.0
-- Fecha: Agosto 2018
--****************************************************


CREATE OR REPLACE TYPE obj_depto AS OBJECT (
	idDepto INT,
	nombreDepto varchar(50),
    MEMBER PROCEDURE tostring
) FINAL;

CREATE OR REPLACE TYPE BODY obj_depto AS
   MEMBER PROCEDURE tostring IS
   BEGIN
      dbms_output.put('{id: '|| idDepto);
      dbms_output.put_line(', depto: '|| nombreDepto||'}');
   END tostring;
END;

--Integrando objetos en PL/SQL
DECLARE
    depto obj_depto;
BEGIN
    --constructor
    depto := obj_depto(1,'Ventas');
    DBMS_OUTPUT.PUT_LINE('accediendo a atributos:');
    DBMS_OUTPUT.PUT_LINE('atributo id: '|| depto.idDepto || ', atributo nombre:  '||depto.nombreDepto);
    DBMS_OUTPUT.PUT_LINE('accediendo a métodos:');
    depto.tostring();
    --llamando métodos
END;

--Creando tablas basadas en objetos
CREATE TABLE tbl_depto OF obj_depto(
    idDepto PRIMARY KEY
);

--Insertando datos 
INSERT INTO tbl_depto VALUES(obj_depto(1, 'Ventas' ));
INSERT INTO tbl_depto VALUES(obj_depto(2, 'recursos humanos' ));
INSERT INTO tbl_depto VALUES(obj_depto(3, 'administracion' ));

SELECT * FROM tbl_depto;

--Herencia 
CREATE OR REPLACE TYPE obj_persona AS OBJECT (
	DUI CHAR(10),
	nombre varchar(50),
	apellido varchar(50),
	fechanac DATE,
	MEMBER PROCEDURE tostring
) NOT FINAL;
CREATE OR REPLACE TYPE BODY obj_persona AS
    MEMBER PROCEDURE tostring IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DUI: '||DUI||', Nombre: '||nombre||' '||apellido||', Fecha de nacimiento: '||fechanac);
    END tostring;
END;


CREATE OR REPLACE TYPE obj_direccion AS OBJECT (
	calle varchar(50),
	municipio varchar(50),
	departamento varchar(50),
	casa varchar(50)
) FINAL;


CREATE OR REPLACE TYPE obj_empleado UNDER obj_persona(
	idEmpleado INT,
	salario FLOAT,
	direccion obj_direccion, --Referencias entre objetos
	idDepto INT,
	MEMBER FUNCTION getaddress RETURN VARCHAR,
	MEMBER PROCEDURE addresstostring
) FINAL;
CREATE OR REPLACE TYPE BODY obj_empleado AS
    MEMBER FUNCTION getaddress RETURN VARCHAR IS
    BEGIN
        RETURN (direccion.calle||', '||direccion.municipio||', '||direccion.departamento||', '||direccion.casa);
    END;
    MEMBER PROCEDURE addresstostring IS
    BEGIN
        dbms_output.put('{calle: '|| direccion.calle ||'}');
    END addresstostring;
END;

--creando tabla empleado a partir del objeto
CREATE TABLE empleado OF obj_empleado(
    idEmpleado PRIMARY KEY,
    FOREIGN KEY (idDepto) REFERENCES tbl_depto(idDepto)
);

--Insertando datos.
INSERT INTO empleado VALUES (
        obj_empleado(
            '12345678-6',   --dui
            'Thadeus',      --nombre
            'Dodson',       --apellido
            TO_DATE('10/06/1995','DD/MM/YYYY'),     --fecha de nacimiento
            1,              --id de empleado
            8.55,           --rate de salario
            obj_direccion('Resindencial Santa Monica', 'San Salvador', 'San Salvador', '#11'),      --direccion de vivienda
            1               --id de departamento 
        )
    );

--Consultado tabla
SELECT dui, nombre, apellido, fechanac, idempleado, salario, direccion, iddepto
FROM empleado;
--Consultado tabla v2
CREATE OR REPLACE FUNCTION f_getaddress (dir IN obj_direccion)
RETURN VARCHAR IS
BEGIN
    RETURN (dir.calle||', '||dir.municipio||', '||dir.departamento||', '||dir.casa);
END;
SELECT dui, nombre, apellido, fechanac, idempleado, salario, f_getaddress(direccion) as dir, iddepto
FROM empleado;
--Consultado tabla v3
DECLARE
    t_emp obj_empleado;
BEGIN
    SELECT VALUE(emp) INTO t_emp FROM empleado emp WHERE idempleado = 1;
    DBMS_OUTPUT.PUT_LINE('DUI: '||t_emp.dui||', Nombre: '||t_emp.nombre||' '||t_emp.apellido ||', Fecha de nacimiento: '||
        t_emp.fechanac||', código de empleado: '||t_emp.idempleado||', salario: '||t_emp.salario||',Direccion: '||t_emp.getaddress||', departamento id: '||t_emp.iddepto);
END;
--Consultado tabla version json
DECLARE
    t_emp obj_empleado;
BEGIN
    SELECT VALUE(emp) INTO t_emp FROM empleado emp WHERE idempleado = 1;
    DBMS_OUTPUT.PUT_LINE('{"dui": "'||t_emp.dui||'", "nombre": "'||t_emp.nombre||' '||t_emp.apellido ||'", "fechanac": "'||
        t_emp.fechanac||'", "codigoempleado": '||t_emp.idempleado||', "salario": "'||t_emp.salario||'", "direccion": "'||t_emp.getaddress||'", "iddepto": '||t_emp.iddepto||'}');
END;

/*resultado del JSON:
    {
    	"dui": "12345678-6",
    	"nombre": "Thadeus Dodson",
    	"fechanac": "10-JUN-95",
    	"codigoempleado": 1,
    	"salario": "8.55",
    	"direccion": "Resindencial Santa Monica, San Salvador, San Salvador, #11",
    	"iddepto": 1
    }
*/

--intentado ingresar un empleado con el mismo idEmpleado
INSERT INTO empleado VALUES (
        obj_empleado(
            '45659812-6',   --dui
            'Hayley',      --nombre
            'Solomon',       --apellido
            TO_DATE('02/12/1991','DD/MM/YYYY'),     --fecha de nacimiento
            1,              --id de empleado
            7.00,           --rate de salario
            obj_direccion('Colonia San Mateo', 'Santa tecla', 'La Libertad', '#123'),      --direccion de vivienda
            1               --id de departamento 
        )
    );
--intentado ingresar un empleado con un departamento inexistente
INSERT INTO empleado VALUES (
        obj_empleado(
            '45659812-6',   --dui
            'Hayley',      --nombre
            'Solomon',       --apellido
            TO_DATE('02/12/1991','DD/MM/YYYY'),     --fecha de nacimiento
            2,              --id de empleado
            7.00,           --rate de salario
            obj_direccion('Colonia San Mateo', 'Santa tecla', 'La Libertad', '#123'),      --direccion de vivienda
            4               --id de departamento 
        )
    );
--ingresando otro empleado
INSERT INTO empleado VALUES (
        obj_empleado(
            '45659812-6',   --dui
            'Hayley',      --nombre
            'Solomon',       --apellido
            TO_DATE('02/12/1991','DD/MM/YYYY'),     --fecha de nacimiento
            2,              --id de empleado
            7.00,           --rate de salario
            obj_direccion('Colonia San Mateo', 'Santa tecla', 'La Libertad', '#123'),      --direccion de vivienda
            1               --id de departamento 
        )
    );


SELECT * FROM empleado;

--Sobrecarga
CREATE OR REPLACE TYPE obj_cliente UNDER obj_persona(
	idCliente INT,
	OVERRIDING MEMBER PROCEDURE tostring
) FINAL;
CREATE OR REPLACE TYPE BODY obj_cliente AS
    OVERRIDING MEMBER PROCEDURE tostring IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('id: '||idCliente||', DUI: '||DUI||', Nombre: '||nombre||' '||apellido||', Fecha de nacimiento: '||fechanac);
    END tostring;
END;


DECLARE 
    cliente obj_cliente;
    persona obj_persona;
BEGIN 
    persona := obj_persona(
            '456598126',  --dui
            'Karen',      --nombre
            'Dunn',       --apellido
            TO_DATE('23/10/1999','DD/MM/YYYY')     --fecha de nacimiento
        );
    cliente := obj_cliente(
            '456598126',  --dui
            'Karen',      --nombre
            'Dunn',       --apellido
            TO_DATE('23/10/1999','DD/MM/YYYY'),     --fecha de nacimiento
            1             --id de cliente
        );
    persona.tostring;        
    cliente.tostring;
END;


