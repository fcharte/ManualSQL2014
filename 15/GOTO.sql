USE biblioteca

DECLARE @NumFilas INTEGER

SELECT @NumFilas = COUNT(*) FROM prestamos
IF @NumFilas = 0
  GOTO Fin
PRINT 'Hay libros sin devolver'
Fin: