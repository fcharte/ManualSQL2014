SET SERVEROUTPUT ON;

DECLARE 
 NumTitulos INTEGER;
BEGIN

 SELECT COUNT(signatura) INTO NumTItulos FROM libros;

 IF NumTitulos > 10 THEN
   DBMS_OUTPUT.PUT_LINE('Hay m�s de una decena de t�tulos');
 ELSE
  DBMS_OUTPUT.PUT_LINE('Hay menos de una decena de t�tulos');
 END IF;

END;
/
