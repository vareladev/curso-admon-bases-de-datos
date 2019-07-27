--****************************************************
-- Administración de bases de datos relacionales
-- Subprogramas
-- Autor: Erick Varela
-- Git: https://github.com/vareladev/administracion-bases-de-datos
-- Versión: 1.0
-- Fecha: Agosto 2018
--****************************************************


--FUNCIONES
CREATE OR REPLACE FUNCTION func_getDate 
RETURN DATE IS
    fecha DATE;
BEGIN
    SELECT sysdate INTO fecha FROM dual;
    RETURN fecha;
END;

/*la función anterior es representativa, pero la siguiente es mas óptima:
CREATE OR REPLACE FUNCTION func_getDate 
RETURN DATE IS
BEGIN
    RETURN sysdate;
END;
*/

--Ejecutando función
SELECT func_getDate() FROM DUAL;

--Ejecutando función utilizando PL/SQL
DECLARE
    fecha DATE;
BEGIN
    fecha := func_getDate();
    DBMS_OUTPUT.put_line('La fecha de hoy: ' || to_char(fecha));
END;

--Ejecutando función utilizando PL/SQL v2
BEGIN
    DBMS_OUTPUT.put_line('La fecha de hoy: ' || to_char(func_getDate()));
END;

--PROCEDIMIENTOS ALMACENADOS
CREATE OR REPLACE PROCEDURE getDate IS
	fecha DATE;
BEGIN
    SELECT sysdate INTO fecha FROM dual;
	DBMS_OUTPUT.put_line('La fecha de hoy: ' || to_char(fecha));
END;

--Ejecutando procedimiento almacenado
EXEC getDate;

--Ejecutando procedimiento almacenado utilizando PL/SQL
BEGIN
   getDate;
END;

--Mostrar los procedimientos y funciones de un usuario
SELECT object_name, object_type 
FROM USER_OBJECTS 
WHERE object_type IN ('PROCEDURE' , 'FUNCTION')
ORDER BY object_name ASC;

--Mostrar código fuente de un procedimiento almacenado
SELECT text FROM USER_SOURCE 
WHERE type = 'PROCEDURE'
AND name = 'GETDATE';


--------------------------------------
-- EJERCICIOS
--------------------------------------
CREATE TABLE departamento(
	idDepto INT PRIMARY KEY,
	nombreDepto VARCHAR2(25)  NOT NULL
);
INSERT INTO departamento VALUES(1,'ventas');
INSERT INTO departamento VALUES(2,'recursos humanos');
INSERT INTO departamento VALUES(3,'administracion');

CREATE TABLE producto(
	idProducto INT PRIMARY KEY,
	nombreProducto VARCHAR2(50)  NOT NULL,
	descripcion VARCHAR2(50) NULL,
	precioUnidad FLOAT NOT NULL
);
INSERT INTO producto (idProducto,nombreProducto,descripcion,precioUnidad) VALUES (1,'elit','laoreet posuere,',53.39);
INSERT INTO producto (idProducto,nombreProducto,descripcion,precioUnidad) VALUES (2,'Ut sagittis','ligula tortor, dictum',95.80);
INSERT INTO producto (idProducto,nombreProducto,descripcion,precioUnidad) VALUES (3,'non','consectetuer adipiscing elit. Etiam laoreet,',66.04);
INSERT INTO producto (idProducto,nombreProducto,descripcion,precioUnidad) VALUES (4,'vestibulum. Mauris','commodo auctor velit. Aliquam',66.94);
INSERT INTO producto (idProducto,nombreProducto,descripcion,precioUnidad) VALUES (5,'ornare, lectus','non, bibendum',35.39);
INSERT INTO producto (idProducto,nombreProducto,descripcion,precioUnidad) VALUES (6,'egestas.','aliquam, enim nec tempus scelerisque',89.31);
INSERT INTO producto (idProducto,nombreProducto,descripcion,precioUnidad) VALUES (7,'est,','iaculis odio. Nam interdum enim',39.24);
INSERT INTO producto (idProducto,nombreProducto,descripcion,precioUnidad) VALUES (8,'dolor quam,','Sed eget lacus.',89.05);
INSERT INTO producto (idProducto,nombreProducto,descripcion,precioUnidad) VALUES (9,'fermentum convallis','rutrum magna. Cras',70.85);
INSERT INTO producto (idProducto,nombreProducto,descripcion,precioUnidad) VALUES (10,'libero.','augue ac ipsum. Phasellus',70.59);
drop table producto;
DELETE FROM producto;

