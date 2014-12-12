USE Biblioteca;

DROP TABLE libros;
DROP TABLE socios;
DROP TABLE prestamos;

CREATE TABLE libros (
  codigo INTEGER NOT NULL,
  signatura CHAR(10) NOT NULL,
  titulo VARCHAR(40),
  autor VARCHAR(40),
  disponible CHAR(1),
  CONSTRAINT PK_libros PRIMARY KEY (codigo)
);

CREATE TABLE socios (
  nif CHAR(9) NOT NULL,
  nombre VARCHAR(15) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  direccion VARCHAR(30),
  cp CHAR(5),
  alta DATETIME NOT NULL,
  CONSTRAINT PK_socios PRIMARY KEY (nif)
);

CREATE TABLE prestamos (
  id INTEGER NOT NULL,
  nif CHAR(9) NOT NULL,
  codigo INTEGER NOT NULL,
  prestamo DATETIME NOT NULL,
  CONSTRAINT PK_prestamos PRIMARY KEY (id)
);

INSERT INTO libros VALUES(
  1, 'I PIL cap', 'El capit�n calzoncillos', 'Pilkey, Dav', 'S');
INSERT INTO libros VALUES(
  2, 'I MAS mis', 'El misterio del perro secuestrado', 'Masters, M.', 'S');
INSERT INTO libros VALUES(
  3, 'I LI sec', 'El secreto de los piratas', 'Li', 'S');
INSERT INTO libros VALUES(
  4, 'I DIE mia', 'Mi amigo agapito', 'D�ez Barrio, Germ�n', 'N');
INSERT INTO libros VALUES(
  5, 'I FAR unt', 'Un tiesto lleno de l�pices', 'Farias, Juan', 'S');
INSERT INTO libros VALUES(
  6, 'T CHA sse', 'SQL Server 2012', 'Charte, Francisco', 'S');
INSERT INTO libros VALUES(
  7, 'T CHA php', 'Access 2013', 'Charte, Francisco', 'N');
INSERT INTO libros VALUES(
  8, 'T CHA htm', 'Windows 8 Registro y configuraci�n', 'Charte, Francisco', 'S');
INSERT INTO libros VALUES(
  9, 'G ESL uni', 'En busca del unicornio', 'Eslava Gal�n, Juan', 'S');
INSERT INTO libros VALUES(
  10, 'G MUN ven', 'Ventanas de Nueva York', 'Mu�oz Molina, Antonio', 'N');
INSERT INTO libros(codigo,signatura,titulo,autor) VALUES(
  11, 'G BAL cli', 'Cuentos libertinos', 'Balzak, H.');


INSERT INTO socios VALUES(
  '62877137F', 'Alejandro', 'Charte Luque', 'Las Flores, 12', '23021',  '2002-18-04');
INSERT INTO socios VALUES(
  '23727319S', 'Bel�n', 'Arcos Trera', 'Betania, 7', '23001',  '2003-02-08');
INSERT INTO socios VALUES(
  '43229482E', 'Antonio', 'Moreno Pardo', 'Juan Rinc�n, 2', '23008',  '2003-28-10');
INSERT INTO socios VALUES(
  '74381725T', 'Francisco', 'Charte Ojeda', 'Las Flores, 12', '23021',  '2005-06-09');

INSERT INTO prestamos VALUES(1, '62877137F', 4,  '2005-07-02');
INSERT INTO prestamos VALUES(2, '23727319S', 7,  '2005-07-03');
INSERT INTO prestamos VALUES(3, '74381725T', 10,  '2005-07-05');
