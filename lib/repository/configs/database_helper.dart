import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'TodoListDatabase.db';
  static const _databaseVersion = 3;

  // Singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  //init DB in singleton mode
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Handle database upgrades
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('ALTER TABLE tasks ADD COLUMN description TEXT');
  }

  //Create table if not exist
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        done INTEGER DEFAULT 0,
        create_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  //close DB
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