CREATE TABLE cliente(
	idCliente INT PRIMARY KEY,
	nombreCliente VARCHAR2(50) NOT NULL,
	ciudad VARCHAR2(50) NULL
);
INSERT INTO cliente (idCliente,nombreCliente,ciudad) VALUES (1,'Karen Dunn','Guntur');
INSERT INTO cliente (idCliente,nombreCliente,ciudad) VALUES (2,'Buckminster Hester','Canmore');
INSERT INTO cliente (idCliente,nombreCliente,ciudad) VALUES (3,'Ainsley Weiss','Las Cabras');
INSERT INTO cliente (idCliente,nombreCliente,ciudad) VALUES (4,'McKenzie Stanley','Castello di Godego');
INSERT INTO cliente (idCliente,nombreCliente,ciudad) VALUES (5,'Ila Nunez','Corvino San Quirico');
INSERT INTO cliente (idCliente,nombreCliente,ciudad) VALUES (6,'Cassady Pierce','Whitby');
INSERT INTO cliente (idCliente,nombreCliente,ciudad) VALUES (7,'Justine Mcleod','Yeotmal');
drop table cliente;
delete from cliente;
CREATE TABLE empleado(
	idEmpleado INT PRIMARY KEY,
	nombreEmpleado VARCHAR2(50) NOT NULL,
	salario float NOT NULL,
	idDepto INT NOT NULL
);
ALTER TABLE empleado ADD FOREIGN KEY(idDepto) REFERENCES departamento(idDepto);
INSERT INTO empleado (idEmpleado,nombreEmpleado,salario,idDepto) VALUES (1,'Thaddeus Dodson','8.55',1);
INSERT INTO empleado (idEmpleado,nombreEmpleado,salario,idDepto) VALUES (2,'Hayley Solomon','7.00',1);
INSERT INTO empleado (idEmpleado,nombreEmpleado,salario,idDepto) VALUES (3,'Kermit Rowe','7.20',1);
INSERT INTO empleado (idEmpleado,nombreEmpleado,salario,idDepto) VALUES (4,'Ora Downs','11.20',3);
INSERT INTO empleado (idEmpleado,nombreEmpleado,salario,idDepto) VALUES (5,'Audra Pierce','12.97',2);
INSERT INTO empleado (idEmpleado,nombreEmpleado,salario,idDepto) VALUES (6,'Phoebe Nelson','12.24',2);
INSERT INTO empleado (idEmpleado,nombreEmpleado,salario,idDepto) VALUES (7,'Quynn Burke','12.29',3);

delete from empleado;
drop table empleado;
CREATE TABLE factura(
	idFactura INT PRIMARY KEY,
	idEmpleado INT NOT NULL,
	idCliente INT NOT NULL,
    fecha DATE NOT NULL
);

ALTER TABLE factura ADD FOREIGN KEY(idEmpleado) REFERENCES empleado(idEmpleado);
ALTER TABLE factura ADD FOREIGN KEY(idCliente) REFERENCES cliente(idCliente);

