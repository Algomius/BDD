import mysql.connector
from mysql.connector import errorcode

# Connection à la base de données
config = {
    'user': 'root',
    'password': 'pass',
    'host': '127.0.0.1',
    'database': 'roman',
    'raise_on_warnings': True
}

try:
    cnx = mysql.connector.connect(**config)
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("L'utilisateur ou le mot de passe n'est pas correct")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("La base de données n'existe pas!")
    else:
        print(err)

    exit()

paragraphe = 3

# Sélection des informations
if paragraphe == 1:
    print("Affichage des romans qui contiennent le mot 'Harry'")

    cursorSel = cnx.cursor()

    selectAction = ("SELECT nom FROM roman WHERE nom like %s")
    selectValue = ('%'+"Harry"+'%',)

    cursorSel.execute(selectAction, selectValue)
    resultSelect = cursorSel.fetchall()
    for i in resultSelect:
        print(i[0])

    cursorSel.close()

# Insertion d'une nouvelle entréenc
if paragraphe == 2:

    data_serie = {
        'codeSerie': 4,
        'nomSerie': "Hunger Games",
    }

    cursorInsert = cnx.cursor()

    add_serie = ("INSERT INTO serie "
        "(code_serie, nom_serie) "
        "VALUES (%(codeSerie)s, %(nomSerie)s)")

    cursorInsert.execute(add_serie, data_serie)
    print(cursorInsert.rowcount, "séries insérées.")

    romans = [
        ["Hunger Games"],
        ["L'embrasement"],
        ["La révolte"]
    ]

    add_roman = ("INSERT INTO roman "
        "(code_isbn, nom, auteur, annee, prix, code_serie) "
        "VALUES (%(codeISBN)s, %(nomRoman)s, %(auteurRoman)s, %(anneeRoman)s, %(prixRoman)s, %(codeSerie)s)")
    isbn = 13
    for r in romans:
        data_roman = {
            'codeISBN': isbn,
            'nomRoman': r[0],
            'auteurRoman': 'Suzanne Collins',
            'anneeRoman': 2015,
            'prixRoman': 7.95,
            'codeSerie': 4,
        }

        cursorInsert.execute(add_roman, data_roman)
        print(cursorInsert.rowcount, "romans insérés.")

        isbn = isbn+1

    cnx.commit()

    cursorInsert.close()

# Suppression d'une ligne
if paragraphe == 3:
    cursorDel = cnx.cursor()
    deleteRoman = "DELETE FROM roman WHERE nom = %s"
    dataRoman = ('Neverwhere',)

    cursorDel.execute(deleteRoman, dataRoman)
    cnx.commit()

    print(cursorDel.rowcount, "romans supprimés")

    deleteRoman = "DELETE FROM serie WHERE nom_serie = %s"
    dataRoman = ('Hunger Games',)

    try:
        cursorDel.execute(deleteRoman, dataRoman)
        print(cursorDel.rowcount, "romans supprimés")
    except mysql.connector.Error as err:
        print(err)

    print('Je termine correctement')
    cnx.commit()
    cursorDel.close()

# Fermeture connexion
cnx.close()
