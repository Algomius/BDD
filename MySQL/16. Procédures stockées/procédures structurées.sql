-- Procedure affichage

drop procedure if exists affichage;
DELIMITER |
CREATE Procedure affichage(OUT text1 VARCHAR(200), OUT text2 VARCHAR(200), OUT text3 VARCHAR(200))
BEGIN
	DECLARE val1 int default 1;
	SELECT 'Je suis dans le bloc principal' into Text1;
	BEGIN
		DECLARE val2 int default 2;
		SELECT 'Je suis dans un bloc secondaire' into text2;
        select val1, val2;
	END;
	SELECT 'Je suis à nouveau dans le bloc principal' into text3;
    -- select val1, val2;
END;
|
DELIMITER ;

call affichage(@text1, @text2, @text3);

select @text3;

-- Structure conditionnelle et archivage

drop procedure if exists archivage;
DELIMITER |
CREATE Procedure archivage()
BEGIN
	DECLARE v_jour INT DEFAULT DATE_FORMAT(CURRENT_DATE(), '%d');  
    IF (v_jour = 01) THEN
		delete from album_archive_01;
        insert into album_archive_01 (select * from album);
	END IF;	
END;
|
DELIMITER ;

call archivage();

select * from album_archive_01;

-- Archivage avezc une fonction case

drop procedure if exists archivageMult;
DELIMITER |
CREATE Procedure archivageMult()
BEGIN
	DECLARE v_jour INT DEFAULT DATE_FORMAT(CURRENT_DATE(), '%d');  
    CASE v_jour
		WHEN 1 THEN
			delete from album_archive_01;
			insert into album_archive_01 (select * from album);
		WHEN 10 THEN
			delete from album_archive_10;
			insert into album_archive_10 (select * from album);
		WHEN 20 THEN
			delete from album_archive_20;
			insert into album_archive_20 (select * from album);
		ELSE
			select 1;
	END CASE;	
END;
|
DELIMITER ;

call archivageMult();

select * from album_archive_10;

-- Procédure sur le temps

drop procedure if exists donneVetement;
DELIMITER |
CREATE Procedure donneVetement(IN p_temperature INT, IN p_temps VARCHAR(50), OUT p_vetement VARCHAR(50))
BEGIN
    CASE
		WHEN p_temperature < 5 and (p_temps = 'Beau' or p_temps = 'Nuageux') THEN
			SELECT 'Manteau' INTO p_vetement;
		WHEN p_temperature < 20 and p_temps = 'Pluvieux' THEN
			SELECT 'Imperméable' INTO p_vetement;
		WHEN p_temperature >= 20 and p_temps = 'Pluvieux' THEN
			SELECT 'Parapluie' INTO p_vetement;
		WHEN p_temperature >= 5 and p_temperature < 20  and p_temps = 'Nuageux' THEN
			SELECT 'Veste' INTO p_vetement;
		ELSE
			SELECT 'Casquette' INTO p_vetement;
	END CASE;	
END;
|
DELIMITER ;

SET @temperature = -3;
set @temps = 'Beau';

call donneVetement( @temperature, @temps, @vetement);

select @vetement;

-- Utilisation du if compact
select nom_chanson, if(annee_chanson < 2010,'Récent','Ancien') from chanson;

-- Auditeurs de test

drop procedure if exists creationAuditeur;
DELIMITER |
CREATE Procedure creationAuditeur(IN p_nbrAuditeur INT)
BEGIN
	DECLARE v_indice INT DEFAULT 0;
    delete from auditeur;
    WHILE v_indice < p_nbrAuditeur DO
		INSERT INTO auditeur (nom_auditeur) VALUES (concat('Auditeur_', v_indice));
        SET v_indice = v_indice + 1;
    END WHILE;
END;
|
DELIMITER ;

SET @nbAud = 100;

call creationAuditeur(@nbAud);

select * from auditeur;




 


