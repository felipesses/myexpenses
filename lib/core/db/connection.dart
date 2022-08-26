// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'myexpenses.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(_user);
    await db.execute(_income);
    await db.execute(_transaction);
    await db.execute(_saving);
    await db.insert('user', {'id': 1});
  }
}

String get _user => '''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT
    );
  ''';

String get _income => '''
    CREATE TABLE income (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      value REAL,
      year INTEGER,
      month INTEGER
    );
  ''';

String get _transaction => '''
    CREATE TABLE transactions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      value REAL,
      month INTEGER,
      year INTEGER,
      category INTEGER,
      emojiTitle TEXT
    );
  ''';

String get _saving => '''
    CREATE TABLE savings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      value REAL,
      currentAmount REAL,
      objective REAL,
      month INTEGER,
      year INTEGER
    );
  ''';
