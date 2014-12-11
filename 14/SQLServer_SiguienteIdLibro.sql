CREATE FUNCTION SiguienteIdLibro()
 RETURNS INTEGER AS
BEGIN
  DECLARE @UltimoCodigo INTEGER
  SELECT @UltimoCodigo=MAX(codigo) FROM libros;
  RETURN (@UltimoCodigo + 1);
END

