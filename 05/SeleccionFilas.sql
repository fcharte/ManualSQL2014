SELECT codigo,titulo
FROM libros
WHERE disponible='S';

SELECT codigo,titulo
FROM libros
WHERE disponible='S' 
 AND autor='Charte, Francisco';

SELECT codigo,titulo
FROM libros
WHERE disponible='S'
 AND NOT autor='Charte, Francisco';

SELECT signatura,titulo
FROM libros
WHERE signatura LIKE 'T CHA%';

SELECT signatura,titulo
FROM libros
WHERE titulo LIKE '%de%';

SELECT apellidos,cp
FROM socios
WHERE cp LIKE '230_1';

SELECT apellidos,nombre
FROM socios
WHERE alta BETWEEN DATE '2003-01-01' 
 AND DATE '2003-12-31';

SELECT apellidos,nombre,cp
FROM socios
WHERE cp IN ('23001','23005','23008');

SELECT signatura,titulo
FROM libros
WHERE disponible IS NULL;

SELECT signatura,titulo
FROM libros
WHERE codigo IN
 (SELECT codigo FROM prestamos);
