USE biblioteca
GO

DROP FUNCTION LibrosPrestados
GO

CREATE FUNCTION LibrosPrestados(@fecha DATETIME)
RETURNS @LibrosPrestados TABLE (
  Signatura CHAR(9),
  Titulo VARCHAR(30),
  DiasPrestado INTEGER)
AS 
BEGIN

 INSERT @LibrosPrestados
  SELECT signatura,titulo,CAST(@fecha - prestamo AS INTEGER)
  FROM libros
  JOIN prestamos ON
   libros.codigo=prestamos.codigo
  WHERE disponible='N'

 RETURN
END
GO