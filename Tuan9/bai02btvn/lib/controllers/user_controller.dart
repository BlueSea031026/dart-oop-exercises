import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:bai02btvn/models/user.dart';
import 'package:bai02btvn/utils/database_helper.dart';

class UserController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  static const String _table = 'users';

  
  String _hash(String password) => sha256.convert(utf8.encode(password)).toString();

  Future<bool> isEmailExist(String email) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      _table,
      where: 'email = ?',
      whereArgs: [email.trim().toLowerCase()],
    );
    return maps.isNotEmpty;
  }


  Future<bool> register(String email, String password) async {
    if (await isEmailExist(email)) return false;
    final db = await _dbHelper.database;
    final user = User(email: email.trim().toLowerCase(), password: _hash(password));
    await db.insert(_table, user.toMap());
    return true;
  }


  Future<User?> login(String email, String password) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      _table,
      where: 'email = ? AND password = ?',
      whereArgs: [email.trim().toLowerCase(), _hash(password)],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return User.fromMap(maps.first);
  }
}
