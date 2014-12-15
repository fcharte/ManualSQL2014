SELECT * FROM Nave;

SELECT LugarSalida, LugarLlegada, TiempoTrayecto
FROM Trayecto;

SELECT Inscripcion, Pasaje, fecha
FROM Viaje
WHERE fecha BETWEEN '2025-05-01' AND '2025-05-31';
