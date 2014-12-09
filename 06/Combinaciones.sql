SELECT socios.nif,apellidos,prestamo
FROM socios
INNER JOIN prestamos 
 ON socios.nif=prestamos.nif;

SELECT socios.nif,apellidos,prestamo
FROM socios,prestamos
WHERE socios.nif=prestamos.nif;

SELECT apellidos,nombre,titulo,prestamo
FROM socios
INNER JOIN prestamos
 INNER JOIN libros
  ON libros.codigo = prestamos.codigo
 ON socios.nif = prestamos.nif;

SELECT apellidos,prestamo
FROM socios
LEFT OUTER JOIN prestamos
 ON socios.nif = prestamos.nif;

SELECT apellidos,titulo,prestamo
FROM socios
 LEFT OUTER JOIN prestamos
  RIGHT OUTER JOIN libros
   ON libros.codigo = prestamos.codigo
  ON socios.nif = prestamos.nif;

SELECT apellidos,titulo,prestamo
FROM socios 
RIGHT OUTER JOIN prestamos
 RIGHT OUTER JOIN libros
  ON libros.codigo = prestamos.codigo
 ON socios.nif = prestamos.nif;

SELECT apellidos,titulo
FROM socios
CROSS JOIN libros;

SELECT s1.apellidos,s1.nombre,s1.cp
FROM socios s1
INNER JOIN socios s2
 ON s1.cp=s2.cp AND s1.nif<>s2.nif;

SELECT apellidos,titulo,prestamo
FROM socios
NATURAL JOIN prestamos
 NATURAL JOIN libros;




CREATE TABLE A (
  ID INTEGER,
  Fab VARCHAR(40),
  CONSTRAINT PK_A PRIMARY KEY (ID)
);

CREATE TABLE B (
  ID INTEGER,
  Mod VARCHAR(40),
  CONSTRAINT PK_B PRIMARY KEY (ID)
);

INSERT INTO A VALUES
 (1, 'Sinclair'), (2, 'Amstrad'), (3, 'Atari'),
 (4, 'Commodore'), (5, 'Dragon');

INSERT INTO B VALUES
 (1, 'ZX-81'), (2, 'CPC-464'), (5, '200'),
 (6, 'Atmos'), (7, 'QL');

SELECT * FROM A INNER JOIN B ON A.ID=B.ID;
SELECT * FROM A LEFT OUTER JOIN B ON A.ID=B.ID;
SELECT * FROM A RIGHT OUTER JOIN B ON A.ID=B.ID;
SELECT * FROM A FULL OUTER JOIN B ON A.ID=B.ID;
SELECT * FROM A CROSS JOIN B;