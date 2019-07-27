
--************** SCRIPT BASE DE DATOS *****************

CREATE TABLE cliente(
	idCliente INT PRIMARY KEY,
	nombreCliente VARCHAR(100),
	direccion VARCHAR(100),
	telefono CHAR(10),
	correo VARCHAR(50)
);

CREATE TABLE medico(
	idMedico INT PRIMARY KEY,
	nombreMedico VARCHAR(100),
	salario FLOAT,
	FechaContrato DATE
);

CREATE TABLE raza(
	idRaza INT PRIMARY KEY,
	raza VARCHAR(50)
);

CREATE TABLE paciente(
	idPaciente INT PRIMARY KEY,
	nombrePaciente VARCHAR(50),
	idCliente INT,
	idRaza INT,
	fechaNacimiento DATE
);

CREATE TABLE consulta(
	idConsulta INT PRIMARY KEY,
	idPaciente INT,
	idMedico INT,
	fecha DATE,
	precioConsulta FLOAT
);

CREATE TABLE medicamento(
	idMedicamento INT PRIMARY KEY,
	nombre VARCHAR(50),
	precio FLOAT
);

CREATE TABLE receta(
	idMedicamento INT NOT NULL,
	idConsulta INT NOT NULL
);

ALTER TABLE receta ADD PRIMARY KEY(idMedicamento, idConsulta);
ALTER TABLE paciente ADD FOREIGN KEY(idCliente) REFERENCES cliente(idCliente) ON DELETE CASCADE;
ALTER TABLE paciente ADD FOREIGN KEY(idRaza) REFERENCES raza(idRaza) ON DELETE CASCADE;
ALTER TABLE consulta ADD FOREIGN KEY(idPaciente) REFERENCES paciente(idPaciente) ON DELETE CASCADE;
ALTER TABLE consulta ADD FOREIGN KEY(idMedico) REFERENCES medico(idMedico) ON DELETE CASCADE;
ALTER TABLE receta ADD FOREIGN KEY(idMedicamento) REFERENCES medicamento(idMedicamento) ON DELETE CASCADE;
ALTER TABLE receta ADD FOREIGN KEY(idConsulta) REFERENCES consulta(idConsulta) ON DELETE CASCADE;


--**************** BANCO DE DATOS *********************
--RAZA
INSERT INTO raza VALUES(1, 'Jack Russell');
INSERT INTO raza VALUES(2, 'pit bull terrier');
INSERT INTO raza VALUES(3, 'beagle');
INSERT INTO raza VALUES(4, 'Terrier');
INSERT INTO raza VALUES(5, 'Bulldog');
INSERT INTO raza VALUES(6, 'Chihuahua');
INSERT INTO raza VALUES(7, 'Husky');
INSERT INTO raza VALUES(8, 'Pastor Alemán');
INSERT INTO raza VALUES(9, 'Mestizo');

