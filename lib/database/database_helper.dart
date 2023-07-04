import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'my_database.db');

    final database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY KEY, name TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY, category_id INTEGER, title TEXT, content TEXT)');
    });

    return database;
  }

  Future<void> kategoriEkle(String kategoriAdi) async {
    final db = await database;
    await db.insert('categories', {'name': kategoriAdi});
  }

  Future<void> notEkle(int kategoriId, String baslik, String icerik) async {
    final db = await database;
    await db.insert('notes',
        {'category_id': kategoriId, 'title': baslik, 'content': icerik});
  }

  Future<List<Map<String, dynamic>>> getNotesByCategory(
      String categoryId) async {
    final db = await database;
    return db.query('notes', where: 'category_id = ?', whereArgs: [categoryId]);
  }

  Future<void> updateNote(int noteId, String title, String content) async {
    final db = await database;
    await db.update('notes', {'title': title, 'content': content},
        where: 'id = ?', whereArgs: [noteId]);
  }

  Future<void> deleteNote(int noteId) async {
    final db = await database;
    await db.delete('notes', where: 'id = ?', whereArgs: [noteId]);
  }

  Future<void> deleteCategory(int categoryId) async {
    final db = await database;
    await db.delete('categories', where: 'id = ?', whereArgs: [categoryId]);
    await db.delete('notes', where: 'category_id = ?', whereArgs: [categoryId]);
  }

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    final db = await database;
    return db.query('categories');
  }

  Future<List<String>> getCategories() async {
    final categories = await getAllCategories();
    return List.generate(
        categories.length, (index) => categories[index]['name'].toString());
  }

  Future<List<Map<String, dynamic>>> loadNotes(String categoryId) async {
    final db = await database;
    return db.query('notes', where: 'category_id = ?', whereArgs: [categoryId]);
  }

  Future<void> updateCategoryName(int categoryId, String newName) async {
    final db = await database;
    await db.update('categories', {'name': newName},
        where: 'id = ?', whereArgs: [categoryId]);
  }
}
