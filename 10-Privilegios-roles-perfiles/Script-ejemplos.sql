--****************************************************
-- Administración de bases de datos relacionales
-- privilegios, roles y perfiles
-- Autor: Erick Varela
-- Git: https://github.com/vareladev/administracion-bases-de-datos
-- Versión: 1.0
-- Fecha: Agosto 2018
--****************************************************

--SYS: creando usuarios 
CREATE USER gaviota
    IDENTIFIED BY root
    DEFAULT TABLESPACE system
    TEMPORARY TABLESPACE temp
    QUOTA 1M ON system;
	
CREATE USER cuervo
    IDENTIFIED BY root
    DEFAULT TABLESPACE system
    TEMPORARY TABLESPACE temp
    QUOTA 1M ON system;
    
--SYS: otorgando permisos a gaviota
GRANT CREATE SESSION TO gaviota WITH ADMIN OPTION;
GRANT CREATE TABLE TO gaviota;
GRANT SELECT ANY TABLE TO gaviota;


--GAVIOTA: iniciar sesion con gaviota y dar a cuervo el privilegio de iniciar sesion, 
--priviliegio de sistema
GRANT CREATE SESSION TO cuervo;

--CUERVO: iniciar sesion con cuervo
--GAVIOTA: crear tabla con gaviota
CREATE TABLE seagull ( 
   ident INT PRIMARY KEY,
   valor INT
);

--GAVIOTA: mostrando el propietario de un objeto
 select owner
     , object_name
     , object_type
  from ALL_OBJECTS
 where object_name = 'SEAGULL';
 
--GAVIOTA: otorgar a cuervo la posibilidad de realizar select en la tabla seagull, 
--privilegio de objeto
GRANT SELECT ON seagull TO cuervo;

--SYS: revocando privilegio CREATE SESSION
REVOKE CREATE SESSION FROM gaviota;
REVOKE CREATE SESSION FROM cuervo;
REVOKE CREATE TABLE FROM gaviota;
REVOKE SELECT ON seagull FROM cuervo;
REVOKE SELECT ANY TABLE FROM gaviota;

--SYS: creando rol
CREATE ROLE usuarios;

--SYS: asignando privilegios a rol
GRANT CREATE SESSION TO usuarios;
GRANT CREATE TABLE TO usuarios;
GRANT SELECT ANY TABLE TO usuarios;

--SYS: asignando rol a usuarios
GRANT usuarios TO gaviota;
GRANT usuarios TO cuervo;

--SYS: ver todos los roles
SELECT * FROM DBA_ROLES;

--SYS: mostrando todos los privilegios y roles
select * from USER_ROLE_PRIVS where USERNAME='SYS';
select * from USER_TAB_PRIVS where Grantee = 'SYS';
select * from USER_SYS_PRIVS where USERNAME = 'SYS';

--Granted Roles:
select * from USER_ROLE_PRIVS where USERNAME='GAVIOTA';
--Privileges Granted Directly To User:
select * from USER_TAB_PRIVS where Grantee = 'GAVIOTA';
--Granted System Privileges:
select * from USER_SYS_PRIVS where USERNAME = 'GAVIOTA';

--PERFILES:
--SYS: Crear perfil
CREATE PROFILE perfilusuarios LIMIT
    FAILED_LOGIN_ATTEMPTS 5
    PASSWORD_LIFE_TIME 30
    PASSWORD_REUSE_TIME 60
    PASSWORD_REUSE_MAX 3
    PASSWORD_LOCK_TIME 1
    PASSWORD_GRACE_TIME 10;

--SYS: Asignando perfil
-- editando usuario
CREATE USER gaviota
    PROFILE perfilusuarios;
	
-- creando usuario
DROP USER gaviota CASCADE;

CREATE USER gaviota
    IDENTIFIED BY root
    DEFAULT TABLESPACE system
    QUOTA 10M ON system
    TEMPORARY TABLESPACE temp
    PROFILE perfilusuarios;
GRANT usuarios TO gaviota;


