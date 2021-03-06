USE biblioteca

IF (SELECT COUNT(signatura) FROM libros) > 10
  PRINT 'Hay más de una decena de títulos'
ELSE
  PRINT 'Hay menos de una decena de títulos'

DECLARE @Prestamo DATETIME

SELECT @Prestamo = prestamo FROM prestamos
 WHERE id=1
IF @Prestamo+7 < CURRENT_TIMESTAMP
 BEGIN
   DECLARE @Dias INTEGER
   SET @Dias = CAST(CURRENT_TIMESTAMP - (@Prestamo + 7) AS INTEGER)
   PRINT 'La devolución lleva ' +
     CAST(@Dias AS VARCHAR) + ' días de retraso'
 END
ELSE
 PRINT 'Aún no ha vencido la fecha de entrega'