INSERT INTO factura VALUES(1,3,7,TO_DATE('1/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(2,3,3,TO_DATE('2/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(3,3,6,TO_DATE('3/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(4,3,4,TO_DATE('4/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(5,1,2,TO_DATE('5/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(6,1,5,TO_DATE('6/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(7,1,1,TO_DATE('7/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(8,1,7,TO_DATE('8/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(9,1,7,TO_DATE('9/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(10,2,7,TO_DATE('10/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(11,1,1,TO_DATE('11/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(12,2,4,TO_DATE('12/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(13,1,7,TO_DATE('13/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(14,1,6,TO_DATE('14/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(15,1,3,TO_DATE('15/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(16,2,4,TO_DATE('16/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(17,3,1,TO_DATE('17/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(18,1,7,TO_DATE('18/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(19,3,5,TO_DATE('19/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(20,1,1,TO_DATE('20/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(21,2,6,TO_DATE('21/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(22,1,3,TO_DATE('22/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(23,3,1,TO_DATE('23/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(24,1,1,TO_DATE('24/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(25,3,3,TO_DATE('25/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(26,3,5,TO_DATE('26/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(27,3,5,TO_DATE('27/11/2017', 'DD/MM/YYYY'));
INSERT INTO factura VALUES(28,3,2,TO_DATE('28/11/2017', 'DD/MM/YYYY'));

drop table factura;
delete from factura;
alter table factura add fecha date;
select * from factura;

CREATE TABLE ventaFactura(
	idFactura INT NOT NULL,
	idProducto INT NOT NULL,
	cantidad INT NOT NULL
);

ALTER TABLE ventaFactura ADD PRIMARY KEY(idFactura, idProducto);
ALTER TABLE ventaFactura ADD FOREIGN KEY(idProducto) REFERENCES producto(idProducto);
ALTER TABLE ventaFactura ADD FOREIGN KEY(idFactura) REFERENCES factura(idFactura);

INSERT INTO ventaFactura VALUES(1,5,2);
INSERT INTO ventaFactura VALUES(2,5,2);
INSERT INTO ventaFactura VALUES(3,4,10);
INSERT INTO ventaFactura VALUES(3,6,2);
INSERT INTO ventaFactura VALUES(4,10,2);
INSERT INTO ventaFactura VALUES(5,9,1);
INSERT INTO ventaFactura VALUES(6,10,7);
INSERT INTO ventaFactura VALUES(6,7,2);
INSERT INTO ventaFactura VALUES(7,5,3);
INSERT INTO ventaFactura VALUES(7,7,6);
INSERT INTO ventaFactura VALUES(8,7,4);
INSERT INTO ventaFactura VALUES(8,5,3);
INSERT INTO ventaFactura VALUES(9,8,9);
INSERT INTO ventaFactura VALUES(9,3,10);
INSERT INTO ventaFactura VALUES(9,1,10);
INSERT INTO ventaFactura VALUES(9,6,8);
INSERT INTO ventaFactura VALUES(9,5,3);
INSERT INTO ventaFactura VALUES(10,9,3);
INSERT INTO ventaFactura VALUES(10,1,10);
INSERT INTO ventaFactura VALUES(11,10,6);
INSERT INTO ventaFactura VALUES(11,9,3);
INSERT INTO ventaFactura VALUES(12,5,9);
INSERT INTO ventaFactura VALUES(12,1,1);
INSERT INTO ventaFactura VALUES(12,3,4);
INSERT INTO ventaFactura VALUES(13,5,3);
INSERT INTO ventaFactura VALUES(14,6,4);
INSERT INTO ventaFactura VALUES(15,5,6);
INSERT INTO ventaFactura VALUES(15,3,5);
INSERT INTO ventaFactura VALUES(15,6,9);
INSERT INTO ventaFactura VALUES(15,4,3);
INSERT INTO ventaFactura VALUES(16,3,9);
INSERT INTO ventaFactura VALUES(17,4,7);
INSERT INTO ventaFactura VALUES(17,3,6);
INSERT INTO ventaFactura VALUES(18,6,2);
INSERT INTO ventaFactura VALUES(18,10,4);
INSERT INTO ventaFactura VALUES(19,2,9);
INSERT INTO ventaFactura VALUES(20,7,5);
INSERT INTO ventaFactura VALUES(20,4,9);
INSERT INTO ventaFactura VALUES(21,1,9);
INSERT INTO ventaFactura VALUES(22,9,7);
INSERT INTO ventaFactura VALUES(23,2,10);
INSERT INTO ventaFactura VALUES(24,2,6);
INSERT INTO ventaFactura VALUES(25,8,9);
INSERT INTO ventaFactura VALUES(25,1,4);
INSERT INTO ventaFactura VALUES(26,9,9);
INSERT INTO ventaFactura VALUES(26,2,6);
INSERT INTO ventaFactura VALUES(26,3,3);
INSERT INTO ventaFactura VALUES(26,8,10);
INSERT INTO ventaFactura VALUES(26,7,10);
INSERT INTO ventaFactura VALUES(27,10,4);
INSERT INTO ventaFactura VALUES(27,2,4);
INSERT INTO ventaFactura VALUES(28,5,8);
INSERT INTO ventaFactura VALUES(28,6,5);
INSERT INTO ventaFactura VALUES(28,7,8);

drop table ventaFactura;
delete from ventaFactura;

--EJERCICIO 1
--Mostrar el empleado que mas ventas ha realizado.
--VERSIÓN 1: SubConsultas
--Paso 1: Mostrar la lista de empleados y las ventas realizadas por cada uno
SELECT e.idEmpleado, e.nombreEmpleado, SUM (vf.cantidad * p.precioUnidad) as total
FROM empleado e, factura f, ventaFactura vf, producto p
WHERE e.idEmpleado = f.idEmpleado 
	AND f.idFactura = vf.idFactura
	AND vf.idProducto = p.idProducto
GROUP BY e.idEmpleado, e.nombreEmpleado;

--Paso 2: A partir de la consulta del paso 1, seleccionar como dato (no como tabla)
--el valor de la mayor venta.
SELECT  MAX(total) 
FROM (
	SELECT e.idEmpleado, e.nombreEmpleado, SUM (vf.cantidad * p.precioUnidad) as total
	FROM empleado e, factura f, ventaFactura vf, producto p
	WHERE e.idEmpleado = f.idEmpleado 
		AND f.idFactura = vf.idFactura
		AND vf.idProducto = p.idProducto
	GROUP BY e.idEmpleado, e.nombreEmpleado
);

--Paso 3: Como base, se toma la consulta del paso 1 y se selecciona el registro que 
--tenga la mayor venta:
SELECT e.idEmpleado, e.nombreEmpleado, SUM (vf.cantidad * p.precioUnidad) as total
FROM empleado e, factura f, ventaFactura vf, producto p
WHERE e.idEmpleado = f.idEmpleado 
	AND f.idFactura = vf.idFactura
	AND vf.idProducto = p.idProducto
GROUP BY e.idEmpleado, e.nombreEmpleado
HAVING SUM (vf.cantidad * p.precioUnidad) =
	(SELECT  MAX(total) 
	FROM (
		SELECT e.idEmpleado, e.nombreEmpleado, SUM (vf.cantidad * p.precioUnidad) as total
		FROM empleado e, factura f, ventaFactura vf, producto p
		WHERE e.idEmpleado = f.idEmpleado 
			AND f.idFactura = vf.idFactura
			AND vf.idProducto = p.idProducto
		GROUP BY e.idEmpleado, e.nombreEmpleado
	));

--VERSIÓN 2: Programación PL/SQL	
CREATE OR REPLACE PROCEDURE GETBESTSELLER IS
	ventas FLOAT := 0.0;
	ventasAux FLOAT := 0.0;
    idEmp INT;
    nombreEmp VARCHAR2(50);
	CURSOR ventas_emp IS  
        SELECT SUM (vf.cantidad * p.precioUnidad) as total
		FROM empleado e, factura f, ventaFactura vf, producto p
		WHERE e.idEmpleado = f.idEmpleado 
			AND f.idFactura = vf.idFactura
			AND vf.idProducto = p.idProducto
		GROUP BY e.idEmpleado, e.nombreEmpleado;
BEGIN
	OPEN ventas_emp;
    LOOP
        FETCH ventas_emp INTO ventasAux;
        EXIT WHEN ventas_emp%NOTFOUND;
		IF ventas < ventasAux THEN
            ventas := ventasAux;
        END IF;
    END LOOP;
    SELECT e.idEmpleado, e.nombreEmpleado
    INTO idEmp, nombreEmp
    FROM empleado e, factura f, ventaFactura vf, producto p
    WHERE e.idEmpleado = f.idEmpleado 
        AND f.idFactura = vf.idFactura
        AND vf.idProducto = p.idProducto
    GROUP BY e.idEmpleado, e.nombreEmpleado
    HAVING SUM (vf.cantidad * p.precioUnidad) = ventas;
	DBMS_OUTPUT.put_line('El vendedor con mayor notas id: ' || idEmp || ', nombre: ' || nombreEmp || ', ventas: ' || ventas );
END;

EXEC GETBESTSELLER;

--¿Es posible modularizar mejor este programa?
--VERSIÓN 3: Programación PL/SQL combinando procedimientos almacenados y funciones
CREATE OR REPLACE FUNCTION getMaxSale
RETURN FLOAT IS
	ventas FLOAT := 0.0;
	ventasAux FLOAT := 0.0;
	CURSOR ventas_emp IS  
        SELECT SUM (vf.cantidad * p.precioUnidad) as total
		FROM empleado e, factura f, ventaFactura vf, producto p
		WHERE e.idEmpleado = f.idEmpleado 
			AND f.idFactura = vf.idFactura
			AND vf.idProducto = p.idProducto
		GROUP BY e.idEmpleado, e.nombreEmpleado;
BEGIN
    OPEN ventas_emp;
    LOOP
        FETCH ventas_emp INTO ventasAux;
        EXIT WHEN ventas_emp%NOTFOUND;
		IF ventas < ventasAux THEN
            ventas := ventasAux;
        END IF;
    END LOOP;
    RETURN ventas;
END;
CREATE OR REPLACE PROCEDURE GETBESTSELLER IS
    idEmp INT;
    nombreEmp VARCHAR2(50);
BEGIN
    SELECT e.idEmpleado, e.nombreEmpleado
    INTO idEmp, nombreEmp
    FROM empleado e, factura f, ventaFactura vf, producto p
    WHERE e.idEmpleado = f.idEmpleado 
        AND f.idFactura = vf.idFactura
        AND vf.idProducto = p.idProducto
    GROUP BY e.idEmpleado, e.nombreEmpleado
    HAVING SUM (vf.cantidad * p.precioUnidad) = getMaxSale();
	DBMS_OUTPUT.put_line('El vendedor con mayor notas id: ' || idEmp || ', nombre: ' || nombreEmp || ', ventas: ' || getMaxSale() );
END;

EXEC GETBESTSELLER;

--EJERCICIO 2
--La siguiente consulta muestra el detalle de cada factura:
SELECT factu.idFactura, pro.nombreProducto, pro.precioUnidad, vf.cantidad, (pro.precioUnidad*vf.cantidad) as total, factu.fecha
FROM FACTURA factu, ventaFactura vf, producto pro
WHERE factu.idFactura = vf.idFactura 
	AND vf.idProducto = pro.idProducto
ORDER BY factu.idFactura ASC, total ASC;

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

EXEC GETBENEFITS('01/11/2017','02/11/2017');

