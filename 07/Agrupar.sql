SELECT autor,COUNT(titulo) AS numtitulos
FROM libros
GROUP BY autor;

SELECT disponible,COUNT(disponible),
 MIN(codigo),MAX(codigo)
FROM libros
GROUP BY disponible;

SELECT SUBSTR(signatura,1,1),
 COUNT(SUBSTR(signatura,1,1))
FROM libros
GROUP BY SUBSTR(signatura,1,1);

SELECT CASE SUBSTR(signatura,1,1)
 WHEN 'G' THEN 'General'
 WHEN 'I' THEN 'Infantil'
 WHEN 'T' THEN 'Técnico'
END AS Categoria,
COUNT(SUBSTR(signatura,1,1)) AS NumTitulos
FROM libros
GROUP BY SUBSTR(signatura,1,1);

SELECT COUNT(*) AS NumSocios,
 MIN(alta) AS "Más antiguo",
 MAX(alta) AS "Más reciente"
FROM socios;

SELECT apellidos,nombre
FROM socios
WHERE alta = 
 (SELECT MIN(alta) FROM socios);

SELECT CASE SUBSTR(signatura,1,1)
 WHEN 'G' THEN 'General'
 WHEN 'I' THEN 'Infantil'
 WHEN 'T' THEN 'Técnico'
END AS Categoria,
COUNT(SUBSTR(signatura,1,1)) AS NumTitulos
FROM libros
WHERE disponible='S'
GROUP BY SUBSTR(signatura,1,1);

SELECT CASE SUBSTR(signatura,1,1)
 WHEN 'G' THEN 'General'
 WHEN 'I' THEN 'Infantil'
 WHEN 'T' THEN 'Técnico'
END AS Categoria,
COUNT(SUBSTR(signatura,1,1)) AS NumTitulos
FROM libros
WHERE disponible='S'
GROUP BY SUBSTR(signatura,1,1)
HAVING COUNT(SUBSTR(signatura,1,1))>1;

