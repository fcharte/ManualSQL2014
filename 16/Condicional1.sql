SET SERVEROUTPUT ON;

DECLARE 
 NumTitulos INTEGER;
BEGIN

 SELECT COUNT(signatura) INTO NumTItulos FROM libros;

 IF NumTitulos > 10 THEN
   DBMS_OUTPUT.PUT_LINE('Hay más de una decena de títulos');
 ELSE
  DBMS_OUTPUT.PUT_LINE('Hay menos de una decena de títulos');
 END IF;

END;
/
