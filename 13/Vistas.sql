CREATE VIEW DatosSocios
 AS SELECT apellidos,nombre,nif
 FROM socios;

CREATE VIEW LibrosDisponibles
 AS SELECT codigo,titulo
 FROM libros
 WHERE disponible='S';

SELECT *
 FROM LibrosDisponibles
 WHERE codigo=7;

SELECT *
 FROM LibrosDisponibles
 WHERE titulo LIKE 'El %';

CREATE VIEW LibrosAutor(autor,numtitulos)
 AS SELECT autor,COUNT(titulo)
 FROM libros
 GROUP BY autor
 ORDER BY autor;

CREATE VIEW Devoluciones AS
 SELECT apellidos,nombre,titulo,prestamo+15 AS entrega
 FROM socios
 INNER JOIN prestamos  ON socios.nif=prestamos.nif
 INNER JOIN libros     ON prestamos.codigo=libros.codigo;

INSERT INTO DatosSocios VALUES (
 'Pérez Martínez', 'María', '73898372E');

CREATE VIEW LibrosDisponibles
 AS SELECT codigo,titulo,disponible
 FROM libros
 WHERE disponible='S';

UPDATE LibrosDisponibles
 SET disponible='N'
 WHERE codigo = 6;

