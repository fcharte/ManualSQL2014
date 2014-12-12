DECLARE @Contador INTEGER

SET @Contador = 1
WHILE @Contador !> 10
BEGIN
	PRINT @Contador
	SET @Contador = @Contador + 1
END