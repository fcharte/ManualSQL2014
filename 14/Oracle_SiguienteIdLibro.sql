CREATE OR REPLACE FUNCTION SiguienteIdLibro
 RETURN NUMBER AS
UltimoCodigo NUMBER;
BEGIN
  SELECT MAX(codigo) INTO UltimoCodigo FROM libros;
  RETURN UltimoCodigo + 1;
END;
/
