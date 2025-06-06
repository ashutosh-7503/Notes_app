import "package:sqflite/sqflite.dart" as sqflite;
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  NotesDatabase._init();
  static sqflite.Database? _database;

  Future<sqflite.Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<sqflite.Database> _initDB(String filepath) async {
    final dbPath = await sqflite.getDatabasesPath();
    final path = join(dbPath, filepath);
    return await sqflite.openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(sqflite.Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        date TEXT NOT NULL,
        color INTEGER NOT NULL DEFAULT 0 
      )
      ''');
  }

  Future<int> addNote(
    String title,
    String description,
    String date,
    int color,
  ) async {
    final db = await instance.database;
    try {
      return await db.insert('notes', {
        'title': title,
        'description': description,
        'date': date,
        'color': color,
      });
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await instance.database;
    try {
      return await db.query('notes', orderBy: 'date DESC');
    } catch (e) {
      throw Exception('Failed to get notes: $e');
    }
  }

  Future<int> updateNote(
    String title,
    String description,
    String date,
    int color,
    int id,
  ) async {
    final db = await instance.database;
    try {
      return await db.update(
        'notes',
        {
          'title': title,
          'description': description,
          'date': date,
          'color': color,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    try {
      return await db.delete(
        'notes',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }

  Future close() async {
    final db = await instance.database;
    _database = null;
    await db.close();
  }
}