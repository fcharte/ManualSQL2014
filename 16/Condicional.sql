SET SERVEROUTPUT ON;

DECLARE 
 FechaPrestamo DATE;
 Dias INTEGER;
BEGIN

 SELECT prestamo INTO FechaPrestamo
   FROM prestamos
   WHERE id=1;

 IF FechaPrestamo+7 < CURRENT_DATE THEN
   Dias := CURRENT_DATE - (FechaPrestamo + 7);
   DBMS_OUTPUT.PUT_LINE('La devoluci�n lleva ' || 
     Dias || ' d�as de retraso');
 ELSE
  DBMS_OUTPUT.PUT_LINE('A�n no ha vencido la fecha de entrega');
 END IF;

END;
/
