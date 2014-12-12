SET SERVEROUTPUT ON;

DECLARE 
 NumFilas INTEGER;
BEGIN
 SELECT COUNT(*) INTO NumFilas FROM prestamos;

 IF NumFilas = 0 THEN
   GOTO Fin;
 END IF;

 DBMS_OUTPUT.PUT_LINE('Hay libros sin devolver');

<<Fin>>
 NULL; 

END;
/
