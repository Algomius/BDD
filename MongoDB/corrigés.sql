-- Import

mongoimport --db test --collection personne --type=json --file "C:\Informatique\CCI\cours\Base de données\13_MongoDb\MOCK_DATA_personne.json" --jsonArray
mongoimport --db test --collection personne --type=csv --file "C:\Informatique\CCI\cours\Base de données\13_MongoDb\MOCK_DATA_personne.csv" --headerline

-- Exemple animal

--> Création
db.createCollection("animal")
db.animal.insert({"nom":"Garfield", "maitre" : "John"})
db.animal.insert({"nom":"Ody", "maitre" : "John"})
db.animal.insertMany([{"nom":"Cubitus", "maitre" : "Sémaphore"}, {"nom":"Sénéchal", "maitre" : "Sémaphore"}])

--> Mise à jour
db.animal.update({"nom":"Cubitus"}, {"nom" : "Ulna", "maitre" : "Sémaphore"})
db.animal.update({"nom":"Ulna"}, {$set: {"nom" : "Cubitus"}})

--> Sélection 
db.animal.find({"maitre": "Sémaphore"})
db.animal.find({"nom" : "Cubitus", "maitre": "Sémaphore"})

--> Suppression
db.animal.deleteMany({"maitre" : "Sémaphore"})

-- Requêtes sur personnes

--> opérateurs de comparaisons :
db.personne.find({"Couleur" : "Red"})
db.personne.find({"Sexe" : {"$ne": "Male"}})
db.personne.find({"Age" : {"$lt": 30}})
db.personne.find({"Age" : {"$gte": 80}})
db.personne.find({"Age" : {"$gte": 80}, "Couleur" : "Pink"})

--> opérateur logique
db.personne.find({"$or" : [{"Age" : {"$lt": 30}}, {"Age" : {"$gt": 90}}]})
db.personne.find({"Voiture" : {$in : ["Audi", "Jaguar", "Ford"]}})
db.personne.find({"Voiture" : {$nin : ["Audi", "Jaguar", "Ford"]}})
db.personne.find({"Langue" : { $exists : 1}})
db.personne.find({"Langue" : { $exists : 0}})

--> Filtrage champs
db.personne.find({"Age" : {"$lt": 30}}, {"Nom":1, "Prenom":1, "_id":0})

-- Objets et tableaux

--> Recherche dans un objet
db.utilisateur.find({"parametres.taille" : {"$gt" : 175 }}) 
db.utilisateur.find({"parametres.taille" : {"$lt" : 175 }, "parametres.poids" : {"$gt" : 70 }}) 

--> Recherche dans un tableau
db.utilisateur.find({couleurs: ["rouge", "blanc"]})
db.utilisateur.find({couleurs: {$all: ["rouge", "blanc"]}})
db.utilisateur.find({couleurs: {$all: ["vert"]}})
db.utilisateur.find({"nombres" : {$gte: 20}})
db.utilisateur.find({"nombres" : {$not : {$gte: 10}}})

-- Opération curseur

db.personne.find().count()
db.personne.find({"Voiture" : "Audi"}).count()
db.personne.count({"Voiture" : "Audi"})
db.personne.find().sort({"Nom" : 1}).limit(5)
db.personne.find().sort({"Nom" : 1}).skip(10).limit(5)
db.personne.find().sort({"Age" : -1}).limit(1)

-- Agregation

var pipeline = [
	{$sort: {"Nom" : 1} }	
];

var pipeline = [
	{$sort: {"Nom" : 1} },
	{$limit : 5} 	
];

var pipeline = [
    {$group: {"_id": "$Voiture", "count": {"$sum": 1}}},
	{$sort: {"Nom" : 1} },
];

var pipeline = [
    {$group: {"_id": "$Voiture", "count": {"$sum": "$Age"}}},
	{$sort: {"Nom" : 1} },
];

var pipeline = [
    	{$group: {"_id": "$Voiture", "count": {"$sum": 1}}},
	{$sort: {"Nom" : 1} },
	{$match : {"count" : {"$gte" : 10 } } }
];

