-- Client avec couleur préférée
CREATE TABLE personne (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    prenom VARCHAR(50) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    date_naissance DATE NOT NULL,
    couleur_preferee VARCHAR(50),
    email VARCHAR(50)
);

-- Vérification des couleurs
Alter table personne add constraint couleur_contrainte CHECK (couleur_preferee = 'rouge' OR couleur_preferee = 'bleu' OR couleur_preferee = 'vert');

-- Insertion de nouvelles personnes 
insert into personne (prenom, nom, date_naissance, couleur_preferee, email) values ('Rodolfo', 'Fossick', '05/11/1998', 'rouge', 'rfossick0@xing.com');
insert into personne (prenom, nom, date_naissance, couleur_preferee, email) values ('Darn', 'Minichi', '07/02/2019', 'bleu', 'dminichi1@usgs.gov');
insert into personne (prenom, nom, date_naissance, couleur_preferee, email) values ('Denis', 'Fernan', '06/09/2018', 'vert', 'dfernan2@jigsy.com');
insert into personne (prenom, nom, date_naissance, couleur_preferee, email) values ('Janelle', 'Flemyng', '29/06/1990', 'orange', 'jflemyng3@vinaora.com');
insert into personne (prenom, nom, date_naissance, couleur_preferee, email) values ('Hertha', 'Ferneley', '02/01/1963', 'cian', 'hferneley4@studiopress.com');

-- Utilisation du mot de passe
CREATE TABLE personne (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    prenom VARCHAR(50) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    date_naissance DATE NOT NULL,
    couleur_preferee VARCHAR(50),
    mdp VARCHAR(50),
    mdp_check VARCHAR(50),
    email VARCHAR(50)
);

-- Vérification des couleurs
Alter table personne add constraint couleur_contrainte CHECK (couleur_preferee = 'rouge' OR couleur_preferee = 'bleu' OR couleur_preferee = 'vert');
Alter table personne add constraint mdp_contrainte CHECK (mdp = mdp_check);

-- Insertion de nouvelles personnes 
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Rodolfo', 'Fossick', '05/11/1998', 'rouge', 'truc1', 'truc', 'rfossick0@xing.com');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Darn', 'Minichi', '07/02/2019', 'bleu', 'truc', 'truc', 'dminichi1@usgs.gov');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Denis', 'Fernan', '06/09/2018', 'vert', 'truc', 'truc1', 'dfernan2@jigsy.com');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Janelle', 'Flemyng', '29/06/1990', 'orange', 'truc', 'truc', 'jflemyng3@vinaora.com');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Hertha', 'Ferneley', '02/01/1963', 'cian', 'truc', 'truc', 'hferneley4@studiopress.com');

-- Création d'un conflit sur la pk
insert into personne (id, prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values (1, 'Rodolfo', 'Fossick', '05/11/1998', 'rouge', 'truc', 'truc', 'rfossick0@xing.com');

-- Ne rien faire en cas de conflit
insert into personne (id, prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values (1, 'Rodolfo', 'Fossick', '05/11/1998', 'rouge', 'truc', 'truc', 'rfossick0@xing.com') ON CONFLICT (id) do nothing;

-- Mise à jour sur détection de conflit
insert into personne (id, prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values (1, 'Rodolfo1', 'Fossick1', '05/11/1998', 'rouge', 'truc', 'truc', 'rfossick0@xing.com') 
ON CONFLICT (id) do UPDATE SET nom = EXCLUDED.nom, prenom = EXCLUDED.prenom;

-- deux personnes avec le meme email
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Rodolfo', 'Fossick', '05/11/1998', 'rouge', 'truc', 'truc', 'rfossick0@xing.com');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Darn', 'Minichi', '07/02/2019', 'bleu', 'truc', 'truc', 'dminichi1@usgs.gov');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Denis', 'Fernan', '06/09/2018', 'vert', 'truc', 'truc', 'hferneley4@studiopress.com');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Janelle', 'Flemyng', '29/06/1990', 'rouge', 'truc', 'truc', 'jflemyng3@vinaora.com');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Hertha', 'Ferneley', '02/01/1963', 'rouge', 'truc', 'truc', 'hferneley4@studiopress.com');

-- Unicité de l'email :
Alter table personne add constraint email_unique UNIQUE(email);

-- Correction des mails
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Rodolfo', 'Fossick', '05/11/1998', 'rouge', 'truc', 'truc', 'rfossick0@xing.com');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Darn', 'Minichi', '07/02/2019', 'bleu', 'truc', 'truc', 'dminichi1@usgs.gov');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Denis', 'Fernan', '06/09/2018', 'vert', 'truc', 'truc', 'dfernan2@jigsy.com');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Janelle', 'Flemyng', '29/06/1990', 'rouge', 'truc', 'truc', 'jflemyng3@vinaora.com');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email) values ('Hertha', 'Ferneley', '02/01/1963', 'rouge', 'truc', 'truc', 'hferneley4@studiopress.com');

