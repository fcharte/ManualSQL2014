USE biblioteca

DECLARE @signatura CHAR(9),
  @titulo VARCHAR(30),
  @prestamo DATETIME

DECLARE @LibrosPrestados TABLE (
  signatura CHAR(9),
  titulo VARCHAR(30),
  dias INTEGER)

DECLARE CursorLectura CURSOR SCROLL FOR
 SELECT signatura,titulo,prestamo
 FROM libros
 JOIN prestamos ON
  libros.codigo=prestamos.codigo
 WHERE disponible='N'

OPEN CursorLectura

IF @@CURSOR_ROWS = 0
BEGIN
  PRINT 'No hay libros prestados'
  GOTO Fin
END

FETCH NEXT FROM CursorLectura
 INTO @signatura,@titulo,@prestamo

WHILE @@FETCH_STATUS = 0
BEGIN
 INSERT INTO @LibrosPrestados VALUES (
  @signatura,@titulo,CAST(CURRENT_TIMESTAMP-@prestamo AS INTEGER))

 FETCH NEXT FROM CursorLectura
  INTO @signatura,@titulo,@prestamo
END

DEALLOCATE CursorLectura

Fin:

SELECT * FROM @LibrosPrestados