SET SERVEROUTPUT ON;

DECLARE
 UnLibro libros%ROWTYPE;
BEGIN
 SELECT * INTO UnLibro
   FROM Libros WHERE codigo=1;
 
 DBMS_OUTPUT.PUT_LINE('El libro ' || UnLibro.signatura ||
  ' tiene el título "' || UnLibro.titulo ||
  '" y es del autor ' || UnLibro.autor);
END;
/
