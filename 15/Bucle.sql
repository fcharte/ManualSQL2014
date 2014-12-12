USE biblioteca

DECLARE @Contador INTEGER
DECLARE @Titulo VARCHAR(30)

SET @Contador = 1
WHILE EXISTS(SELECT * FROM libros WHERE codigo=@Contador)
BEGIN
  SELECT @Titulo = titulo FROM libros WHERE codigo=@Contador
  PRINT @Titulo
  SET @Contador = @Contador + 1
END