DECLARE
 CURSOR CPrestamosSocio(Socio IN prestamos.nif%TYPE) IS
  SELECT * FROM prestamos
  WHERE nif=Socio;

 Fila prestamos%ROWTYPE;
BEGIN
  OPEN CPrestamosSocio('74381725T');

  LOOP
   FETCH CPrestamosSocio INTO Fila;
   EXIT WHEN CPrestamosSocio%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE(
     Fila.codigo || ' - ' || Fila.prestamo);
  END LOOP;

  CLOSE CPrestamosSocio;

END;
/