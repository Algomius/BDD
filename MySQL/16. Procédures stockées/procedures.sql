 -- Procédure sans paramètre

drop PROCEDURE if exists maProcedure;

DELIMITER |
CREATE PROCEDURE maProcedure () 
BEGIN 
Select * from artiste;
END| 

call maProcedure;

-- Procédure avec paramètre in et out
DELIMITER|
CREATE PROCEDURE nbPartcipation(IN p_artiste_name varchar(200), OUT p_nb_participation INT )
BEGIN 
	select count(*) into p_nb_participation from artiste
	inner join participe on artiste.id_artiste = participe.id_artiste
	where nom_artiste = p_artiste_name;
END|

call nbPartcipation('Li', @maVar);

select @maVar;
