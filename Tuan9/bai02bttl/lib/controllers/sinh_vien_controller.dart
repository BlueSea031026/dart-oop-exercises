import 'package:bai02bttl/models/sinh_vien.dart';
import 'package:bai02bttl/utils/database_helper.dart';

class SinhVienController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  static const String _table = 'sinhvien';

  Future<List<SinhVien>> getAll() async {
    final db = await _dbHelper.database;
    final maps = await db.query(_table, orderBy: 'id ASC');
    return maps.map((m) => SinhVien.fromMap(m)).toList();
  }

  // Tìm theo tên hoặc email
  Future<List<SinhVien>> search(String keyword) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      _table,
      where: 'name LIKE ? OR email LIKE ?',
      whereArgs: ['%$keyword%', '%$keyword%'],
      orderBy: 'id ASC',
    );
    return maps.map((m) => SinhVien.fromMap(m)).toList();
  }

  Future<int> insert(SinhVien sv) async {
    final db = await _dbHelper.database;
    // id = null -> SQLite tự sinh id
    return db.insert(_table, sv.toMap());
  }

  Future<int> update(SinhVien sv) async {
    final db = await _dbHelper.database;
    return db.update(_table, sv.toMap(), where: 'id = ?', whereArgs: [sv.id]);
  }

  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
