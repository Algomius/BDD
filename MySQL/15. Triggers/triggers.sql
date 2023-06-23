-- Trigger de log

drop trigger if exists before_insert_client;
drop trigger if exists before_update_client;

DELIMITER |
create trigger before_update_client before update 
ON client
for each row
BEGIN 
	INSERT INTO log (timestamp_log, msg_log) VALUES (now(), concat('modification table client sur client ', NEW.id_client));
END|
DELIMITER ;


DELIMITER |
create trigger before_insert_client before insert 
ON client
for each row
BEGIN 
	INSERT INTO log (timestamp_log, msg_log) VALUES (now(), concat('Insertion table client ', NEW.id_client));
END|
DELIMITER ;

insert into client(nom_client, type_client) VALUES ('Bob', 'P');

update client 
SET type_client = 'E'
where id_client = 1;

select * from log;

-- pratique un peu plus loin

drop trigger if exists before_insert_client;
drop trigger if exists before_update_client;

DELIMITER |
create trigger before_update_client before update 
ON client
for each row
BEGIN 
	INSERT INTO log (timestamp_log, msg_log) VALUES (now(), concat('modification table client sur client ', NEW.id_client));
	IF NEW.type_client IS NOT NULL  
    AND NEW.type_client != 'P'   -- type de client Personne    
    AND NEW.type_client != 'E'   -- type de client Entreprise  
      THEN
        SET NEW.type_client = 'P';
        INSERT INTO erreur (lib_erreur) VALUES (concat('Erreur de type client pour le client ', NEW.id_client));
    END IF;
END|
DELIMITER ;


DELIMITER |
create trigger before_insert_client before insert 
ON client
for each row
BEGIN 
	INSERT INTO log (timestamp_log, msg_log) VALUES (now(), concat('modification table client sur client ', NEW.id_client));
	IF NEW.type_client IS NOT NULL  
    AND NEW.type_client != 'P'   -- type de client Personne    
    AND NEW.type_client != 'E'   -- type de client Entreprise  
      THEN
        SET NEW.type_client = 'P';
        INSERT INTO erreur (lib_erreur) VALUES (concat('Erreur de type client pour le client ', NEW.id_client));
    END IF;
END|
DELIMITER ;

insert into client(nom_client, type_client) VALUES ('Bob', 'L');

update client 
SET type_client = 'K'
where id_client = 1;

select * from log;

select * from erreur;


