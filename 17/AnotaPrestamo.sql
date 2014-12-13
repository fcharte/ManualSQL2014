DELIMITER $$

DROP PROCEDURE IF EXISTS `biblioteca`.`AnotaPrestamo` $$
CREATE PROCEDURE `biblioteca`.`AnotaPrestamo` (
  IN p_id INT, IN p_codigolibro INT, IN p_nif VARCHAR(10))
BEGIN
  START TRANSACTION;

  INSERT INTO prestamos VALUES (
   p_id, p_nif, p_codigolibro, CURRENT_DATE);

  UPDATE libros
   SET disponible='N'
   WHERE codigo=p_codigolibro;

  COMMIT;
END $$

DELIMITER ;