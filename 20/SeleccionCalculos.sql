SELECT *
FROM Nave;

SELECT LugarSalida,LugarLlegada
FROM Trayecto;

SELECT distinct LugarSalida,LugarLlegada
FROM Trayecto;

use Viajes;

SELECT Pasaje,DATE_FORMAT(Fecha, '%d-%b-%Y') 'Fecha'
FROM Viaje
ORDER BY Fecha desc;

SELECT TipoNave,Tripulantes,Tripulantes*1.15"Aumento de tripulantes"
FROM Nave;

SELECT Pais
FROM Trayecto
WHERE LugarLlegada like 'NEPTUNO';

SELECT *
FROM Nave
WHERE UltimoViaje is null;

SELECT Viaje.*,LugarSalida,LugarLlegada
FROM Trayecto,Viaje
WHERE Trayecto.ID=Viaje.ID;

SELECT LugarSalida,LugarLlegada,r.Pais,Pasaje,Tripulantes
FROM Trayecto r,Viaje v,Nave a
WHERE r.ID=v.ID and v.Inscripcion=a.Inscripcion and
      a.Tripulantes=v.Pasaje;

SELECT r1.Pais,r2.Pais,r1.LugarLlegada
FROM Trayecto r1,Trayecto r2
WHERE r1.LugarLlegada=r2.LugarLlegada and
      r1.Pais<r2.Pais;

