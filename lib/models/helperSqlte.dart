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

    final List<Map<String, dynamic>> maps = await db.query('Livre');
    return List.generate(maps.length, (index) {
      return Book.fromMap(maps[index]);
    });
  }

  static Future<List<String>> getAndininyTexts(int toko) async {
    try {
      final db = await getDB();

      List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT textAndininy
      FROM andininy
      WHERE idToko = ?
    ''', [toko]);

      await db.close();
      print(result);
      // Extract andininy texts from the result
      List<String> andininyTexts =
          result.map((row) => row['textAndininy'] as String).toList();

      print(andininyTexts);
      return andininyTexts;
    } catch (e) {
      print("Error fetching andininy: $e");
      return [];
    }
  }

  static Future<int> getTokoValue(String nomLivre,int numero) async {
    try {
      final db = await getDB();

      int livreId = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT id
      FROM Livre
      WHERE nom = ?
    ''', [nomLivre])) ?? 0;

      List<Map<String, Object?>> tokoIdResult = await db.rawQuery('''
      SELECT id
      FROM toko
      WHERE idLivre = ?  AND numero= ? 
    ''', [livreId,numero]);

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
      FROM toko
      WHERE idLivre = (SELECT id FROM Livre WHERE nom = ?)
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
      FROM Livre
      WHERE nom = ?
    ''', [nomLivre])) ?? 0;

      List<Map<String, Object?>> tokoIdResult = await db.rawQuery('''
      SELECT id
      FROM toko
      WHERE idLivre = ?  AND numero = ?
    ''', [livreId, numeroToko]);

      if (tokoIdResult.isEmpty) {
        return [];
      }

      int tokoId = tokoIdResult.first['id'] as int;
      print("Livre ID: $livreId");
      print("TOKO ID: $tokoId");

      List<Map<String, Object?>> result = await db.rawQuery('''
      SELECT numero
      FROM andininy
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
}