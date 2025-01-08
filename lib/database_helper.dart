import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'services.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE services(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      icon TEXT,
      plan TEXT,
      duration TEXT,
      endDate TEXT
    )''');
  }

  // Insert service into the database
  Future<void> insertService(Map<String, dynamic> service) async {
    final db = await database;
    await db.insert('services', service);
  }

  // Retrieve all services from the database
  Future<List<Map<String, dynamic>>> getServices() async {
    final db = await database;
    return await db.query('services');
  }
}
