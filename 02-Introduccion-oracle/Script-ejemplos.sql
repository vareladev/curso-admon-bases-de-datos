--****************************************************
-- Administración de bases de datos relacionales
-- Introducción
-- Autor: Erick Varela
-- Git: https://github.com/vareladev/administracion-bases-de-datos
-- Versión: 1.0
-- Fecha: Agosto 2018
--****************************************************

--Creando tablas
CREATE TABLE materia(
  codigo INT PRIMARY KEY,
  nombre VARCHAR2(50)
);

/*
insertando datos en oracle
comentario de varias lineas
*/
INSERT INTO materia (codigo, nombre) VALUES(1, 'Administracion de bases de datos');
INSERT INTO materia (codigo, nombre) VALUES(2, 'Programacion web');

--seleccionando datos
SELECT codigo, nombre FROM materia;
--opcionalmente
SELECT * FROM materia;

--actualizando datos
UPDATE materia SET nombre = 'administración de bases de datos'
WHERE codigo = 1;

--llaves foraneas
CREATE TABLE evaluacion(
  codigo INT PRIMARY KEY,
  nombre VARCHAR2(50),
  codigoMateria INT
);
ALTER TABLE evaluacion ADD FOREIGN KEY (codigoMateria) REFERENCES materia(codigo);

--eliminando datos
DELETE FROM materia WHERE codigo = 2;
SELECT * FROM materia;
COMMIT

--Tabla DUAL
--Definición
/*Tabla de soporte, creada al momento de instalar Oracle.
Pertenece al diccionario de datos por lo tanto, es propiedad del usuario SYS.*/

SELECT *  FROM dual;

--Utilidad
--Mostrar datos
SELECT 1 FROM DUAL;

--Calcular operaciones aritmeticas
SELECT (2+3)/2 FROM dual;

--Mostrar el usuario conectado
SELECT USER FROM dual;

--Mostrar fechas
SELECT SYSDATE FROM dual;