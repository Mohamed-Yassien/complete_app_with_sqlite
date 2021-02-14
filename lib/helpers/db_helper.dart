import 'package:dog/models/dog.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'dogs.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)");
      },
    );
  }

  static  Future<void> insertDog(Dog dog) async {
    final db = await DatabaseHelper.database();
    return db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Dog>> getDogs() async {
    final db = await DatabaseHelper.database();
    final List<Map<String, dynamic>> dogs = await db.query('dogs');
    return List.generate(
      dogs.length,
      (index) => Dog(
        id: dogs[index]['id'],
        name: dogs[index]['name'],
        age: dogs[index]['age'],
      ),
    );
  }

  static Future<void> updateDog(Dog dog) async {
    final db = await DatabaseHelper.database();
    await db.update(
      'dogs',
      dog.toMap(),
      where: "id = ?",
      whereArgs: [dog.id],
    );
  }

  static Future<void> deleteDog(int id) async {
    final db = await DatabaseHelper.database();
    await db.delete(
      'dogs',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
