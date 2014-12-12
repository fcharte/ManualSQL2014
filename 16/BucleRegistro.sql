SET SERVEROUTPUT ON;

BEGIN
 FOR Fila IN (SELECT signatura,titulo FROM libros)
  LOOP
    DBMS_OUTPUT.PUT_LINE(Fila.signatura || ' - ' || Fila.titulo);
  END LOOP;
END;
/
