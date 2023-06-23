DROP PROCEDURE IF EXISTS ajouter_serie;

DELIMITER |
CREATE PROCEDURE ajouter_serie(IN p_serie_id INT, IN p_serie_nom VARCHAR(200))
BEGIN
    DECLARE CONTINUE HANDLER FOR 1062
        BEGIN
            UPDATE SERIE SET nom_serie = p_serie_nom WHERE code_serie = p_serie_id;
        END;

    SELECT 'Début procédure';

	insert into serie(code_serie, nom_serie) VALUES (p_serie_id, p_serie_nom);
    SELECT 'Fin procédure';
END|
DELIMITER ;

CALL ajouter_serie(4, "Nouvelle serie");

select * from serie;
