import 'package:bai01btvn/models/chi_tieu.dart';
import 'package:bai01btvn/utils/database_helper.dart';

class ChiTieuController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  static const String _table = 'chitieu';

  // Dùng query()
  Future<List<ChiTieu>> getAll() async {
    final db = await _dbHelper.database;
    final maps = await db.query(_table, orderBy: 'ngayTao DESC');
    return maps.map((m) => ChiTieu.fromMap(m)).toList();
  }

  Future<int> insert(ChiTieu ct) async {
    final db = await _dbHelper.database;
    return db.insert(_table, ct.toMap());
  }

  Future<int> update(ChiTieu ct) async {
    final db = await _dbHelper.database;
    return db.update(_table, ct.toMap(), where: 'id = ?', whereArgs: [ct.id]);
  }

  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  // Dùng rawQuery()
  Future<double> getTongTien() async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery('SELECT SUM(soTien) AS total FROM $_table');
    return (result.first['total'] as num?)?.toDouble() ?? 0;
  }
}