--Enumération Couleur

CREATE TYPE couleur as enum ('rouge', 'vert', 'bleu');

CREATE TABLE personne (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    prenom VARCHAR(50) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    date_naissance DATE NOT NULL,
    couleur_preferee VARCHAR(50),
    mdp VARCHAR(50),
    mdp_check VARCHAR(50),
    email VARCHAR(50),
    coul couleur
);

-- Test de l'énumération par insertion
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email, coul) values ('Rodolfo', 'Fossick', '05/11/1998', 'rouge', 'truc', 'truc', 'rfossick0@xing.com', 'rouge');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email, coul) values ('Darn', 'Minichi', '07/02/2019', 'bleu', 'truc', 'truc', 'dminichi1@usgs.gov', 'vert');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email, coul) values ('Denis', 'Fernan', '06/09/2018', 'vert', 'truc', 'truc', 'dfernan2@jigsy.com', 'jaune');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email, coul) values ('Janelle', 'Flemyng', '29/06/1990', 'rouge', 'truc', 'truc', 'jflemyng3@vinaora.com', 'bleu');
insert into personne (prenom, nom, date_naissance, couleur_preferee, mdp, mdp_check, email, coul) values ('Hertha', 'Ferneley', '02/01/1963', 'rouge', 'truc', 'truc', 'hferneley4@studiopress.com', 'cian');

-- Composite 
CREATE TYPE sens as enum ('debit', 'credit');
CREATE TYPE devise as enum ('EUR', 'USD', 'GBP');

CREATE TYPE transaction as (
    se sens,
    mt numeric,
    de devise
);

create table mouvement (
    id serial,
    tr transaction
);

-- insertion dans la table 

INSERT INTO mouvement (tr) VALUES (row('credit', 42.00, 'EUR'));
INSERT INTO mouvement (tr) VALUES (row('debit', 25.58, 'USD'));
INSERT INTO mouvement (tr) VALUES (row('credit', 85.45 'EUR'));

-- Sélection avec composites

select (tr).se, (tr).mt, (tr).de from mouvement;

-- Utilisateur d'un site

CREATE table Visiteur (
    nom VARCHAR(50),
    prenom VARCHAR(50)
);

CREATE table utilisateur (
    mail VARCHAR(100)
) INHERITS (Visiteur);

INSERT INTO VISITEUR (nom, prenom) VALUES ('Bob', 'Marley');
INSERT INTO utilisateur (nom, prenom, mail) VALUES ('Jack', 'Bauer', 'Jack@bauer.fr');

select * from only visiteur;

-- Information elaborable d'un article 
CREATE table article (
    id serial,
    lib VARCHAR(50),
    pu numeric,
    qte int,
    total numeric generated always as (pu * qte) STORED
);

insert into article (lib, pu, qte) VALUES ('Marteau', 5.6, 50);

