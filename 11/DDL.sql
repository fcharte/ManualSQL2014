CREATE TABLE prestamos2 (
  nif CHAR(9),
  codigo INTEGER,
  prestamo DATE,
  CONSTRAINT PK_prestamo 
   PRIMARY KEY (nif,codigo)
);

CREATE TABLE socios (
  nif CHAR(9) PRIMARY KEY,
  nombre VARCHAR(15) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  direccion VARCHAR(30),
  cp CHAR(5),
  alta DATE NOT NULL
);

CREATE TABLE libros (
  codigo INTEGER PRIMARY KEY,
  signatura CHAR(10) UNIQUE NOT NULL,
  titulo VARCHAR(40) NOT NULL,
  autor VARCHAR(40) NOT NULL,
  disponible CHAR(1) NOT NULL
);

CREATE TABLE prestamos (
  id INTEGER PRIMARY KEY,
  nif CHAR(9) REFERENCES socios(nif),
  codigo INTEGER REFERENCES libros(codigo),
  prestamo DATE NOT NULL
);

CREATE TABLE prestamos (
  id INTEGER PRIMARY KEY,
  nif CHAR(9),
  codigo INTEGER,
  prestamo DATE NOT NULL,
  CONSTRAINT FK_socios FOREIGN KEY(nif)
   REFERENCES socios(nif),
  CONSTRAINT FK_libros FOREIGN KEY(codigo)
   REFERENCES libros(codigo)
);

CREATE TABLE prestamos2 (
  id INTEGER PRIMARY KEY,
  nif CHAR(9),
  codigo INTEGER,
  prestamo DATE NOT NULL,
  CONSTRAINT FK_socios FOREIGN KEY(nif)
   REFERENCES socios(nif) 
   ON DELETE CASCADE,
  CONSTRAINT FK_libros FOREIGN KEY(codigo)
   REFERENCES libros(codigo)
);

CREATE TABLE libros (
  codigo INTEGER PRIMARY KEY,
  signatura CHAR(10) UNIQUE NOT NULL,
  titulo VARCHAR(40) NOT NULL,
  autor VARCHAR(40) NOT NULL,
  disponible CHAR(1) NOT NULL,
  CONSTRAINT disponible_SN CHECK
    (disponible='S' OR disponible='N')
);

CREATE TABLE prestamos2 (
  id INTEGER PRIMARY KEY,
  nif CHAR(9) REFERENCES socios(nif),
  codigo INTEGER REFERENCES libros(codigo),
  prestamo DATE DEFAULT CURRENT_DATE NOT NULL
);

ALTER TABLE libros2
 ADD COLUMN disponible CHAR(1)
  DEFAULT 'S' NOT NULL

ALTER TABLE libros2
 MODIFY disponible DEFAULT 'S'

CREATE TEMPORARY TABLE prestados (
  signatura CHAR(10),
  prestamo DATE
);

CREATE TABLE #prestados (
  signatura VARCHAR(10),
  prestamo DATETIME
);

CREATE TABLE barcos (
     fila CHAR(1) NOT NULL,
     columna SMALLINT NOT NULL,
     celda CHAR(2) AS (CONCAT(fila, SUBSTR(columna,1,1)))
);

CREATE TABLE barcos (
     fila CHAR(1) NOT NULL,
     columna SMALLINT NOT NULL,
     celda AS (fila + CONVERT(CHAR(1),columna))
);
