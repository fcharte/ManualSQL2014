INSERT INTO libros
VALUES (12,'G SHA inc','La incógnita Newton',
 'Shaw, Catherine','S');

INSERT INTO socios(nif,nombre,apellidos,alta)
VALUES ('63273827G','David','Charte Luque', CURRENT_DATE);

INSERT INTO socios
VALUES('87842837H','Irene','López García',
 NULL,NULL,CURRENT_DATE);

INSERT INTO socios
VALUES('87842837H','Irene','López García',
 DEFAULT,DEFAULT,CURRENT_DATE);

INSERT INTO disponibles
 SELECT signatura,titulo
 FROM libros
 WHERE disponible='S'

INSERT INTO libros VALUES(
 ((SELECT MAX(codigo) FROM libros)+1),
 'T CHA exc','Excel 2013','Charte, Francisco',
 'S');

INSERT INTO libros 
 SELECT MAX(codigo)+1, 'T CHA exc',
 'Excel 2013','Charte, Francisco', 'S'
 FROM libros;

INSERT INTO socios(nif,nombre,apellidos,alta)
 SELECT nif1 || nif2,nombre, apellido1 || ' ' || 
        apellido2, CURRENT_DATE
 FROM (
  SELECT '25856' as nif1,'Juan' AS nombre,'Lopez' as apellido1 
    FROM DUAL UNION
  SELECT '26323', 'Luis','Garcia' FROM DUAL UNION
  SELECT '27548', 'Rosa','Perez' FROM DUAL)
 CROSS JOIN (
  SELECT '837F' AS nif2,'Rayon' AS apellido2 
    FROM DUAL UNION
  SELECT '832H','Leon' FROM DUAL UNION
  SELECT '122E','Aguilera' FROM DUAL UNION
  SELECT '323T','Hilera' FROM DUAL );

INSERT INTO socios(nif,nombre,apellidos,alta)
SELECT nif1 + nif2,nombre, apellido1 + ' ' +
  apellido2,CURRENT_TIMESTAMP
 FROM (
  SELECT '25856' AS nif1,'Juan' AS nombre,'Lopez' AS apellido1 
UNION
  SELECT '26323', 'Luis','Garcia'  UNION
  SELECT '27548', 'Rosa','Perez' ) AS tabla1 
 CROSS JOIN (
  SELECT '837F' AS nif2,'Rayon' AS apellido2 UNION
  SELECT '832H','Leon' UNION
  SELECT '122E','Aguilera' UNION
  SELECT '323T','Hilera' ) AS tabla2 ;