-- Date et heures 
select age(now(), date_naissance) from personne;

-- Relations 
CREATE TABLE auteur (
    id_auteur serial PRIMARY key,
    nom_auteur varchar(50)
);

CREATE table roman (
    id_roman serial primary key,
    nom_roman VARCHAR(50),
    id_auteur serial references auteur (id_auteur)
);

-- Insertion Auteur
insert into auteur (nom_auteur) VALUES ('Asimov');
insert into auteur (nom_auteur) VALUES ('Pratchett');
insert into auteur (nom_auteur) VALUES ('Tolkien');

-- Insert roman 
insert into roman (nom_roman, id_auteur) VALUES ('Le seigneur des anneaux', 3);
insert into roman (nom_roman, id_auteur) VALUES ('Les robots', 1);
insert into roman (nom_roman, id_auteur) VALUES ('Harry Potter', 4);

-- jointure 
Select * from roman JOIN auteur on roman.id_auteur = auteur.id_auteur;

-- JSON

CREATE TABLE balle (
    id serial primary key,
    info JSON
); 

 insert into balle (info) VALUES ('   {"_id": "Baseball","name": "Baseball","price": 18.56,"color": [{"lib" : "blanc"}, {"lib" : "rouge"}],"imageUrl": "baseball.jpg","description": "Une balle de baseball avec de belles coutures rouges de très bonne facture.","altTxt": "Photo d une balle de baseball"}');
 insert into balle (info) VALUES ('   {"_id": "Basketball","name": "Basketball","price": 25.02,"color": [{"lib" : "orange"}],"imageUrl": "basketball.jpg","description": "Une balle de basketball qui n attend que vous.","altTxt": "Photo d une balle de basketball"}');
 insert into balle (info) VALUES ('   {"_id": "Football","name": "Football","price": 35.75,"color": [{"lib" : "blanc"},{"lib" : "noir"}],"imageUrl": "football.jpg","description": "L accessoire essentiel pour la prochaine coupe du monde.","altTxt": "Photo d une balle de football"}');
 insert into balle (info) VALUES ('   {"_id": "Golf","name": "Golf","price": 12.27, "color": [{"lib" : "blanc"}],"imageUrl": "golf.jpg","description": "Une balle de golf pour la compétition.","altTxt": "Photo d une balle de golf"}');
 insert into balle (info) VALUES ('   {"_id": "Rugby","name": "Rugby","price": 27.56,"color": [{"lib" : "terre battue"}],"imageUrl": "rugby.jpg","description": "Une balle qui fera de vous le champion du top 14.","altTxt": "Photo d une balle de rugby"}');
 insert into balle (info) VALUES ('   {"_id": "Tennis","name": "Tennis","price": 11.85,"color": [{"lib" : "jaune"}],"imageUrl": "tennis.jpg","description": "Une balle qui ne nécessite pas de second service.","altTxt": "Photo d une balle de tennis"}');

-- prix des ballons

SELECT info->'price' FROM balle;

-- Première couleur

SELECT info->'color'->0 FROM balle;

-- morpion 
CREATE TABLE morpion (
    id serial primary key,
    grille char[3][3]
);

INSERT INTO morpion (grille) VALUES ('{{"X","O","X"},{"X","O","X"},{"O","O","O"}}');
INSERT INTO morpion (grille) VALUES ('{{"X","O","X"},{"O","X","X"},{"O","O","X"}}');

SELECT * from morpion 
where grille[1][2] = grille[2][2]
and grille[1][2] = grille[3][2];

-- modification :
UPDATE morpion SET grille[1][3] = 'O' where id = 1;
UPDATE morpion SET grille[1][:] = '{"O","O","O"}' where id = 1;

-- recherche 
select * from morpion where 'X' = all(grille[1][:]);
select * from morpion where 'X' = all(grille[:][1]);
select * from morpion where 'X' = any(grille[1][:]);
select * from morpion where 'X' = any(grille[:][1]);