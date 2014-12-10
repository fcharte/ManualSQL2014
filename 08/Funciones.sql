SELECT CURRENT_TIMESTAMP,signatura
FROM libros;

SELECT CURRENT_TIMESTAMP
FROM dual;


SELECT USER AS Usuario,
 SYS_CONTEXT('USERENV','SESSION_USER') 
   AS Sesion,
 SYS_CONTEXT('USERENV','OS_USER') AS Sistema
FROM dual;

SELECT CURRENTUSER,DATE(),TIME(),NOW();

SELECT signatura, LENGTH(titulo) AS Longitud,
  (SELECT AVG(LENGTH(titulo)) FROM libros) 
     AS Media,
  LENGTH(titulo) - (SELECT AVG(LENGTH(titulo))  
     FROM libros) AS Diferencia
 FROM libros;

SELECT TRIM(LEADING FROM '  Cadena  ') 
FROM dual;

SELECT TRIM(TRAILING FROM '  Cadena  ')
FROM dual;

SELECT TRIM('*' FROM '***1,500**')
FROM dual;

SELECT LOWER(signatura),UPPER(titulo)
FROM libros;

SELECT signatura,titulo
FROM libros
WHERE INSTR(titulo,'de') <> 0;

SELECT nif,alta,EXTRACT(YEAR FROM alta)
FROM socios;

SELECT EXTRACT(YEAR FROM alta) AS "Año",
 COUNT(*) As NumAltas
FROM socios
GROUP BY EXTRACT(YEAR FROM alta);

SELECT AVG(LENGTH(autor))
FROM libros;

SELECT FLOOR(AVG(LENGTH(autor)))
FROM libros;

SELECT CEIL(AVG(LENGTH(autor)))
FROM libros;

SELECT POWER(2,8),SQRT(256),POWER(64,1/3)
FROM dual;

SELECT 17/2,MOD(17,2) FROM dual;

SELECT EXP(4),LN(54.6) FROM dual;

SELECT signatura,
  COALESCE(disponible,'Indeterminado') AS Disp
FROM libros;

SELECT signatura,
  COALESCE(disponible,'Indeterminado') AS Disp
FROM libros;

SELECT titulo,NULLIF(disponible,'N') AS Disp
FROM libros;
