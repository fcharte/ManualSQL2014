use Viajes;

INSERT INTO Trayecto VALUES(1,'USA','TIERRA','MARTE',3);
INSERT INTO Trayecto VALUES(2,'USA','TIERRA','JUPITER',1);
INSERT INTO Trayecto VALUES(3,'ESP','TIERRA','NEPTUNO',1);
INSERT INTO Trayecto VALUES(4,'CHN','TIERRA','NEPTUNO',1);

INSERT INTO Nave VALUES('A-1','VOYAGER',200,'2025-06-10');
INSERT INTO Nave VALUES('B-2','PIONNER',280,null);
INSERT INTO Nave VALUES('C-3','CASSINI',300,null);
INSERT INTO Nave VALUES('D-4','GALACTUS',250,'2005-02-10');


INSERT INTO Viaje VALUES(1,'B-2',250,'2025-02-10');
INSERT INTO Viaje VALUES(2,'C-3',200,'2025-02-10');
INSERT INTO Viaje VALUES(3,'A-1',200,'2025-02-10');
INSERT INTO Viaje VALUES(4,'D-4',250,'2025-02-10');
INSERT INTO Viaje VALUES(3,'A-1',100,'2025-05-10');
INSERT INTO Viaje VALUES(4,'D-4',150,'2025-05-10');
INSERT INTO Viaje VALUES(3,'A-1',50,'2025-06-10');
INSERT INTO Viaje VALUES(4,'D-4',75,'2025-06-10');
