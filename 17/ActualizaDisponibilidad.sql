DELIMITER GO

CREATE PROCEDURE ActualizaDisponibilidad()
BEGIN
 UPDATE libros
  SET disponible = 'N'
  WHERE codigo IN (
   SELECT codigo FROM prestamos);
END 
GO

DELIMITER ;
