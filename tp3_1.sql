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

commit;


Select NbEtoilesHo
from Hotels
where NumHo = 1; --15
  
set transaction isolation level serializable;
declare Nb Integer;
begin
  select nbetoilesho into Nb from hotels where numho = 1;
  update hotels set nbetoilesho = Nb + 1 where numho = 1;
end;
/
-- Ici, la session un lit le nombre d'étoile puis l'incrémente de 1
-- tant que le commit n'a pas été fait, tout autre transaction peu
-- lire la variable non modifier par la session 1. Ainsi, la session
-- deux vas incrémenter le nombre d'étoile à partir de l'ancienne valeur.
-- Les deux transactions modifient la variable pour lui donner la meme valeur.

-- En ajoutant la ligne "set trans .. serializable" les instruction
-- PLP de la session deux ne fonctionne plus car les deux transaction
-- ne sont pas serialisable.

-- 6 - retour sur le phénomène fantomes
commit;

select * from Hotels;

set transaction isolation level serializable;
update Hotels set NbEtoilesHo = 3 where NbEtoilesHo = 1;

/*
select 
 from Hotels;*/

-- L'execution de cet "update" dans les deux sessions a pour effet
-- d'echanger les valeurs de nbetoilesho. Ceci est du au faite de
-- SQL cree des snapshots pour les transactions.
-- Lexecution de l'update dans la session deux à pour effet d'ajouter
-- des lignes repondant à la clause where de l'update de la session 1.
--
-- L'execution de ces deux transactions en series devrait avoir pour 
-- effet de mettre le nb d'etoile (de chaque ligne ayant répondu 
-- au clause where) à la valeur du set de la session deux (n2).

-- set transaction isolation level serializable; n'a aucun effet, bizarrement.
-- Action : 
--          Session 1:
--          set transaction isolation level serializable;
--          update Hotels set NbEtoilesHo = 3 where NbEtoilesHo = 1;
--          
--          Session 2:
--          set transaction isolation level serializable;
--          update Hotels set NbEtoilesHo = 1 where NbEtoilesHo = 3;
--
--          commit; dans les deux session -> aucun effet


-- 7 Mise en evidance de l'atomicité des instruction SQL
  
Alter table hotels add check (NbEtoilesHo <= 5) ; 
INSERT INTO Hotels (NumHo, NomHo, RueAdrHo, VilleHo, NbEtoilesHo)
VALUES
  (4, 'Petite bergerie', 'Chemin sainte Augustine', 'Bézié', 5);

CREATE OR REPLACE TRIGGER Trace_Exec
AFTER UPDATE OF NbEtoilesHo
ON Hotels
FOR EACH ROW
BEGIN
  Dbms_output.put_line(
  'Modification réussie temporairement sur l''hotel '||:new.NumHo) ;
END;
/

SET serveroutput on


Select nbetoilesho from hotels;
update hotels SET nbetoilesho = nbetoilesho + 1;

-- On constate que le nouveau hotel créé avec 5 etoile ne répond pas
-- à la contrainte de table (<= 5). on voit bien grace à la trigger
-- que les autre hotels ne posent pas de problème. Ainsi, L'update 
-- ne se fait pas à cause de l'hotel à 5 étoile. Aucun hotel est mis 
-- à jour.

-- 8 Mise en évidance de la gestion de la concurrence au niveaus des intruction SQL
commit;

Create sequence Estampille;

CREATE OR REPLACE TRIGGER Trace_Exec
AFTER UPDATE OF NbEtoilesHo
ON Hotels
FOR EACH ROW
DECLARE N integer;
BEGIN
  N := Estampille.nextval;
  Dbms_output.put_line( 'Estampille '||N||' : '||
  'Modification réussie temporairement sur l''hotel '||:new.nbetoilesho) ;
  dbms_lock.sleep(2);
END;
/
SET serveroutput on

UPDATE HOTELS H1
set nbetoilesHO = (select min(nbetoilesho) from hotels);
rollback;

select * from hotels;

--last : 4
-- On consate que la session 1 pose ses verrous d'ecritures les un 
-- apres les autre sur la ligne qu il modifie. En effet si la session 1
-- avait posé des le depart des verrous d'ecriture sur chaque ligne, 
-- la session deux aurait du attendre la fin des modifications de la 
-- session 1, ce qui n'est pas le cas vu que son estempille est compris
-- entre la premiere et la derniere de la session un.
-- La lecture du min est faite une seul fois.

--9.Gestion de la concurrence dans une contrainte de clef (primaire ou unique)

INSERT INTO Hotels (NumHo, NomHo, RueAdrHo, VilleHo, NbEtoilesHo)
VALUES
  (10, 'Petite bergerie', 'Chemin sainte Augustine', 'Bézié', 5);
  
select * from hotels;

-- On constate que les deux insertions se sont bien passés.

-- Quand on ajoute une ligne dans la session 1, elle ne peut etre vu dans un
-- select dans la session 2.
-- Si on essai d'ajouter dans la session 2 une ligne avec la meme clef
-- primaire que celle ajoute en session 1, la transaction ( session 2 )
-- se met en attante. Apres un commit de la session 1, la session 2 renvoi
-- un message d'erreur (clef primaire identique).
-- On peu supposer que la session1 pose un vérrou d'écriture sur la nouvelle
-- ligne créé.

--10 Gestion de la concurrence dans une contrainte de référence

select * from TYPESCHAMBRE;

  
INSERT INTO TypesChambre
VALUES
  (4, 'carre', 5);
  
INSERT INTO TypesChambre
VALUES
  (5, 'triangulaire', 5);
  
INSERT INTO TypesChambre
VALUES
  (6, 'en 3D', 9999);
  
Delete from TYPESCHAMBRE where NumTy = 4;

select * from CHAMBRES;

-- On constate que quand on essai d'ajouter une chambre ayant le type T1
-- la transaction se met en attante.

update TYPESCHAMBRE set PRIXTY = 42 where NumTy = 5;

Delete from TYPESCHAMBRE where NumTy = 6;

-- Oracle à détécté un interblocage et a couper l'instruction bloquante de
-- la session deux.
--
-- L'instruction update de la session 1 met en attente la transaction.
-- On peut en conclure que les vérroux posé sur une ligne ayant des
-- contraintes de références font également effet sur les tables d'origines.

create index NumTy_Chambre on Chambres(numty);


-- Le fait  d'avoir ajouté l'index sur numty de chambre a permis
-- de executer la requête delete T3.