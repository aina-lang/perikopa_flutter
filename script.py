# # import sqlite3
# # import json
# # import os

# # # Connexion à la base de données SQLite
# # conn = sqlite3.connect(r'A:\PROJECTS\Mobile\perikopa_flutter\assets\perikopa.db')

# # def test_database_connection(database_path):
# #     try:
# #         # Connexion à la base de données SQLite
# #         conn = sqlite3.connect(database_path)
# #         print("Successfully connected to the database!")

# #         # You can perform additional database operations here if needed

# #     except sqlite3.Error as e:
# #         print(f"Error connecting to the database: {e}")

# #     finally:
# #         if conn:
# #             conn.close()
# #             print("Database connection closed.")

# # Specify the path to your SQLite database file
# # database_path = r'A:\PROJECTS\Mobile\perikopa_flutter\assets\perikopa.db'

# # # Test the database connection
# # # test_database_connection(database_path)
# # cursor = conn.cursor()

# # # Parcourir tous les fichiers JSON dans le répertoire
# # json_folder = r'C:\Users\mercia\Desktop\perikopa\src\livre\Testameta taloha'

# # for filename in os.listdir(json_folder):
# #     if filename.endswith('.json'):
# #         with open(os.path.join(json_folder, filename), 'r', encoding='utf-8') as json_file:
# #             data = json.load(json_file)

# #             # Insérer les données du meta dans la base de données
# #             cursor.execute('''
# #                 INSERT INTO meta (name, order_value, chapter_number)
# #                 VALUES (?, ?, ?)
# #             ''', (data['meta']['name'], data['meta']['order'], data['meta']['chapter_number']))

# # # Valider les modifications et fermer la connexion
# # conn.commit()
# # conn.close()

# # def insert_toko_and_andininy(conn, livre_id, section_numero, toko_data):
# #     try:
# #         cursor = conn.cursor()
# #         # Inserting toko record
# #         # cursor.execute('''
# #         #     INSERT INTO toko (numero, idLivre)
# #         #     VALUES (?, ?)
# #         # ''', (section_numero, livre_id))
# #         # conn.commit()

# #         # Fetching the id of the inserted toko record
# #         cursor.execute('''
# #             SELECT id
# #             FROM toko
# #             WHERE numero = ? AND idLivre = ?
# #         ''', (section_numero, livre_id))
# #         toko_id = cursor.fetchone()[0]

# #         # Inserting andininy record associated with the toko
# #         cursor.execute('''
# #             INSERT INTO andininy (numero, textAndininy, idToko)
# #             VALUES (?, ?, ?)
# #         ''', (section_numero, toko_data, toko_id))
# #         conn.commit()

# #         print(f"Toko and Andininy records inserted successfully for Livre ID {livre_id}, Section Numero {section_numero}")
# #     except sqlite3.Error as e:
# #         print(f"Error inserting Toko and Andininy records: {e}")
# import sqlite3
# import json
# import os

# def test_database_connection(database_path):
#     try:
#         conn = sqlite3.connect(database_path)
#         print("Successfully connected to the database!")
#         return conn
#     except sqlite3.Error as e:
#         print(f"Error connecting to the database: {e}")
#         return None

# def insert_andininy(conn, livre_id, toko_id, andininy_data):
#     try:
#         cursor = conn.cursor()

#         # Inserting toko record
#         cursor.execute('''
#             INSERT INTO toko (numero, idLivre)
#             VALUES (?, ?)
#         ''', (toko_id, livre_id))
#         conn.commit()

#         # Fetching the id of the inserted toko record
#         cursor.execute('''
#             SELECT id
#             FROM toko
#             WHERE numero = ? AND idLivre = ?
#         ''', (toko_id, livre_id))
#         last_inserted_toko = cursor.fetchone()[0]

#         # Iterate through andininy entries in the section
#         for andininy_numero, andininy_text in andininy_data.items():
#             # Inserting andininy record
#             cursor.execute('''
#                 INSERT INTO andininy (numero, textAndininy, numToko, idToko)
#                 VALUES (?, ?, ?, ?)
#             ''', (andininy_numero, andininy_text, toko_id, last_inserted_toko))
#             conn.commit()

#             print(f"Andininy record inserted successfully for Livre ID {livre_id}, Section Numero {toko_id}, Andininy Numero {andininy_numero}")

#         print(f"All Andininy records inserted successfully for Livre ID {livre_id}, Section Numero {toko_id}")

#     except sqlite3.Error as e:
#         print(f"Error inserting Andininy records: {e}")

# def main():
#     # Specify the path to your SQLite database file
#     database_path = r'A:\PROJECTS\Mobile\perikopa_flutter\assets\perikopa.db'

#     # Test the database connection
#     conn = test_database_connection(database_path)

#     if conn:
#         # Specify the path to the directory containing JSON files
#         json_folder = r'C:\Users\mercia\Desktop\perikopa\src\livre\Testameta vaovao'

#         # Iterate through JSON files
#         for filename in os.listdir(json_folder):
#             if filename.endswith('.json'):
#                 with open(os.path.join(json_folder, filename), 'r', encoding='utf-8') as json_file:
#                     data = json.load(json_file)

#                     # Fetch Livre ID based on meta name
#                     cursor = conn.cursor()
#                     cursor.execute('''
#                         SELECT id
#                         FROM Livre
#                         WHERE nom = ?
#                     ''', (data['meta']['name'],))
                    
#                     livre_id_row = cursor.fetchone()

#                     if livre_id_row:
#                         livre_id = livre_id_row[0]

#                         for section_numero, section_data in data.items():
#                             # Insert Andininy records
#                             insert_andininy(conn, livre_id, section_numero, section_data)
#                             print( section_numero, section_data)

#         # Close the database connection
#         conn.close()
#         print("Database connection closed.")

# if __name__ == "__main__":
#     main()

# # DELETE FROM andininy;
# # DELETE FROM toko;
# # UPDATE SQLITE_SEQUENCE SET seq = 0 WHERE name = 'andininy';
# # UPDATE SQLITE_SEQUENCE SET seq = 0 WHERE name = 'toko';






import sqlite3
import json

# Fonction pour créer la table dans la base de données SQLite
def create_table(cursor):
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS books (
            id TEXT,
            type TEXT,
            book_type TEXT,
            toko INTEGER,
            text TEXT
        )
    ''')

# Fonction pour insérer des données dans la table
def insert_data(cursor, data):
    for item in data["body"]:
        # print(item)
        for book in item["books"]:
            print(book["texts"])
            for text in book["texts"]:
                cursor.execute('''
                    INSERT INTO books (id, type, book_type, toko, text)
                    VALUES (?, ?, ?, ?, ?)
                ''', (item["id"], item["type"], book["type"], book["toko"], text))

# Fonction principale
def main():
    # Charger les données JSON à partir d'un fichier
    with open('A:\\baiboly.json', 'r', encoding='utf-8') as file:
        json_data = json.load(file)

    # Connexion à la base de données SQLite
    conn = sqlite3.connect(r'A:\PROJECTS\Mobile\perikopa_flutter\assets\perikopa.db')
    cursor = conn.cursor()

    # Créer la table dans la base de données
    create_table(cursor)

    # Insérer les données dans la table
    insert_data(cursor, json_data)

    # Valider les modifications et fermer la connexion
    conn.commit()
    conn.close()

if __name__ == "__main__":
    main()
