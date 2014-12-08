SELECT titulo, disponible
FROM libros;

SELECT apellidos, nombre, cp AS CodPostal
FROM socios;

SELECT socios.nif,socios.apellidos,prestamos.codigo, prestamos.prestamo
FROM socios,prestamos;

SELECT s.nif,s.apellidos,p.codigo,p.prestamo
FROM socios s,prestamos p;

SELECT DISTINCT autor FROM libros;