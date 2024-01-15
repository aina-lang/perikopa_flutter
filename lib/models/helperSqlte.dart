// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:perikopa_flutter/models/Book.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static bool _isInitialized = false;

  static Future<void> _initializeDB() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "perikopa.db");

    await deleteDatabase(dbPath);

    ByteData data = await rootBundle.load("assets/perikopa.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await File(dbPath).writeAsBytes(bytes, flush: true);

    _isInitialized = true;
  }

  static Future<Database> getDB() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "perikopa.db");

    Database database = await openDatabase(dbPath);
    return database;
  }

  static Future<List<Book>?> getAllBook() async {
    final db = await getDB();

    final List<Map<String, dynamic>> maps = await db.query('livres_info');

    return List.generate(maps.length, (index) {
      return Book(
        id: maps[index]['id'],
        code: maps[index]['code'],
        idBook: maps[index]['idBook'],
        order: maps[index]['ordre'],
        name: maps[index]['name'],
      );
    });
  }

  static Future<String> getNomLivre(String code) async {
    final db = await getDB();

    List<Map<String, Object?>> nomLivres = await db.rawQuery('''
      SELECT name
      FROM livres_info
      WHERE code = ?
    ''', [code]);

    print("NOM EXACTE ${nomLivres.first["name"]}");
    return nomLivres.first["name"].toString();
  }

  static Future<List<String>> getAndininyTexts(int toko) async {
    try {
      final db = await getDB();

      List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT text
      FROM andininys
      WHERE idToko = ?
    ''', [toko]);

      await db.close();
      // print(result);
      // Extract andininy texts from the result
      List<String> andininyTexts =
          result.map((row) => row['text'] as String).toList();

      // print(andininyTexts);
      return andininyTexts;
    } catch (e) {
      print("Error fetching andininy: $e");
      return [];
    }
  }

  static Future<int> getTokoValue(String nomLivre, int numero) async {
    try {
      final db = await getDB();

      int livreId = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT id
      FROM books
      WHERE shortName = ?
    ''', [nomLivre])) ?? 0;

      List<Map<String, Object?>> tokoIdResult = await db.rawQuery('''
      SELECT id
      FROM tokos
      WHERE book_id = ?  AND numero= ? 
    ''', [livreId, numero]);

      if (tokoIdResult.isEmpty) {
        return 0;
      }

      int tokoId = tokoIdResult.first['id'] as int;
      print("Livre ID: $livreId");

      return tokoId;
    } catch (e) {
      print("Error fetching toko values: $e");
      return 0;
    }
  }

  static Future<List<String>> getDistinctTokoValues(String nomLivre) async {
    try {
      final db = await getDB();

      List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT DISTINCT numero
      FROM tokos
      WHERE book_id = (SELECT id FROM books WHERE shortName = ?)
    ''', [nomLivre]);

      await db.close();

      List<String> tokoValues =
          result.map((row) => row['numero'].toString()).toList();

      return tokoValues;
    } catch (e) {
      print("Error fetching toko values: $e");
      return [];
    }
  }

  static Future<List<int>> getDistinctNumeroAndininy(
      String nomLivre, String numeroToko) async {
    try {
      final db = await getDB();

      int livreId = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT id
      FROM books
      WHERE shortName = ?
    ''', [nomLivre])) ?? 0;

      List<Map<String, Object?>> tokoIdResult = await db.rawQuery('''
      SELECT id
      FROM tokos
      WHERE book_id = ?  AND numero = ?
    ''', [livreId, numeroToko]);

      if (tokoIdResult.isEmpty) {
        return [];
      }

      int tokoId = tokoIdResult.first['id'] as int;
      print("Livre ID: $livreId");
      print("TOKO ID: $tokoId");

      List<Map<String, Object?>> result = await db.rawQuery('''
      SELECT id
      FROM andininys
      WHERE idToko = ? 
    ''', [tokoId]);

      await db.close();
      print(result);

      List<int> distinctNumeroAndininy =
          result.map((map) => map['numero'] as int).toList();

      return distinctNumeroAndininy;
    } catch (e) {
      print("Error fetching distinctNumeroAndininy: $e");
      return [];
    }
  }

  static Future<int> getAndininyCountForToko(
      String nomLivre, String numeroToko) async {
    try {
      final db = await getDB();

      int livreId = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT id
      FROM books
      WHERE shortName = ?
    ''', [nomLivre])) ?? 0;

      List<Map<String, Object?>> tokoIdResult = await db.rawQuery('''
      SELECT id
      FROM tokos
      WHERE book_id = ? AND numero = ?
    ''', [livreId, numeroToko]);

      if (tokoIdResult.isEmpty) {
        return 0;
      }

      int tokoId = tokoIdResult.first['id'] as int;
      print("Livre ID: $livreId");
      print("TOKO ID: $tokoId");

      List<Map<String, Object?>> result = await db.rawQuery('''
      SELECT COUNT(*) as count
      FROM andininys
      WHERE idToko = ?
    ''', [tokoId]);

      await db.close();
      // print(result);

      int count = result.first['count'] as int;

      print(count);
      return count;
    } catch (e) {
      print("Error fetching andininy count for toko: $e");
      return 0;
    }
  }

  static Future<int> getCountForBook(String nomLivre) async {
    try {
      final db = await getDB();

      int livreId = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT id
      FROM books
      WHERE shortName = ?
    ''', [nomLivre])) ?? 0;

      List<Map<String, Object?>> result = await db.rawQuery('''
      SELECT COUNT(*) as count
      FROM tokos
      WHERE book_id = ?
    ''', [livreId]);

      await db.close();

      int count = result.first['count'] as int;

      print("Livre ID: $livreId");
      print("Nombre de Tokos: $count");

      return count;
    } catch (e) {
      print("Error fetching Toko count for book: $e");
      return 0;
    }
  }

  static Future<String?> getNextBook(String nomLivre) async {
    try {
      final db = await getDB();

      // Récupérer l'ID du livre actuel
      int currentBookId = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT id
      FROM books
      WHERE shortName = ?
    ''', [nomLivre])) ?? 0;

      // Récupérer le nom du livre suivant
      List<Map<String, Object?>> result = await db.rawQuery('''
      SELECT shortName
      FROM books
      WHERE id > ?
      ORDER BY id ASC
      LIMIT 1
    ''', [currentBookId]);

      await db.close();

      // Vérifier si le résultat est vide
      if (result.isNotEmpty) {
        String? nextBook = result.first['shortName'] as String?;
        print("Nom du livre suivant: $nextBook");
        return nextBook;
      } else {
        // Aucun livre suivant trouvé
        print("Aucun livre suivant trouvé.");
        return null;
      }
    } catch (e) {
      print("Erreur lors de la récupération du livre suivant: $e");
      return null;
    }
  }

  static Future<String?> getPreviousBook(String nomLivre) async {
    try {
      final db = await getDB();

      // Récupérer l'ID du livre actuel
      int currentBookId = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT id
      FROM books
      WHERE shortName = ?
    ''', [nomLivre])) ?? 0;

      // Récupérer le nom du livre précédent
      List<Map<String, Object?>> result = await db.rawQuery('''
      SELECT shortName
      FROM books
      WHERE id < ?
      ORDER BY id DESC
      LIMIT 1
    ''', [currentBookId]);

      await db.close();

      // Vérifier si le résultat est vide
      if (result.isNotEmpty) {
        String? previousBook = result.first['shortName'] as String?;
        print("Nom du livre précédent: $previousBook");
        return previousBook;
      } else {
        // Aucun livre précédent trouvé
        print("Aucun livre précédent trouvé.");
        return null;
      }
    } catch (e) {
      print("Erreur lors de la récupération du livre précédent: $e");
      return null;
    }
  }
}
