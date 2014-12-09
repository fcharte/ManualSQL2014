SELECT titulo,'Disponible' AS Disponible
FROM libros 
WHERE disponible='S';

SELECT nif,prestamo,CURRENT_DATE
FROM prestamos;

SELECT codigo,codigo+1000,codigo/2 
FROM libros;

SELECT signatura,titulo 
FROM libros 
WHERE SUBSTR(signatura,1,1)='I';

SELECT apellidos,nombre,
CAST(CURRENT_DATE - alta AS INTEGER) 
 AS Antiguedad
FROM socios;

SELECT signatura,titulo,
 CASE disponible
  WHEN 'S' THEN 'sí'
  WHEN 'N' THEN 'no'
 END AS Disponible
FROM libros;