--MEDICO
INSERT INTO medico VALUES(2,'Kasimir Bush','1559',TO_DATE('04/09/2014 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO medico VALUES(3,'Talon Page','1229',TO_DATE('21/08/2016 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO medico VALUES(4,'Brock Howard','1455',TO_DATE('08/04/2014 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));

--CLIENTE
INSERT INTO cliente VALUES(1, 'Julie Fleming','Ap #516-3204 Nulla Road','7996-8165','hendrerit@Vivamus.edu');
INSERT INTO cliente VALUES(2, 'Avye Wiley','P.O. Box 319, 3154 Ornare Rd.','7683-9474','nisi.magna@enimsitamet.net');
INSERT INTO cliente VALUES(3, 'Regan Greene','9943 Tincidunt Ave','7593-2558','Donec@malesuadamalesuada.com');
INSERT INTO cliente VALUES(4, 'Karly Charles','P.O. Box 447, 2355 Euismod Rd.','7975-8486','Nam@nulla.com');
INSERT INTO cliente VALUES(5, 'Melodie George','P.O. Box 257, 5814 Eu, St.','7298-3505','lobortis.risus.In@diamProin.com');
INSERT INTO cliente VALUES(6, 'Dai Oneill','Ap #194-9317 Vel, Rd.','7283-5384','in.dolor.Fusce@vitae.ca');
INSERT INTO cliente VALUES(7, 'Mari Cross','480-7023 Aliquet Rd.','7471-3990','pellentesque@Proin.co.uk');
INSERT INTO cliente VALUES(8, 'TaShya Simpson','8170 Cursus Av.','7119-9480','risus.varius@velfaucibus.net');
INSERT INTO cliente VALUES(9, 'Sonia Woodward','490-6531 Sem. St.','7342-0371','malesuada.fringilla@scelerisque.org');
INSERT INTO cliente VALUES(10, 'Sonia Woodward','490-6531 Sem. St.','7342-0371','malesuada.fringilla@scelerisque.org');
INSERT INTO cliente VALUES(11, 'Lee Chambers','733-1804 Parturient Avenue','7852-6526','vulputate@Cras.net');

--paciente
INSERT INTO paciente VALUES(1, 'Callum',2,1,TO_DATE('10/09/2017 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO paciente VALUES(2, 'Ray',4,7,TO_DATE('02/05/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO paciente VALUES(3, 'Dieter',1,3,TO_DATE('11/10/2016 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO paciente VALUES(4, 'Malachi',2,9,TO_DATE('07/11/2016 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO paciente VALUES(5, 'Rahim',5,6,TO_DATE('28/04/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO paciente VALUES(6, 'Ezra',3,9,TO_DATE('30/06/2017 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO paciente VALUES(7, 'Gannon',6,7,TO_DATE('11/11/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO paciente VALUES(8, 'Griffin',1,6,TO_DATE('07/02/2017 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO paciente VALUES(9, 'Francis',3,7,TO_DATE('10/06/2016 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO paciente VALUES(10, 'Kareem',7,8,TO_DATE('12/06/2017 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO paciente VALUES(11, 'Perry',1,6,TO_DATE('23/05/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO paciente VALUES(12, 'Troy',9,4,TO_DATE('03/07/2016 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO paciente VALUES(13, 'Mason',2,5,TO_DATE('20/04/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'));

--medicamento
INSERT INTO medicamento VALUES(1, 'Aspirina', 8.26);
INSERT INTO medicamento VALUES(2, 'Bromuros de potasio', 8.34);
INSERT INTO medicamento VALUES(3, 'Carprofeno', 1.83);
INSERT INTO medicamento VALUES(4, 'Cloruro de potasio', 2.50);
INSERT INTO medicamento VALUES(5, 'Diazepam', 1.99);
INSERT INTO medicamento VALUES(6, 'Digoxina', 22.85);
INSERT INTO medicamento VALUES(7, 'Enalapril', 17.04);
INSERT INTO medicamento VALUES(8, 'Fenbendazol', 9.50);
INSERT INTO medicamento VALUES(9, 'Metronidazol', 8.99);
INSERT INTO medicamento VALUES(10, 'Piroxicam',7.10);

-- consulta
INSERT INTO consulta VALUES(1, 2,3,TO_DATE('06/03/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),75.96);
INSERT INTO consulta VALUES(2, 1,2,TO_DATE('17/04/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),28.41);
INSERT INTO consulta VALUES(3, 5,2,TO_DATE('23/03/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),90.25);
INSERT INTO consulta VALUES(4, 11,2,TO_DATE('27/03/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),84.14);
INSERT INTO consulta VALUES(5, 13,3,TO_DATE('26/05/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),93.67);
INSERT INTO consulta VALUES(6, 12,2,TO_DATE('30/05/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),18.06);
INSERT INTO consulta VALUES(7, 1,2,TO_DATE('22/05/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),72.14);
INSERT INTO consulta VALUES(8, 2,3,TO_DATE('13/05/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),83.44);
INSERT INTO consulta VALUES(9, 8,3,TO_DATE('19/04/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),86.10);
INSERT INTO consulta VALUES(10, 9,2,TO_DATE('01/03/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),77.47);
INSERT INTO consulta VALUES(11, 13,3,TO_DATE('03/04/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),72.80);
INSERT INTO consulta VALUES(12, 6,3,TO_DATE('30/04/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),23.70);
INSERT INTO consulta VALUES(13, 7,3,TO_DATE('19/03/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),38.96);
INSERT INTO consulta VALUES(14, 4,4,TO_DATE('15/03/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),0.79);
INSERT INTO consulta VALUES(15, 2,3,TO_DATE('18/03/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),26.72);
INSERT INTO consulta VALUES(16, 1,2,TO_DATE('16/03/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),81.15);
INSERT INTO consulta VALUES(17, 2,2,TO_DATE('10/03/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),14.84);
INSERT INTO consulta VALUES(18, 10,4,TO_DATE('24/03/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),35.80);
INSERT INTO consulta VALUES(19, 12,2,TO_DATE('06/03/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),97.64);
INSERT INTO consulta VALUES(20, 8,3,TO_DATE('04/05/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss'),54.15);

--receta
INSERT INTO receta VALUES(8,9);
INSERT INTO receta VALUES(3,15);
INSERT INTO receta VALUES(7,20);
INSERT INTO receta VALUES(1,10);
INSERT INTO receta VALUES(1,17);
INSERT INTO receta VALUES(6,12);
INSERT INTO receta VALUES(4,14);
INSERT INTO receta VALUES(8,19);
INSERT INTO receta VALUES(8,1);
INSERT INTO receta VALUES(4,11);
INSERT INTO receta VALUES(6,19);
INSERT INTO receta VALUES(5,5);
INSERT INTO receta VALUES(7,9);
INSERT INTO receta VALUES(6,6);
INSERT INTO receta VALUES(7,3);
INSERT INTO receta VALUES(7,7);
INSERT INTO receta VALUES(2,15);
INSERT INTO receta VALUES(9,1);
INSERT INTO receta VALUES(9,2);
INSERT INTO receta VALUES(7,14);
INSERT INTO receta VALUES(5,2);
INSERT INTO receta VALUES(9,3);
INSERT INTO receta VALUES(3,5);
INSERT INTO receta VALUES(2,12);
INSERT INTO receta VALUES(2,11);
INSERT INTO receta VALUES(1,20);
INSERT INTO receta VALUES(9,14);
INSERT INTO receta VALUES(2,8);
INSERT INTO receta VALUES(4,15);
INSERT INTO receta VALUES(2,6);



/*DROP TABLE receta;
DROP TABLE consulta;
DROP TABLE medicamento;
DROP TABLE medico;
DROP TABLE paciente;
DROP TABLE Cliente;
DROP TABLE raza;*/


