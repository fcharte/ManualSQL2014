CREATE TABLE cuenta (
  IBAN VARCHAR(20) PRIMARY KEY,
  saldo NUMBER(9,2) NOT NULL,
  CONSTRAINT saldominimo CHECK (saldo >= 0)  INITIALLY DEFERRED
);

CREATE TABLE movimiento (
  ID INTEGER PRIMARY KEY,
  origen VARCHAR(20),
  destino VARCHAR(20),
  importe NUMBER(9,2) NOT NULL,
  CONSTRAINT FK_origen FOREIGN KEY (origen)
     REFERENCES cuenta(IBAN),
  CONSTRAINT FK_destino FOREIGN KEY (destino)
     REFERENCES cuenta(IBAN)
);

INSERT INTO cuenta VALUES
 (1, 100);
INSERT INTO cuenta VALUES
 (2, 50);
INSERT INTO cuenta VALUES
 (3, 75);

COMMIT;
UPDATE cuenta 
 SET saldo = saldo - 75
 WHERE IBAN = 2;

UPDATE cuenta
 SET saldo = saldo - 50
 WHERE IBAN = 1;

UPDATE cuenta
 SET saldo = saldo + 75
 WHERE IBAN = 3;

UPDATE cuenta
 SET saldo = saldo + 50
 WHERE IBAN = 2;
COMMIT;
