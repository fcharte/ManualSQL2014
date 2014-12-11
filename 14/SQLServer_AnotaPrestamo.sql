CREATE PROCEDURE AnotaPrestamo
 @p_id INTEGER, @p_codigolibro INTEGER, @p_nif CHAR(9) 
AS
BEGIN
  BEGIN TRANSACTION;

  INSERT INTO prestamos VALUES (
   @p_id, @p_nif, @p_codigolibro,
   CURRENT_TIMESTAMP);

  UPDATE libros 
   SET disponible='N'
   WHERE codigo=@p_codigolibro;

  COMMIT;
END;
