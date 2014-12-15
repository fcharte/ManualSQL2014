USE viajes;

SELECT ROUND(avg(Pasaje))"Tripulación media",sum(Pasaje)"Total ocupación"
FROM Viaje
WHERE fecha = '2025-02-10';

SELECT LugarLlegada,count(*)"Num. Países"
FROM Trayecto
GROUP BY LugarLlegada;

SELECT Pais,sum(TiempoTrayecto)"Horas de Viaje"
FROM Trayecto r,Viaje v
WHERE r.ID=v.ID
GROUP BY Pais;

SELECT TipoNave,sum(TiempoTrayecto)"Horas de Viaje"
FROM Trayecto r,Viaje v,Nave a
WHERE r.ID=v.ID and v.Inscripcion=a.Inscripcion
GROUP BY TipoNave
having sum(TiempoTrayecto)>=3;

SELECT distinct Inscripcion,fecha
FROM Viaje
WHERE Inscripcion<> 'A-1' and fecha in (SELECT fecha
                                FROM Viaje
                                WHERE Inscripcion='A-1');


SELECT TipoNave
FROM Nave N
WHERE 3<= (SELECT SUM(TiempoTrayecto)
           FROM Viaje V, Trayecto T
           WHERE V.ID = T.ID AND V.Inscripcion=N.Inscripcion);

SELECT distinct a1.TipoNave,a2.TipoNave
FROM Nave a1, Nave a2
WHERE a1.Inscripcion<a2.Inscripcion and
      (SELECT sum(TiempoTrayecto)
       FROM Trayecto r,Viaje v
       WHERE r.ID=v.ID and v.Inscripcion=a1.Inscripcion)=
      (SELECT sum(TiempoTrayecto)
       FROM Trayecto r,Viaje v
       WHERE r.ID=v.ID and v.Inscripcion=a2.Inscripcion);
