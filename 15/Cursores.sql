USE biblioteca

DECLARE @signatura CHAR(9), @titulo VARCHAR(30)

DECLARE CursorLibros CURSOR SCROLL FOR
 SELECT signatura,titulo
 FROM libros

OPEN CursorLibros

IF CURSOR_STATUS('global','CursorLibros') = 1
 BEGIN
  FETCH NEXT FROM CursorLibros
   INTO @signatura, @titulo
  WHILE @@FETCH_STATUS = 0
   BEGIN
     PRINT 'El libro ' + @signatura + ' es "' + @titulo + '"'
     FETCH NEXT FROM CursorLibros
      INTO @signatura, @titulo
   END
 END
ELSE
  SELECT CURSOR_STATUS('global','CursorLibros')

DEALLOCATE CursorLibros