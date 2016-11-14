--1.Mise en évidence du traitement des écritures sales

UPDATE Hotels
SET NomHo = 'jecpas'
WHERE NumHo = 0;

UPDATE Hotels
SET NomHo = 'autre'
WHERE NumHo = 1;

commit

--2.Mise en évidence du traitement des lectures sales.

Select NbEtoilesHo
from Hotels
where NumHo = 1;

--3.Mise en évidence des lectures non reproductible.

UPDATE Hotels
SET NbEtoilesHo = NbEtoilesHo + 1
WHERE NumHo = 1;
commit;

--4.Mise en evidence du phénomène des lignes fantômes.

INSERT INTO Hotels (NumHo, NomHo, RueAdrHo, VilleHo, NbEtoilesHo)
VALUES
  (5, 'barbecue', 'rue de la trompette', 'Marseille', 4);
commit;

--5.Mise en évidence du phénomène des mises à jour perdues

set transaction isolation level serializable;
declare Nb Integer;
begin
  select nbetoilesho into Nb from hotels where numho = 1;
  update hotels set nbetoilesho = Nb + 1 where numho = 1;
end;
/

-- 6 - retour sur le phénomène fantomes
commit;

set transaction isolation level serializable;
update Hotels set NbEtoilesHo = 1 where NbEtoilesHo = 3;
commit;


-- 8.Mise en evidence de la gestion de la concurence au niveau des instructions sql
commit;

SET serveroutput on

update hotels set nbetoilesHO = nbetoilesho - 1
where numho = 4;
commit;

--9.Gestion de la concurrence dans une contrainte de clef (primaire ou unique)

INSERT INTO Hotels (NumHo, NomHo, RueAdrHo, VilleHo, NbEtoilesHo)
VALUES
  (8, 'Petite bergerie', 'Chemin sainte Augustine', 'Bézié', 5);

select * from hotels;

INSERT INTO Hotels (NumHo, NomHo, RueAdrHo, VilleHo, NbEtoilesHo)
VALUES
  (10, 'Petite bergerie', 'Chemin sainte Augustine', 'Bézié', 5);

--10 Gestion de la concurrence dans une contrainte de référence

insert into chambres values
(4, 0, 5);

insert into chambres values
(4, 1, 4);

select * from TYPESCHAMBRE;
