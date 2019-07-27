--****************************************************
-- Administración de bases de datos relacionales
-- Vistas
-- Autor: Erick Varela
-- Git: https://github.com/vareladev/administracion-bases-de-datos
-- Versión: 1.0
-- Fecha: Agosto 2018
--****************************************************

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


--CREANDO VISTA SIMPLE
CREATE OR REPLACE VIEW generadorfactura (id, name, city)
AS
    SELECT idCliente as id, nombreCliente as name, ciudad as city FROM cliente;
--Sentencias DML sobre una vista
--Mostrando vista
SELECT * FROM generadorfactura;
--Insertando sobre una vista simple
INSERT INTO generadorfactura  (id, name, city) VALUES(8, 'Alice ivanoff', 'noche');
SELECT * FROM generadorfactura;
SELECT * FROM cliente;
--actualizando datos
UPDATE generadorfactura SET city = 'Las noches' WHERE id = 8;
SELECT * FROM generadorfactura;
SELECT * FROM cliente;
--Eliminando datos
DELETE FROM generadorfactura WHERE id = 8;
SELECT * FROM generadorfactura;
SELECT * FROM cliente;
--Eliminando vista
DROP VIEW generadorfactura;

--Limitando a vista de solo lectura
CREATE OR REPLACE VIEW generadorfactura (id, name, city)
AS
    SELECT idCliente as id, nombreCliente as name, ciudad as city FROM cliente
WITH READ ONLY;
--Mostrando vista
SELECT * FROM generadorfactura;
--Insertando sobre una vista simple
INSERT INTO generadorfactura  (id, name, city) VALUES(8, 'Alice ivanoff', 'noche');
--actualizando datos
UPDATE generadorfactura SET city = 'Las noches' WHERE id = 7;
--Eliminando datos
DELETE FROM generadorfactura WHERE id = 7;


--Limitando con la opcion WITH CHECK OPTION
CREATE OR REPLACE VIEW sellers (id, name, salary, depto)
AS
    SELECT idEmpleado as id, nombreEmpleado as name, salario as Salary, idDepto as depto FROM empleado
    WHERE idDepto = 1
WITH CHECK OPTION CONSTRAINT chksellers;
--Mostrando vista
SELECT * FROM sellers;
--actualizando datos
UPDATE sellers SET salary = 8.20 WHERE id = 2;
SELECT * FROM sellers;
--actualizando datos (falla)
UPDATE sellers SET depto = 2 WHERE id = 2;
SELECT * FROM sellers;
--Insertando sobre la vista (falla)
INSERT INTO sellers (id, name, salary, depto) VALUES(8, 'Alice ivanoff', 7.22, 2);
SELECT * FROM sellers;
--Insertando sobre la vista segundo intento
INSERT INTO sellers (id, name, salary, depto) VALUES(8, 'Alice ivanoff', 7.22, 1);
SELECT * FROM sellers;
--Eliminando datos
DELETE FROM sellers WHERE id = 8;
SELECT * FROM sellers;
--Eliminando vista
DROP VIEW sellers;

--Creando vista a partir de una consultas compuesta
CREATE OR REPLACE VIEW employees (id, name, salary, depto)
AS
SELECT emp.idEmpleado as id, emp.nombreEmpleado as name, emp.salario as salary, dep.nombreDepto as depto FROM
empleado emp, departamento dep
WHERE emp.idDepto = dep.idDepto;
--Mostrando vista
SELECT * FROM employees;
--insertando en vista (falla)
INSERT INTO employees (id, name, salary, depto) VALUES(8, 'Alice ivanoff', 10, 'ventas');
--Eliminando vista (funciona)
DELETE FROM employees WHERE id = 7; 
--actualizando sobre vista (funciona)
UPDATE employees SET salary = 10 WHERE id = 1;

