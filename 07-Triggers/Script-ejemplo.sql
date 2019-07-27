--****************************************************
-- Administración de bases de datos relacionales
-- Transacciones
-- Autor: Erick Varela
-- Git: https://github.com/vareladev/administracion-bases-de-datos
-- Versión: 1.0
-- Fecha: Agosto 2018
--****************************************************


CREATE TABLESPACE tbl_clase08
	DATAFILE 'tbl_clase08.dbf'
	SIZE 10M AUTOEXTEND ON;

CREATE USER trigger_user 
IDENTIFIED BY root
DEFAULT TABLESPACE tbl_clase08
TEMPORARY TABLESPACE temp
QUOTA unlimited ON tbl_clase08;

GRANT CONNECT,RESOURCE,DBA TO trigger_user;
GRANT CREATE SESSION TO trigger_user;

--////////////////////////////////////////////////////////////////
-- TRIGGERS
--////////////////////////////////////////////////////////////////
CREATE TABLE CUENTA(
	numeroCuenta VARCHAR2(26) PRIMARY KEY,
	cliente VARCHAR2(50) NOT NULL,
	saldo FLOAT DEFAULT 0.0
);
INSERT INTO CUENTA(numeroCuenta,cliente, saldo) 
	VALUES('SV-56-FFGT-000001234567-89', 'Alejandra Carcamo', 5000);
INSERT INTO CUENTA(numeroCuenta,cliente,saldo) 
	VALUES('SV-56-FFGT-000000842365-56', 'Mario Alvarez',1000);


--////////////////////////////////////////////////////////////////
--EJERCICIO 1
--Utilizando triggers para validar datos.
CREATE OR REPLACE TRIGGER tr_validate_balance
  AFTER INSERT ON cuenta
  FOR EACH ROW
BEGIN
    IF :NEW.saldo < 0 THEN
        raise_application_error(-20010, 'Saldo inválido, el valor es menor a $0');
    ELSIF not  regexp_like(:NEW.numeroCuenta,'SV-[0-9]{2}-[A-Z]{4}-[0-9]{12}-[0-9]{2}') THEN
        raise_application_error(-20010, 'múmero de cuenta inválido, el formato debe se: SV-XX-AAAA-XXXXXXXXXXXX-XX');
    END IF;
END;

--Intentando insertar en cuenta con saldo negativo
INSERT INTO CUENTA(numeroCuenta,cliente, saldo) 
	VALUES('SV-56-FFGT-000001234567-17', 'Carlos Salguero', -3000);
--Intentando insertar una cuenta invalida
INSERT INTO CUENTA(numeroCuenta,cliente, saldo) 
	VALUES('SV-56-FFGT-000001234567-1B', 'Carlos Salguero', 3000);
--Intentando insertar una cuenta válida
INSERT INTO CUENTA(numeroCuenta,cliente, saldo) 
	VALUES('SV-56-FFGT-000001234567-17', 'Carlos Salguero', 3000);
    
    
--EJERCICIO 2
--Utilizando triggers para crear un registro de cambios.    
--TRIGGER VERSION 1:
CREATE TABLE transaccion(
	numeroCuenta VARCHAR(26) NOT NULL,
    SaldoAnterior FLOAT,
	SaldoActual FLOAT,
	fecha TIMESTAMP 
);

CREATE OR REPLACE TRIGGER tr_account_changes
  BEFORE UPDATE ON CUENTA
  FOR EACH ROW
DECLARE
    numeroCuenta cuenta.numeroCuenta%type;
    saldoInicial cuenta.saldo%type;
    saldoFinal cuenta.saldo%type;
BEGIN
    numeroCuenta := (:NEW.numeroCuenta);
    saldoInicial := :OLD.saldo;
    saldoFinal := :NEW.saldo;
    INSERT INTO transaccion
			VALUES(numeroCuenta, saldoInicial, saldoFinal, sysdate);
END;

--Comprobando funcionamiento.
UPDATE cuenta SET saldo = saldo + 300 WHERE numeroCuenta = 'SV-56-FFGT-000000842365-56';

SELECT * FROM cuenta;
SELECT * FROM transaccion;

--////////////////////////////////////////////////////////////////
--TRIGGER VERSION 2:
DROP TABLE transaccion;
CREATE TABLE transaccion(
	numeroCuenta VARCHAR(26) NOT NULL,
    SaldoAnterior FLOAT,
	SaldoActual FLOAT,
    tipoTransaccion VARCHAR2(20),
    usuario VARCHAR2(20),
	fecha TIMESTAMP 
);

CREATE OR REPLACE TRIGGER tr_account_changes
  BEFORE UPDATE ON CUENTA
  FOR EACH ROW
DECLARE
    numeroCuenta cuenta.numeroCuenta%type;
    saldoInicial cuenta.saldo%type;
    saldoFinal cuenta.saldo%type;
    usuario VARCHAR2(20);
    tipoTransaccion VARCHAR2(20);
BEGIN
    numeroCuenta := (:NEW.numeroCuenta);
    saldoInicial := :OLD.saldo;
    saldoFinal := :NEW.saldo;
    --verificando usuario
    SELECT user INTO usuario FROM DUAL;
    --verificando tipo de transaccion
    tipoTransaccion := 'No modificacion';
    IF saldoInicial > saldoFinal THEN
        tipoTransaccion := 'Retiro';
    ELSIF saldoInicial < saldoFinal THEN
        tipoTransaccion := 'Abono';
    END IF;
    INSERT INTO transaccion
			VALUES(numeroCuenta, saldoInicial, saldoFinal, tipoTransaccion, usuario, sysdate);
