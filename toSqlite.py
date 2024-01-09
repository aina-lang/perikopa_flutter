import sqlite3
import json

# Fonction pour créer les tables dans la base de données SQLite

def reset_tables(cursor):
    cursor.execute('''
        DELETE FROM andininys;
    ''')

    cursor.execute('''
        DELETE FROM tokos;
    ''')
    cursor.execute('''
            DELETE FROM books;
        ''')

    cursor.execute('''
        UPDATE SQLITE_SEQUENCE SET seq = 0 WHERE name = 'books';
    ''')

    cursor.execute('''
        UPDATE SQLITE_SEQUENCE SET seq = 0 WHERE name = 'andininys';
    ''')

    cursor.execute('''
        UPDATE SQLITE_SEQUENCE SET seq = 0 WHERE name = 'tokos';
    ''')
    
def create_tables(cursor):
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS books (
            id INTEGER PRIMARY KEY,
            shortName VARCHAR(10),
            type VARCHAR(10)
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS tokos (
            id INTEGER PRIMARY KEY,
            numero INTEGER,
            book_id INTEGER,
            FOREIGN KEY (book_id) REFERENCES books (id)
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS andininys (
            id INTEGER PRIMARY KEY,
            idToko INTEGER,
            numeroToko INTEGER,
            text TEXT,
            FOREIGN KEY (idToko) REFERENCES tokos (id)
        )
    ''')

# Fonction pour insérer des données dans les tables
def insert_data(cursor, data):
    for item in data["body"]:
        # Insérer des données dans la table 'books'
        cursor.execute('''
            INSERT INTO books (shortName, type)
            VALUES (?, ?)
        ''', (item["id"], item["type"]))

        # Récupérer l'ID du dernier enregistrement inséré
        book_id = cursor.lastrowid

        # Vérifier si la clé "books" existe et est un dictionnaire
        if "books" in item and isinstance(item["books"], dict):
            # Insérer des données dans la table 'tokos'
            toko_value = item["books"].get("toko", None)
            if toko_value is not None:
                cursor.execute('''
                    INSERT INTO tokos (numero, book_id)
                    VALUES (?, ?)
                ''', (toko_value, book_id))

                # Récupérer l'ID du dernier enregistrement inséré dans 'tokos'
                toko_id = cursor.lastrowid

                # Insérer des données dans la table 'andininys'
                texts_value = item["books"].get("texts", [])
                print(item["books"]["toko"])
                for text in texts_value:
                    cursor.execute('''
                        INSERT INTO andininys (idToko, numeroToko, text)
                        VALUES (?, ?, ?)
                    ''', (toko_id, item["books"]["toko"], text))
        
        # Si la clé "books" est une liste de dictionnaires
        elif "books" in item and isinstance(item["books"], list):
            for i in range(len(item["books"])):
                toko_value = item["books"][i].get("toko", None)
                if toko_value is not None:
                    cursor.execute('''
                        INSERT INTO tokos (numero, book_id)
                        VALUES (?, ?)
                    ''', (toko_value, book_id))

                    # Récupérer l'ID du dernier enregistrement inséré dans 'tokos'
                    toko_id = cursor.lastrowid

                    # Insérer des données dans la table 'andininys'
                    texts_value = item["books"][i].get("texts", [])
                    for text in texts_value:
                        cursor.execute('''
                            INSERT INTO andininys (idToko, numeroToko, text)
                            VALUES (?, ?, ?)
                        ''', (toko_id, item["books"][i].get("toko", 0), text))

# Fonction principale
def main():
   
    # Charger les données JSON à partir d'un fichier
    with open('A:\\baiboly.json', 'r', encoding='utf-8') as file:
        json_data = json.load(file)

    # Connexion à la base de données SQLite
    conn = sqlite3.connect(r'A:\PROJECTS\Mobile\perikopa_flutter\assets\perikopa.db')
    cursor = conn.cursor()
    reset_tables(cursor)
    # Créer les tables dans la base de données
    create_tables(cursor)

    # Insérer les données dans les tables
    insert_data(cursor, json_data)

    # Valider les modifications et fermer la connexion
    conn.commit()
    conn.close()

if __name__ == "__main__":
    main()
