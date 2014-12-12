SET SERVEROUTPUT ON;

DECLARE 
 CURSOR CPrestamosSocio(Socio IN prestamos.nif%TYPE) IS
  SELECT * FROM prestamos
  WHERE nif=Socio;

BEGIN
  DBMS_OUTPUT.PUT_LINE('El cursor tiene ' ||
    DBMS_SQL.LAST_ROW_COUNT || ' filas');

  OPEN CPrestamosSocio('74381725T');

  IF CPrestamosSocio%ISOPEN THEN
    DBMS_OUTPUT.PUT_LINE('El cursor está abierto');
    CLOSE CPrestamosSocio;
  ELSE
    DBMS_OUTPUT.PUT_LINE('No se ha podido abrir el cursor');
  END IF;


END;
/

