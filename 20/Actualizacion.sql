
USE Viajes;

UPDATE Viaje
SET fecha=fecha+1
WHERE fecha='2025-05-10';

DELETE FROM Trayecto
WHERE ID=1;

UPDATE Trayecto
SET TiempoTrayecto=TiempoTrayecto+1
WHERE LugarLlegada like 'JUPITER';

INSERT INTO Viaje VALUES(1, 'E-5',  220, '2025-02-10');
INSERT INTO Viaje VALUES(1, 'B-2',  220, '2025-02-10');

INSERT INTO Viaje
(SELECT ID,Inscripcion,0,'2025-07-10'
 FROM Viaje
  WHERE fecha='2025-02-10');

UPDATE Viaje
SET Pasaje=(SELECT Tripulantes
               FROM Nave
               WHERE TipoNave='VOYAGER')
WHERE Inscripcion=(SELECT Inscripcion
           FROM Nave
           WHERE TipoNave='VOYAGER');

UPDATE Viaje v1
SET Pasaje=(SELECT Tripulantes
               FROM Nave
               WHERE Inscripcion=v1.Inscripcion);

SELECT * FROM Viaje;
SELECT * FROM Nave;

UPDATE Nave a1
SET UltimoViaje='2025-06-10'
WHERE 5<=(SELECT sum(TiempoTrayecto)
          FROM Viaje v,Trayecto r
          WHERE v.ID=r.ID and v.Inscripcion=a1.Inscripcion);

DELETE FROM Viaje
WHERE fecha > '2025-05-01' and
      fecha < (SELECT UltimoViaje
                FROM Nave
                WHERE Nave.Inscripcion=Viaje.Inscripcion);

