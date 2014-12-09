SELECT nif FROM socios
UNION
SELECT nif FROM prestamos;

SELECT nif FROM socios
UNION ALL
SELECT nif FROM prestamos;

SELECT nif,alta 
FROM socios
UNION
SELECT nif,prestamo
FROM prestamos;

SELECT nif,apellidos
FROM socios
UNION
SELECT nif,CAST(prestamo AS CHAR(10))
FROM prestamos;

SELECT nif FROM socios
INTERSECT
SELECT nif FROM prestamos;

SELECT apellidos,nombre
FROM socios
WHERE nif IN(
 SELECT nif FROM socios
 INTERSECT
 SELECT nif FROM prestamos
);

SELECT nif FROM socios
MINUS
SELECT nif FROM prestamos;

SELECT 'Libro ' || titulo || 
       ' con signatura ' || signatura ||
       ' prestado a ' || nombre || ' ' || apellidos 
FROM libros, socios;
