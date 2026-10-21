import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Lớp kết nối CSDL SQLite (Singleton - cả app chỉ dùng 1 kết nối).
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static const String _dbName = 'bai02bttl.db';
  static const int _dbVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _dbName);
    return openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Bài tập 2 trên lớp: quản lý sinh viên
    await db.execute('''
      CREATE TABLE sinhvien (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');

    // Dữ liệu mẫu cho màn hình sinh viên
    await db.insert('sinhvien', {'name': 'Nguyen Van A', 'email': 'a@example.com'});
    await db.insert('sinhvien', {'name': 'Nguyen Van B', 'email': 'b@example.com'});
    await db.insert('sinhvien', {'name': 'An Binh Tran', 'email': 'abt@abc.com'});
  }
}
