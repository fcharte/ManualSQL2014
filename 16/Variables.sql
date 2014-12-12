SET SERVEROUTPUT ON;

DECLARE
 NumLibros INTEGER;
 OtraVariable INTEGER;
BEGIN
 SELECT COUNT(*) 
  INTO NumLibros
  FROM libros;

 OtraVariable := NumLibros;

 DBMS_OUTPUT.PUT_LINE('Hay ' || OtraVariable || ' títulos');
END;
/
