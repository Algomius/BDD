drop table if exists  client;
drop table if exists  log;
drop table if exists  erreur;


CREATE TABLE Client(
   id_client INT AUTO_INCREMENT,
   Nom_client VARCHAR(50),
   type_client CHAR(1),
   PRIMARY KEY(id_client)
);

CREATE TABLE Log(
   id_log INT AUTO_INCREMENT,
   timestamp_log DATETIME,
   msg_log VARCHAR(200),
   PRIMARY KEY(id_log)
);

CREATE TABLE Erreur(
   id_error INT AUTO_INCREMENT,
   lib_erreur VARCHAR(200),
   PRIMARY KEY(id_error)
);
