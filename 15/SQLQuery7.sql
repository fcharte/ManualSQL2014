USE biblioteca

SELECT * FROM LibrosPrestados('2005-06-01')
SELECT Titulo,DiasPrestado FROM LibrosPrestados(CURRENT_TIMESTAMP)