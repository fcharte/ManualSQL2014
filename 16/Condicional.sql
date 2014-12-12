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
   DBMS_OUTPUT.PUT_LINE('La devolución lleva ' || 
     Dias || ' días de retraso');
 ELSE
  DBMS_OUTPUT.PUT_LINE('Aún no ha vencido la fecha de entrega');
 END IF;

END;
/
