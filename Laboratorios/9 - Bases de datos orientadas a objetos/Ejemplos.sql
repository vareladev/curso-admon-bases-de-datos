-- CREANDO OBJETO PERSONA

CREATE OR REPLACE TYPE OBJ_Persona AS OBJECT(
    apellidos VARCHAR2(50),
	nombres VARCHAR2(50),
	anioNacimiento INT,
    MEMBER FUNCTION calcularEdad RETURN INT,
    MEMBER PROCEDURE toString               --Un método que no retorna nada debe ser un procedimiento almacenado               
) FINAL;

-- DEFINIENDO METODOS
CREATE OR REPLACE TYPE BODY OBJ_Persona AS

    --Métdodo calcularEdad
    MEMBER FUNCTION calcularEdad RETURN INT IS
        fecha DATE;
        current_year INT := 0;
        edad INT := 0;
    BEGIN
        SELECT sysdate INTO fecha FROM dual;
        SELECT EXTRACT(YEAR FROM fecha) INTO current_year FROM dual;
        edad := current_year - anioNacimiento;
        RETURN edad;
    END calcularEdad;
    
    -- Método toString
    MEMBER PROCEDURE toString IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('{ Apellidos: ' || apellidos || ', Nombres: ' || nombres || ', Año de nacimiento: ' || anioNacimiento || '}');
    END toString;

END;

-- USO DE LOS MÉTODOS
DECLARE
    persona1 OBJ_Persona;
BEGIN
    persona1 := OBJ_Persona('Rivas', 'Nicole', 2001);
    DBMS_OUTPUT.PUT_LINE('Uso del método toString');
    persona1.toString();
    DBMS_OUTPUT.PUT_LINE('Apellidos: ' || persona1.apellidos || ', Nombres: ' || persona1.nombres || 
                         ', Edad: ' || persona1.calcularEdad());
END;

-- ALMACENAR OBJETOS EN UNA TABLA

CREATE TABLE tabla_persona(
    idPersona INT,
    persona OBJ_Persona
);

ALTER TABLE tabla_persona ADD CONSTRAINT PK_tabla_persona PRIMARY KEY(idPersona);

INSERT INTO tabla_persona VALUES(1, OBJ_Persona('Ramos', 'Ana', 1998));
INSERT INTO tabla_persona VALUES(2, OBJ_Persona('Santos', 'Leonardo', 1999));
INSERT INTO tabla_persona VALUES(3, OBJ_Persona('Rivas', 'Nicole', 2001));

SELECT * FROM tabla_persona;   -- No basta con select * para mostrar el contenido del objeto

SELECT tp.idPersona, tp.persona.apellidos, tp.persona.nombres, tp.persona.calcularEdad() FROM tabla_persona tp;

-- Debido a que debe seguir encapsulamiento, se utilizan alias para no revelar nombres de campos y metodos
SELECT tp.idPersona, tp.persona.apellidos AS Apellidos, tp.persona.nombres AS Nombres, tp.persona.calcularEdad()
AS Edad FROM tabla_persona tp;
--DROP TABLE tabla_persona;



-- TABLAS BASADAS EN OBJETOS

CREATE OR REPLACE TYPE OBJ_Persona AS OBJECT(
    idPersona INT,
    apellidos VARCHAR2(50),
	nombres VARCHAR2(50),
	anioNacimiento INT,
    MEMBER FUNCTION calcularEdad RETURN INT,
    MEMBER PROCEDURE toString  
) FINAL;

CREATE OR REPLACE TYPE BODY OBJ_Persona AS

    --Método calcularEdad
    MEMBER FUNCTION calcularEdad RETURN INT IS
        fecha DATE;
        current_year INT := 0;
        edad INT := 0;
    BEGIN
        SELECT sysdate INTO fecha FROM dual;
        SELECT EXTRACT(YEAR FROM fecha) INTO current_year FROM dual;
        edad := current_year - anioNacimiento;
        RETURN edad;
    END calcularEdad;
    
    -- Método toString
    MEMBER PROCEDURE tostring IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('{ Apellidos: ' || apellidos || ', Nombres: ' || nombres || ', Año de nacimiento: ' || anioNacimiento || '}');
    END tostring;

END;

-- CREAR TABLAS BASADAS EN OBJETOS

CREATE TABLE tabla_persona OF OBJ_Persona;

ALTER TABLE tabla_persona ADD CONSTRAINT PK_tabla_persona PRIMARY KEY(idPersona);

INSERT INTO tabla_persona VALUES(OBJ_Persona(1, 'Ramos', 'Ana', 1998));
INSERT INTO tabla_persona VALUES(OBJ_Persona(2, 'Santos', 'Leonardo', 1999));
INSERT INTO tabla_persona VALUES(OBJ_Persona(3, 'Rivas', 'Nicole', 2001));

SELECT * FROM tabla_persona;
--DROP TABLE tabla_persona;


-- HERENCIA

CREATE OR REPLACE TYPE OBJ_Persona AS OBJECT(
    apellidos VARCHAR2(50),
	nombres VARCHAR2(50),
	anioNacimiento INT,
    MEMBER FUNCTION calcularEdad RETURN INT,
    MEMBER PROCEDURE toString
) NOT FINAL;

CREATE OR REPLACE TYPE BODY OBJ_Persona AS

    MEMBER FUNCTION calcularEdad RETURN INT AS
        fecha DATE;
        current_year INT := 0;
        edad INT := 0;
    BEGIN
        SELECT sysdate INTO fecha FROM dual;
        SELECT EXTRACT(YEAR FROM fecha) INTO current_year FROM dual;
        edad := current_year - anioNacimiento;
        RETURN edad;
    END calcularEdad;
    
    -- Método toString
    MEMBER PROCEDURE toString IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('{ Apellidos: ' || apellidos || ', Nombres: ' || nombres || ', Año de nacimiento: ' || anioNacimiento || '}');
    END toString;

END;

-- OBJETO alumno HEREDA DE persona

CREATE OR REPLACE TYPE OBJ_Alumno UNDER OBJ_Persona(
    carnet CHAR(8)
);

-- USO DEL MÉTODO tostring CON UN OBJETO OBJ_Alumno
DECLARE
    al OBJ_Alumno;
BEGIN
    al := OBJ_Alumno('Rivas', 'Nicole', 2001,'00000618');
    al.toString();
END;

-- Debido a que usa el método toString de persona, no muestra el carnet, pues solo pertenece a el subtipo OBJ_Alumno

CREATE OR REPLACE TYPE OBJ_Alumno UNDER OBJ_Persona(
    carnet CHAR(8),
    OVERRIDING MEMBER PROCEDURE toString
);

CREATE OR REPLACE TYPE BODY OBJ_Alumno AS

    OVERRIDING MEMBER PROCEDURE toString IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('{ Carnet: ' || carnet || ', Apellidos: ' || apellidos || ', Nombres: ' || nombres || ', Año de nacimiento: ' || anioNacimiento || '}');
    END toString;
    
END;

-- PRUEBA NUEVO METODO toString
DECLARE
    al OBJ_Alumno;
BEGIN
    al := OBJ_Alumno('Rivas', 'Nicole', 2001,'00000618');
    al.toString();
END;







