import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

//singleton class to handle database operations

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  static DatabaseHelper get instance => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'inventory.db');
    await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE branches (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          address TEXT NOT NULL,
          email TEXT NOT NULL,
          phoneNumber TEXT NOT NULL
        )
      ''');

        await db.execute('''
  CREATE TABLE inventory_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    sku TEXT NOT NULL UNIQUE,
    category TEXT NOT NULL,
    subcategory TEXT NOT NULL,
    brand TEXT NOT NULL,
    isActive INTEGER NOT NULL DEFAULT 1
  )
''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE inventory_items ADD COLUMN isActive INTEGER NOT NULL DEFAULT 1',
          );
        }
      },
    );
  }
}
