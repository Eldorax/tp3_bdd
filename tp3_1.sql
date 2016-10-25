drop table Reservations;
drop table Occupations;
drop table Chambres;
drop table Hotels;
drop table TypesChambre;
drop table Clients;

CREATE TABLE Hotels
(
  NumHo NUMERIC(10),
  NomHo VARCHAR(30),
  RueAdrHo VARCHAR(50),
  VilleHo VARCHAR(20),
  NbEtoilesHo NUMERIC(2),
  PRIMARY KEY (NumHo)
);

CREATE TABLE TypesChambre
(
  NumTy NUMERIC(10),
  NomTy VARCHAR(20),
  PrixTy NUMERIC(10),
  PRIMARY KEY (NumTy)
);

CREATE TABLE Chambres
(
  NumCh NUMERIC(10),
  NumHo NUMERIC(10) REFERENCES Hotels,
  NumTy NUMERIC(10) REFERENCES TypesChambre,
  PRIMARY KEY (NumCh, NumHo)
);

CREATE TABLE Clients
(
  NumCl NUMERIC(10),
  NomCl VARCHAR(20),
  PrenomCl VARCHAR(20),
  RueAdrCl VARCHAR(30),
  VilleCl VARCHAR(20),
  PRIMARY KEY (NumCl)
);

CREATE TABLE Reservations
(
  NumCl Numeric(10) REFERENCES Clients,
  NumHo Numeric(10) REFERENCES Hotels,
  NumTy Numeric(10) REFERENCES TypesChambre,
  DateA TIMESTAMP(0),
  NbJours INTERVAL DAY TO SECOND(0),
  NbChambres NUMERIC(2) DEFAULT 1 NOT NULL,
  PRIMARY KEY(NumCl, NumHo, NumTy, DateA)
);

CREATE TABLE Occupations
(
  NumCl NUMERIC(10) REFERENCES Clients,
  NumHo NUMERIC(10),
  NumCh NUMERIC(10),
  DateA TIMESTAMP(0),
  DateD TIMESTAMP(0),
  PRIMARY KEY (NumHo, NumCh, DateA),
  FOREIGN KEY (NumHo, NumCh) REFERENCES Chambres
);

INSERT INTO Hotels (NumHo, NomHo, RueAdrHo, VilleHo, NbEtoilesHo)
VALUES
  (0, 'Ibis', 'Chemin du vin', 'Bordeaux', 4);
  
INSERT INTO Hotels (NumHo, NomHo, RueAdrHo, VilleHo, NbEtoilesHo)
VALUES
  (1, 'Le touriste', 'avenue du pigeon', 'sollies pont', 0);

INSERT INTO Hotels (NumHo, NomHo, RueAdrHo, VilleHo, NbEtoilesHo)
VALUES
  (2, 'Les plages', 'avenue de la mer', 'Hyères', 3);
  
INSERT INTO Hotels (NumHo, NomHo, RueAdrHo, VilleHo, NbEtoilesHo)
VALUES
  (3, 'The Hills', 'route des montagnes', 'Gap', 2);
  
INSERT INTO TypesChambre
VALUES
  (0, 'Sale', 5);

INSERT INTO TypesChambre
VALUES
  (1, 'Petite', 20);
  
INSERT INTO TypesChambre
VALUES
  (2, 'Moyenne', 30);

INSERT INTO TypesChambre
VALUES
  (3, 'Grande', 50);
  
INSERT INTO Chambres
VALUES
  (0, 0, 1);
  
INSERT INTO Chambres
VALUES
  (1, 0, 2);
  
INSERT INTO Chambres
VALUES
  (2, 0, 2);
  
INSERT INTO Chambres
VALUES
  (3, 0, 3);
  
INSERT INTO Chambres
VALUES
  (0, 1, 0);
  
INSERT INTO Chambres
VALUES
  (1, 1, 0);
  
INSERT INTO Chambres
VALUES
  (2, 1, 1);
  
INSERT INTO Chambres
VALUES
  (3, 1, 1);
  
INSERT INTO Chambres
VALUES
  (0, 2, 1);
  
INSERT INTO Chambres
VALUES
  (1, 2, 2);
  
INSERT INTO Chambres
VALUES
  (2, 2, 3);
  
INSERT INTO Chambres
VALUES
  (3, 2, 3);
  
INSERT INTO Chambres
VALUES
  (0, 3, 3);
  
INSERT INTO Chambres
VALUES
  (1, 3, 3);
  
INSERT INTO Chambres
VALUES
  (2, 3, 3);
  
INSERT INTO Chambres
VALUES
  (3, 3, 3);
  
