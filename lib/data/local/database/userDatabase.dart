import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../model/user.dart';

class UserDatabase {
  static const String TABLE_NAME = "users";  // Nama tabel pengguna
  static const String COLUMN_FIRST_NAME = "firstName";
  static const String COLUMN_LAST_NAME = "lastName";
  static const String COLUMN_EMAIL = "email";
  static const String COLUMN_BIRTHDATE = "birthdate";
  static const String COLUMN_GENDER = "gender";
  static const String COLUMN_PASSWORD = "password";
  static const String COLUMN_PROFILE_PIC = "profilePic";

  final Database db;

  UserDatabase(this.db) {
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final db = await openDatabase(TABLE_NAME);  // Nama file database
    // Cek apakah tabel sudah ada
    List<Map<String, dynamic>> tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$TABLE_NAME'");
    if (tables.isEmpty) {
      await db.execute(createTable());
    }
  }

  static String createTable() {
    return """
      CREATE TABLE $TABLE_NAME (
        $COLUMN_FIRST_NAME TEXT,
        $COLUMN_LAST_NAME TEXT,
        $COLUMN_EMAIL TEXT PRIMARY KEY,
        $COLUMN_BIRTHDATE TEXT,
        $COLUMN_GENDER TEXT,
        $COLUMN_PASSWORD TEXT,
        $COLUMN_PROFILE_PIC TEXT
      )
    """;
  }

  Future<int> insertUser(User user) async {
    final Database db = await openDatabase(TABLE_NAME);
    final id = await db.insert(TABLE_NAME, user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<User?> getUserByEmail(String email) async {
    final Database db = await openDatabase(TABLE_NAME);
    final List<Map<String, dynamic>> maps = await db.query(
      TABLE_NAME,
      where: '$COLUMN_EMAIL = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateUserByEmail(String email, User user) async {
    final Database db = await openDatabase(TABLE_NAME);
    final int count = await db.update(
      TABLE_NAME,
      user.toJson(),
      where: '$COLUMN_EMAIL = ?',
      whereArgs: [email],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return count;
  }

  Future<void> dropTable() async {
    final db = await openDatabase(TABLE_NAME);
    await db.execute("DROP TABLE IF EXISTS $TABLE_NAME");
  }
}
