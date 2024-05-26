import 'dart:convert';

import 'package:deptechcodingtest/data/local/model/event.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user.dart';

class EventDatabase {
  static const String TABLE_NAME = "events";  // Nama tabel pengguna
  static const String COLUMN_ID = "id";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_DESC = "desc";
  static const String COLUMN_DATE = "date";
  static const String COLUMN_TIME = "time";
  static const String COLUMN_REMINDER_TIME = "reminderTime";
  static const String COLUMN_PIC = "pic";

  final Database db;

  EventDatabase(this.db) {
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
        $COLUMN_ID INTEGER PRIMARY KEY,
        $COLUMN_TITLE TEXT,
        $COLUMN_DESC TEXT,
        $COLUMN_DATE TEXT,
        $COLUMN_TIME TEXT,
        $COLUMN_REMINDER_TIME TEXT,
        $COLUMN_PIC TEXT
      )
    """;
  }

  Future<int> insertEvent(Event event) async {
    final Database db = await openDatabase(TABLE_NAME);
    final id = await db.insert(TABLE_NAME, event.toJson());
    return id;
  }

  Future<List<Event>?> getEvents() async {
    final Database db = await openDatabase(TABLE_NAME);
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
    print("events $maps");
    return List.generate(maps.length, (i) => Event.fromJson(maps[i]));
  }

  Future<Event?> getEventsbyId(int id) async {
    final Database db = await openDatabase(TABLE_NAME);
    final List<Map<String, dynamic>> maps = await db.query(
      TABLE_NAME,
      where: '$COLUMN_ID = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Event.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateEvents(int id, Event event) async {
    final Database db = await openDatabase(TABLE_NAME);
    final int count = await db.update(
      TABLE_NAME,
      event.toJson(),
      where: '$COLUMN_ID = ?',
      whereArgs: [id]
    );
    return count;
  }

  Future<void> dropTable() async {
    final db = await openDatabase(TABLE_NAME);
    await db.execute("DROP TABLE IF EXISTS $TABLE_NAME");
  }
}