var pipeline = [
    {$group: {"_id": "$Voiture", "max": {"$max": "$Age"}, "min": {"$min": "$Age"}, "avg": {"$avg": "$Age"}}},
	{$sort: {"Nom" : 1} }
];

var pipeline = [
    {$group: {"_id": "$Voiture", "max": {"$max": "$Age"}, "min": {"$min": "$Age"}, "avg": {"$avg": "$Age"}}},
	{$sort: {"Nom" : 1} },
    {$match : {"avg" : {"$gte" : 50 } } }
];


db.personne.aggregate(pipeline);


-- Compass :

1. $project

/**
 * specifications: The fields to
 *   include or exclude.
 */
{
  _id:0,
  Prenom:1,
  Nom: 1,
  Sexe:1,
  Voiture:1,
  Age:1
}

2. $match

/**
 * query: The query in MQL.
 */
{
  Age : {$exists : true}
}

3. $group

/**
 * _id: The id of the group.
 * fieldN: The first field name.
 */
{
  _id: '$Voiture',
  avg: {
    $avg: '$Age'
  }
}

-- Vues
db.createView("util_rouge", "utilisateur", {$match : {couleur: "rouge"}})
db.utilisateur.insert({nom: "Ralph", naissance: new Date(1967, 10, 8), "couleur": "rouge"})

db.util_rouge.find().sort({nom: 1})
db.util_rouge.find().sort({nom: -1})

db.createView("rouge_1980", "util_rouge", {$match : {naissance: {$gt : new Date(1980, 1, 1)}}})
db.createView("public", "utilisateur", {$project : {nom: 1, couleur:1}})
db.createView("roule", "utilisateur", { 
            "$lookup" : { 
                "from" : "voiture", 
                "localField" : "nom", 
                "foreignField" : "nom",
                "as" : "voitureListe"
            }
        })




-- Gestion des utilisateurs
-- https://www.mongodb.com/docs/manual/core/authentication/

-- Se connecter avec un utilisateur :
mongosh --port 27017  --authenticationDatabase "admin" -u "myUserAdmin" -p

-- Liste des utilisateur

use admin
db.system.users.find()


-- creation d'un user

use test
db.createUser(
  {
    user: "Tester",
    pwd:  passwordPrompt(),
    roles: [ { role: "readWrite", db: "test" }]
  }
)


-- Gestion des utilisateurs

-- se connecter à un utilisateur
mongosh --port 27017 --authentificationDatabase "admin" -u "myUserAdmin" -p


-- liste des utilisateurs
use admin
db.system.users.find() 

-- creation d'un users

use test 
db.createUser(
  {
    user: "Bob",
    pwd: 'password',
    roles: [{role : "readWrite", db:"test"}]
  }
)

db.createUser(
  {
    user: "Kim",
    pwd: PasswordPrompt(),
    roles: [{role : "readWrite", db:"test"}]
  }
)

-- Creation de rôle 

use admin
db.createRole(
   {
     role: "myClusterwideAdmin",
     privileges: [
       { resource: { cluster: true }, actions: [ "addShard" ] },
       { resource: { db: "config", collection: "" }, actions: [ "find", "update", "insert", "remove" ] },
       { resource: { db: "users", collection: "usersCollection" }, actions: [ "update", "insert", "remove" ] },
       { resource: { db: "", collection: "" }, actions: [ "find" ] }
     ],
     roles: [
       { role: "read", db: "admin" }
     ]
   },
   { w: "majority" , wtimeout: 5000 }
)


use reporting
db.revokeRolesFromUser(
    "reportsUser",
    [
      { role: "readWrite", db: "accounts" }
    ]
)

use reporting
db.grantRolesToUser(
    "reportsUser",
    [
      { role: "read", db: "accounts" }
    ]
)

db.changeUserPassword("reporting", "SOh3TbYhxuLiW8ypJPxmt1oOfL")

db.revokePrivilegesFromRole(
    "<rolename>",
    [
        { resource: { <resource> }, actions: [ "<action>", ... ] },
        ...
    ],
    { <writeConcern> }
)