END;

--Comprobando funcionamiento.
UPDATE cuenta SET saldo = saldo + 300 WHERE numeroCuenta = 'SV-56-FFGT-000000842365-56';
SELECT * FROM cuenta;


UPDATE cuenta SET saldo = saldo - 100 WHERE numeroCuenta = 'SV-56-FFGT-000000842365-56';
SELECT * FROM cuenta;
SELECT * FROM transaccion;

--////////////////////////////////////////////////////////////////
CREATE OR REPLACE PROCEDURE pago (ctaOrigen IN VARCHAR2, ctaDestino IN VARCHAR2, cantidad IN FLOAT)
IS
	saldoCtaOrigen cuenta.saldo%type;
BEGIN
	--verificando si el saldo de la cuenta origen es suficiente para realizar el pago
    SELECT saldo INTO saldoCtaOrigen FROM cuenta WHERE numeroCuenta = ctaOrigen;
    IF saldoCtaOrigen >= cantidad THEN
		UPDATE CUENTA SET saldo = saldo - cantidad WHERE numeroCuenta = ctaOrigen;
		UPDATE CUENTA SET saldo = saldo + cantidad WHERE numeroCuenta = ctaDestino;
	END IF;
END;

EXEC pago ('SV-56-FFGT-000001234567-89', 'SV-56-FFGT-000000842365-56',1000);
SELECT * FROM transaccion;

--////////////////////////////////////////////////////////////////
--TRIGGER DE AUDITORIA:
CREATE TABLE cuenta_audit(
    tipoTransaccion VARCHAR2(20),
    usuario VARCHAR2(20),
	fecha TIMESTAMP,
    descripcion VARCHAR2(500)
);


CREATE OR REPLACE TRIGGER tr_account_changes
  AFTER UPDATE  OR INSERT OR DELETE ON CUENTA
  FOR EACH ROW
DECLARE
    usuario VARCHAR2(20);
    tipoTransaccion VARCHAR2(20);
    descripcion VARCHAR2(500);
BEGIN
    SELECT user INTO usuario FROM DUAL;
    IF DELETING THEN 
        tipoTransaccion := 'DELETE';
        descripcion := 'Cuenta '||:OLD.numeroCuenta|| ' eliminada; Datos registrados antes de la eliminación: ' ||
            'Cliente: ' || :OLD.cliente || ', saldo: $' || :OLD.saldo;
    END IF;
    
    IF INSERTING THEN 
        tipoTransaccion := 'INSERT';
        descripcion := 'Cuenta: ' || :NEW.numeroCuenta || ' creada;  A nombre de: ' ||
            :NEW.cliente ||', saldo inicial $0.0';
    END IF;
    
    IF UPDATING THEN 
        tipoTransaccion := 'UPDATE';
        descripcion := 'Cuenta '||:OLD.numeroCuenta|| ' Actualizada; Datos modificados: ';
        IF :OLD.cliente != :NEW.cliente THEN
            descripcion := descripcion || '{Nombre: '||:OLD.cliente||' por '||:NEW.cliente||'}, ';
        END IF;
        IF :OLD.saldo != :NEW.saldo THEN
            descripcion := descripcion || '{Saldo: $'||:OLD.saldo||' por $'||:NEW.saldo||'}';
        END IF;
    END IF;    
        
    INSERT INTO cuenta_audit
			VALUES(tipoTransaccion, usuario, sysdate, descripcion);
END;

--insertando
INSERT INTO CUENTA(numeroCuenta,cliente) 
	VALUES('SV-56-FFGT-000001234567-90', 'Adriana Noriega');
--actualizando:
UPDATE cuenta SET cliente = 'Adriana Noriega Ventura', saldo = 2300 WHERE numeroCuenta = 'SV-56-FFGT-000001234567-90';
--eliminando
DELETE FROM cuenta WHERE numeroCuenta = 'SV-56-FFGT-000001234567-90';


SELECT * FROM cuenta_audit;    


--////////////////////////////////////////////////////////////////
CREATE OR REPLACE PROCEDURE pago (ctaOrigen IN VARCHAR2, ctaDestino IN VARCHAR2, cantidad IN FLOAT)
IS
	saldoCtaOrigen cuenta.saldo%type;
	saldoInsuficiente EXCEPTION;
BEGIN
	--verificando si el saldo de la cuenta origen es suficiente para realizar el pago
    SELECT saldo INTO saldoCtaOrigen FROM cuenta WHERE numeroCuenta = ctaOrigen;
    IF saldoCtaOrigen >= cantidad THEN
		SAVEPOINT ntransac;
		UPDATE CUENTA SET saldo = saldo - cantidad WHERE numeroCuenta = ctaOrigen;
		UPDATE CUENTA SET saldo = saldo + cantidad WHERE numeroCuenta = ctaDestino;
		COMMIT;
	ELSE
        RAISE saldoInsuficiente;
	END IF;
EXCEPTION
    WHEN saldoInsuficiente THEN
        DBMS_OUTPUT.PUT_LINE( 'ERROR: Saldo insuficiente, no se puede ejecutar la transaccion');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE( 'ERROR: Ocurrio un error inesperado, la transaccion ha sido deshecha');
        ROLLBACK TO ntransac;
END;

EXEC pago ('SV-56-FFGT-000001234567-89', 'SV-56-FFGT-000000842365-56',1000);

SELECT * FROM transaccion;
SELECT * FROM cuenta_audit;