--Creando vista a partir de una consultas compuesta ejercicio 2
CREATE OR REPLACE VIEW sellers (id, name, sales)
AS
    SELECT e.idEmpleado as id, e.nombreEmpleado as name, SUM (vf.cantidad * p.precioUnidad) as sales
    FROM empleado e, factura f, ventaFactura vf, producto p
    WHERE e.idEmpleado = f.idEmpleado 
    	AND f.idFactura = vf.idFactura
    	AND vf.idProducto = p.idProducto
    GROUP BY e.idEmpleado, e.nombreEmpleado;
--Mostrando vista
SELECT * FROM sales;
--Eliminando vista (falla)
DELETE FROM sales WHERE id = 1; 
--insertando en vista (falla)
INSERT INTO sales (id, name, sales) VALUES(10, 'Alice ivanoff', 7222);
--actualizando sobre vista (falla)
UPDATE sales SET sales = 10000 WHERE id = 1;


--Agregando control al acceso a los objetos la base de datos utilizando vistas
--creando usuario y dando permisos respectivos
CREATE USER SETH
IDENTIFIED BY 1234
DEFAULT TABLESPACE system
TEMPORARY TABLESPACE temp
QUOTA 10M ON system;

GRANT CREATE SESSION TO SETH;
GRANT SELECT ON sys.sellers TO SETH;

--Iniciar sesión con el usuario recién creado y acceder a la vista con el usuario SETH
SELECT * FROM sys.sellers;

--intentndo hacer el SELECT que utiliza la vista
--¿Porque falla?
SELECT e.idEmpleado as id, e.nombreEmpleado as name, SUM (vf.cantidad * p.precioUnidad) as sales
FROM sys.empleado e, sys.factura f, sys.ventaFactura vf, sys.producto p
WHERE e.idEmpleado = f.idEmpleado 
    AND f.idFactura = vf.idFactura
    AND vf.idProducto = p.idProducto
GROUP BY e.idEmpleado, e.nombreEmpleado;


--------------------------------------
-- Vistas materializadas
--------------------------------------
CREATE MATERIALIZED VIEW vm_emps
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT * FROM empleado;

--Probando DML en vista materializada
--Mostrando vista materializada
SELECT * FROM vm_emps;
--Eliminando vista materializada(falla)
DELETE FROM vm_emps WHERE idEmpleado = 1; 
--insertando en vista materializada(falla)
INSERT INTO vm_emps VALUES(1, 'Alice ivanoff', 10,1);
--Agregando datos a la tabla fuente:
INSERT INTO empleado VALUES(8, 'Alice ivanoff', 10,1);
--Mostrando desde tabla
SELECT * FROM empleado;
--Mostrando vista materializada
SELECT * FROM vm_emps;

--Refrescando vista manualmente
EXEC DBMS_MVIEW.refresh('VM_EMPS');
--Mostrando vista materializada
SELECT * FROM vm_emps;

--Eliminando vista materializada
DROP MATERIALIZED VIEW vm_emps;

--Creando vista mostrando las facturas de la primera quincena de noviembre 2017
CREATE MATERIALIZED VIEW vm_nov2017q1
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT fact.idFactura, fact.fecha, SUM(pro.precioUnidad*vf.cantidad) totalProducto
FROM FACTURA fact, ventaFactura vf, producto pro
WHERE fact.idFactura = vf.idFactura 
	AND vf.idProducto = pro.idProducto
	AND fact.fecha BETWEEN TO_DATE('1/11/2017', 'DD/MM/YYYY') AND TO_DATE('15/11/2017', 'DD/MM/YYYY')
GROUP BY fact.idFactura, fact.fecha
ORDER BY fact.idFactura ASC;
--Mostrando vista materializada
SELECT * FROM vm_nov2017q1;


--------------------------------------
-- SINÓNIMOS
--------------------------------------
--Usando la conexión de SYS: 
CREATE SYNONYM synsellers
FOR sellers;

CREATE PUBLIC SYNONYM synsellers2
FOR sellers;

--Usando la conexión de SETH, usar ambos sinónimos.
SELECT * FROM synsellers;
SELECT * FROM synsellers2;


