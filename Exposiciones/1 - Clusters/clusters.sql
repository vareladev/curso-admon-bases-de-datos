--INDEXED CLUSTERS
CREATE CLUSTER employees_departments_cluster
   (department_id NUMBER(4))
SIZE 512;
CREATE INDEX idx_emp_dept_cluster ON CLUSTER employees_departments_cluster;
-- UN INDEXED CLUSTER NO PUEDE TENER HASH.

CREATE TABLE employees (
    id_employee INT,
    nombre VARCHAR(50),
    department_id NUMBER(4)
) CLUSTER employees_departments_cluster (department_id);


CREATE TABLE departments (
    department_id NUMBER(4),
    nombre_dept VARCHAR(50)
) CLUSTER employees_departments_cluster (department_id);


DROP TABLE departments;
DROP TABLE employees;
DROP CLUSTER employees_departments_cluster;







-- HASH CLUSTERS
CREATE CLUSTER employees_departments_cluster
   (department_id NUMBER(4))
SIZE 8192 HASHKEYS 100;
--NO SE DEFINE UN INDEX, UN HASH CLUSTER NO PUEDE TENER INDEX Y VICEVERSA

CREATE TABLE employees (
    id_employee INT,
    nombre VARCHAR(50),
    department_id NUMBER(4)
) CLUSTER employees_departments_cluster (department_id);


CREATE TABLE departments (
    department_id NUMBER(4),
    nombre_dept VARCHAR(50)
) CLUSTER employees_departments_cluster (department_id);


DROP TABLE departments;
DROP TABLE employees;
DROP CLUSTER employees_departments_cluster;