INSERT INTO Clients
VALUES
 (0, 'Blanc', 'Jean', 'Avenue des lilas', 'Toulon');
 
INSERT INTO Clients
VALUES
 (1, 'Grenet', 'Maxime', 'Avenue du chiant', 'Toulouse');
 
INSERT INTO Clients
VALUES
 (2, 'Pelletier', 'Seb', 'Chemin de la panthére', 'Cuers');
 
INSERT INTO Clients
VALUES
 (3, 'Boudermine', 'Antoine', 'avenue du bord de mer', 'Lille');
 
INSERT INTO Clients
VALUES
 (4, 'Andreini', 'Thomas', 'Lotissement les arbres', 'Sollies Pont');
 
INSERT INTO Reservations
VALUES
  (0, 0, 1, TIMESTAMP '2016-05-06 12:12:12', INTERVAL '1' DAY, 1);
  
INSERT INTO Reservations
VALUES
  (0, 1, 1, TIMESTAMP '2016-06-06 12:12:12', INTERVAL '1' DAY, 1);
  
INSERT INTO Reservations
VALUES
  (1, 1, 1, TIMESTAMP '2016-06-06 12:12:12', INTERVAL '1' DAY, 1);
  
  INSERT INTO Reservations
VALUES
  (2, 1, 1, TIMESTAMP '2016-06-06 12:12:12', INTERVAL '1' DAY, 1);
  
INSERT INTO Occupations
VALUES
  (0, 0, 1, TIMESTAMP '2016-06-06 12:12:12', TIMESTAMP '2016-07-06 12:12:12');
  
  INSERT INTO Occupations
VALUES
  (0, 1, 1, TIMESTAMP '2016-06-06 12:12:12', TIMESTAMP '2016-07-06 12:12:12');
  
/*  
  INSERT INTO Occupations
VALUES
  (1, 1, 1, TIMESTAMP '2016-06-06 12:12:12', TIMESTAMP '2016-07-06 12:12:12');
 /
  INSERT INTO Occupations
VALUES
  (2, 1, 1, TIMESTAMP '2016-06-06 12:12:12', TIMESTAMP '2016-07-06 12:12:12');*/
  
  --1.Mise en evidence du traitement des ecritures sales
  
commit;
  
UPDATE Hotels
SET NbEtoilesHo = NbEtoilesHo + 1
WHERE NumHo = 1;
  
-- On constate que l'instruction de la session 2 qui porte sur le meme hotel
--de la session 1 ne marche pas alors que l'autre fonctionne.

UPDATE Hotels
SET NbEtoilesHo = NbEtoilesHo + 1
WHERE NumHo = 0;

--On constate que l'instruction de la premiere session qui porte 
--sur l'hotel modifié dans la session deux ne marche pas.

--Lors de l'execution du commit dans la session deux, ceci a débloqué l'instruction executé
--dans la session 1. On en conclu donc que lors d'une mise a jour d'une ligne de table
--oracle pose un verrou sur la ligne concernée.

--2.Mise en évidence des lectures sales

commit;

UPDATE Hotels
SET NbEtoilesHo = NbEtoilesHo + 1
WHERE NumHo = 1;

Select NbEtoilesHo
from Hotels
where NumHo = 1;

--On constate que le nombre d'étoiles affiché dans
--la deuxiéme session ne tient pas compte de la maj de la session 1

--On constate qu'aprés l'execution du commit dans la session 1
--la session deux affiche la valeur modifié par la session 1.

--On peut en conclure que la gestion des lectures sales n'est
--pas géré par des verrous court.
  
  
--3.Mise en évidence des lectures non reproductible.

commit;

Select NbEtoilesHo
from Hotels
where NumHo = 1;

--On constate que les deux instructions select de la session 1
--n'ont pas affiché la meme ligne a cause de la modification de
--la session deux.
--On peut en conclure que oracle ne gére pas les lectures non
--reproductible.

--4.Mise en evidence du phénomène des lignes fantômes.

commit;

Set TRANSACTION READ ONLY;

Select count(*) as compte
From Hotels
Where VilleHo = 'Marseille';

--On constate que les lignes affichés par la session 1 a changé
--entre les deux instructions. On remarque qu'il s'agit du meme 
--principe que les lectures non reproductibles mais sur un
--ensemble de lignes.

--L'instruction "Set transaction read only" permet de trvailler
--sur un "snapshot" de la bd. Cela évite les lectures non reproductibles
--et les lignes fantômes.

--5.Mise en évidence du phénomène des mises à jour perdues

Select NbEtoilesHo
from Hotels
where NumHo = 1;
  