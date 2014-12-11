CREATE TRIGGER IDPrestamo
 ON prestamos INSTEAD OF INSERT 
AS
BEGIN
  DECLARE @Id INTEGER;
  SELECT @Id = MAX(id) + 1 FROM prestamos;
  INSERT INTO prestamos 
   SELECT @id, i.nif, i.codigo, i.prestamo 
    FROM inserted i;
END

