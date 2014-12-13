DELIMITER GO

DROP FUNCTION IF EXISTS `biblioteca`.`SiguienteIdLibro`
GO
CREATE FUNCTION `biblioteca`.`SiguienteIdLibro` ()
RETURNS INT
BEGIN
DECLARE siguiente INT;

  SELECT MAX(codigo) INTO siguiente
   FROM libros;
  RETURN siguiente + 1;

END
GO

DELIMITER ;