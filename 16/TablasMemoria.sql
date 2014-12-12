DECLARE
 CURSOR CursorLectura IS
  SELECT signatura,titulo,prestamo 
  FROM libros
  JOIN prestamos ON
   libros.codigo=prestamos.codigo
  WHERE disponible='N';

 Fila CursorLectura%ROWTYPE;

 TYPE TablaLibrosPrestados
  IS TABLE OF CursorLectura%ROWTYPE
  INDEX BY BINARY_INTEGER;

 LibrosPrestados TablaLibrosPrestados;
 Indice PLS_INTEGER;

BEGIN
  OPEN CursorLectura;

  LOOP
   FETCH CursorLectura INTO Fila;
   EXIT WHEN CursorLectura%NOTFOUND;
   Indice := NVL(LibrosPrestados.LAST,0) + 1;
   LibrosPrestados(Indice) := Fila;   
  END LOOP;

  CLOSE CursorLectura;

  DBMS_OUTPUT.PUT_LINE('Hay ' ||
   LibrosPrestados.COUNT || ' filas en la tabla');

  Indice := LibrosPrestados.FIRST;

  LOOP
    EXIT WHEN Indice IS NULL;
    DBMS_OUTPUT.PUT_LINE(
     LibrosPrestados(Indice).signatura || ' - ' ||
     LibrosPrestados(Indice).titulo || ' - ' ||
     LibrosPrestados(Indice).prestamo);
    Indice := LibrosPrestados.NEXT(Indice);
  END LOOP;
END;
/