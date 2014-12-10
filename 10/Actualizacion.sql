UPDATE libros
SET disponible='S'
WHERE codigo=10;

UPDATE socios
SET direccion='Las Flores, 12', cp='23021'
WHERE nif='63273827G';

UPDATE socios
SET direccion='Desconocida'
WHERE direccion IS NULL;

UPDATE prestamos
SET prestamo = prestamo + INTERVAL 15 DAY;

UPDATE libros
SET disponible='N'
WHERE codigo IN
  (SELECT codigo FROM prestamos);

DELETE FROM socios
WHERE EXTRACT(DAY FROM alta) = 07;

MERGE INTO libros
 USING prestamos
 ON (libros.codigo = prestamos.codigo)
 WHEN MATCHED THEN 
  UPDATE SET libros.disponible = 'N'
 WHEN NOT MATCHED THEN 
  INSERT (codigo, signatura, titulo)
  VALUES (prestamos.codigo, 'D ', 'No registrado');

