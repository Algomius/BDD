drop table if exists roman;
drop table if exists serie;

create table if not exists serie
(
	code_serie INT NOT NULL,
    nom_serie VARCHAR(200),
    constraint pk_serie primary key(code_serie)
);

create table if not exists roman
(
	code_ISBN INT NOT NULL AUTO_INCREMENT,
	nom varchar(200),
    auteur varchar(200),
    annee INT,
    prix DECIMAL(15,2),
    code_serie int,
    constraint pk_roman primary key(code_ISBN),
    foreign key(code_serie) REFERENCES serie(code_serie)
);

insert into serie(code_serie, nom_serie) VALUES (1, "Le Seigneur des anneaux");
insert into serie(code_serie, nom_serie) VALUES (2, "Harry Potter");
insert into serie(code_serie, nom_serie) VALUES (3, "Les robots");
insert into roman (code_ISBN, nom, auteur, annee, prix, code_serie) VALUES ("1", "La Communauté de l'anneau", "JRR Tolkien", "1954", 5.65, 1);
insert into roman (code_ISBN, nom, auteur, annee, prix, code_serie) VALUES ("2", "Les deux tours", "JRR Tolkien", "1954", 7.25, 1);
insert into roman (code_ISBN, nom, auteur, annee, prix, code_serie) VALUES ("3", "Le retour du roi", "JRR Tolkien", "1955", 8.55, 1);
insert into roman (code_ISBN, nom, auteur, annee, prix, code_serie) VALUES ("4", "Harry Potter à l'école des sorciers", "JK Rowling", "1998", 4.75, 2);
insert into roman (code_ISBN, nom, auteur, annee, prix, code_serie) VALUES ("5", "Harry Potter et la chambre des secrets", "JK Rowling", "1999", 5.05, 2);
insert into roman (code_ISBN, nom, auteur, annee, prix, code_serie) VALUES ("6", "Harry Potter et le Prisonnier d'Azkaban", "JK Rowling", "1999", 7.55, 2);
insert into roman (code_ISBN, nom, auteur, annee, prix, code_serie) VALUES ("7", "Neverwhere", "Neil Gaiman", "1996", 8.45, NULL);
insert into roman (code_ISBN, nom, auteur, annee, prix, code_serie) VALUES ("8", "Stardust", "Neil Gaiman", "1999", 8.54, NULL);
insert into roman (code_ISBN, nom, auteur, annee, prix, code_serie) VALUES ("9", "Les robots", "Isaac Asimov", "1967", 3.25,3);
insert into roman (code_ISBN, nom, auteur, annee, prix, code_serie) VALUES ("10", "Un défilé de robots", "Isaac Asimov", "1967", 4.85,3);
insert into roman (code_ISBN, nom, auteur, annee, prix, code_serie) VALUES ("11", "Nous les robots", "Isaac Asimov", "1982", 5.25,3);
insert into roman (code_ISBN, nom, auteur, annee, prix, code_serie) VALUES ("12", "Le robot qui rêvait", "Isaac Asimov", "1988", 8.25,3);