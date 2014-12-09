CREATE VIEW socios_prestamo AS
 SELECT apellidos,nombre,prestamo
 FROM socios
 INNER JOIN prestamos
  ON prestamos.nif=socios.nif;

SELECT * FROM socios_prestamo;