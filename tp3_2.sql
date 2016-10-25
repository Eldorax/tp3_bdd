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
  (4, 'barbecue', 'rue de la trompette', 'Marseille', 4);
commit;
