USE biblioteca

DECLARE @NumLibros INTEGER 
SELECT @NumLibros = COUNT(signatura) FROM libros

DECLARE @OtraVariable INTEGER
SET @OtraVariable = @NumLibros

PRINT 'Hay ' + CAST(@OtraVariable AS VARCHAR) + ' títulos'
