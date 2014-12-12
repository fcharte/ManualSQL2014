SET SERVEROUTPUT ON;

DECLARE 
 Contador INTEGER := 1;
 Maximo INTEGER; 
 Titulo libros.titulo%TYPE;
BEGIN
 SELECT MAX(codigo) INTO Maximo FROM libros;

 WHILE Contador <= Maximo

 LOOP
  SELECT titulo INTO Titulo FROM libros 
                 WHERE codigo=Contador;
  DBMS_OUTPUT.PUT_LINE(Titulo);
  Contador := Contador + 1;
 END LOOP;
END;
/
