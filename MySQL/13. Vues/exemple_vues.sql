-- Vue entre chanson et album 
drop view if exists V_chansonAlbum;

create or replace view V_chansonAlbum
as
select nom_chanson, nom_album from chanson
inner join album on album.id_album = chanson.id_album
where annee_chanson > '2010';

show tables;

select * from v_chansonAlbum;

describe v_chansonAlbum;

-- Vue entre chanson et album avec libellé de colonne
create or replace view V_chansonAlbum (chanson, album)
as
select nom_chanson, nom_album from chanson
inner join album on album.id_album = chanson.id_album
where annee_chanson > '2010';

describe v_chansonAlbum;

create view V_chanson as select * from chanson;
select * from chanson;

alter table chanson drop column annee_chanson;

select * from v_chanson;

-- Un peu de pratique

create or replace view V_chansonAlbum (idChanson, chanson, album)
as
select id_chanson, nom_chanson, nom_album from chanson
inner join album on album.id_album = chanson.id_album;

select * from V_chansonAlbum;

select chanson from V_chansonAlbum
inner join participe on V_chansonAlbum.idChanson = participe.id_chanson
inner join artiste on artiste.id_artiste = participe.id_artiste;

-- Créer une table temporaire 

CREATE TEMPORARY TABLE TMP_Matable (
	id INT,
    lib VARCHAR(200)
);

show tables;

describe TMP_Matable;

-- Table temporaire avec le même nom

CREATE TEMPORARY TABLE artiste (
	id INT,
    lib VARCHAR(200)
);

select * from artiste;

drop temporary table artiste;

-- Table en copy
CREATE temporary table tmp_album like album;

select * from tmp_album;

INSERT into tmp_album select * from album;

select * from tmp_album;

CREATE temporary table album like tmp_album;

select * from album;

drop temporary table album;



