SET SERVEROUTPUT ON;

DECLARE
 UnLibro libros.signatura%TYPE;
BEGIN
 SELECT signatura INTO UnLibro
   FROM Libros WHERE codigo=1;
 
 DBMS_OUTPUT.PUT_LINE(UnLibro);
END;
/
