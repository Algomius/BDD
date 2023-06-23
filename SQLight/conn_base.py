import sqlite3

# Ouverture d'une connexion vers la base de données
conn = sqlite3.connect('c:\\tmp\\pyBase.db')

# Création du curseur
c = conn.cursor()

# Execution d'une instruction SQL au travers du curseur
#c.execute("""CREATE TABLE Personne (
#    id_personne integer primary key autoincrement,
#    nom_personne text,
#    email_personne text,
#    age_personne interger
#)""")

# insertion dans la base 
#c.execute("""insert into Personne (nom_personne, email_personne, age_personne) VALUES ('bob', 'Bob@jam.com', 28)""")
#c.execute("""insert into Personne (nom_personne, email_personne, age_personne) VALUES ('kim', 'Kim@kong.com', 35)""")

# insertion avec tableau
lst_personne = [
    ('Gill', 'Gill@work.com', 27),
    ('Jack', 'Jack@home.com', 47)
]
c.executemany("""insert into Personne (nom_personne, email_personne, age_personne) VALUES (?, ?, ?)""", lst_personne)

# selection dans la base de données
c.execute("""select * from personne""")
for e in c.fetchall():
    print(e[0])

# Valider la transaction
conn.commit()

# Fermeture de la connexion
conn.close()