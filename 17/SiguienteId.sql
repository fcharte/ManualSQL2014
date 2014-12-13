﻿DELIMITER $$

CREATE TRIGGER IDPrestamo
  BEFORE INSERT ON prestamos
  FOR EACH ROW BEGIN

  SET NEW.id = (SELECT MAX(id) + 1
   FROM prestamos);

END $$

DELIMITER ;