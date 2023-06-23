DROP PROCEDURE IF EXISTS inserer_roman;

DELIMITER |
CREATE PROCEDURE inserer_roman(in p_id_roman varchar(17), in p_nom_roman varchar(200), in p_id_serie int, in p_nom_serie varchar(200) )
BEGIN
    DECLARE EXIT HANDLER FOR sqlexception ROLLBACK; 

	START TRANSACTION;
    
    INSERT INTO ROMAN(code_isbn, nom) VALUES (p_id_roman, p_nom_roman);
    INSERT INTO SERIE(code_serie, nom_serie) VALUES (p_id_serie, p_nom_serie);
    INSERT INTO estdans(code_isbn, code_serie) VALUES (p_id_roman, p_id_serie);
    
    COMMIT;
END|
DELIMITER ;

CALL inserer_roman(19, "roman1", 12, "serie2");