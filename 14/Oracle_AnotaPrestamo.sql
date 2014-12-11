CREATE OR REPLACE PROCEDURE AnotaPrestamo
 (p_id IN NUMBER, p_codigolibro IN NUMBER, p_nif IN VARCHAR2) AS
BEGIN
  INSERT INTO prestamos VALUES (
   p_id, p_nif, p_codigolibro,
   CURRENT_DATE);

  UPDATE libros 
   SET disponible='N'
   WHERE codigo=p_codigolibro;

  COMMIT;
END;
/
