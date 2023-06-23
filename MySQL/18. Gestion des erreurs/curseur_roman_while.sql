DROP PROCEDURE IF EXISTS liste_roman;

DELIMITER |
CREATE PROCEDURE liste_roman()
BEGIN
    DECLARE v_nom, v_auteur VARCHAR(100);
    
    DECLARE fin BOOL DEFAULT TRUE;                      
    -- Variable locale utilisée pour stopper la boucle

    DECLARE cur_roman CURSOR
        FOR SELECT nom, auteur
        FROM roman;

    -- Gestionnaire d'erreur pour la condition NOT FOUND
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = FALSE; 

    OPEN cur_roman;                                    

    WHILE fin DO                                              
        FETCH cur_roman INTO v_nom, v_auteur;
        IF fin THEN 
            SELECT CONCAT(v_nom, ' ', v_auteur) AS 'Roman';
        END IF;
                   
    END WHILE;

    CLOSE cur_roman; 
END|
DELIMITER ;

CALL liste_roman();