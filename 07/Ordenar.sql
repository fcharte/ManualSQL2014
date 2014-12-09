SELECT *
FROM libros
ORDER BY autor,titulo;

SELECT titulo
FROM libros
ORDER BY signatura;

SELECT SUBSTR(signatura,1,5) AS signa, titulo
FROM libros
ORDER BY signa

SELECT substr(signatura,1,5) as signa,titulo
FROM libros
ORDER BY 1,titulo;

