import 'package:bai01bttl/models/task.dart';
import 'package:bai01bttl/utils/database_helper.dart';

class TaskController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Thêm công việc mới
  Future<int> insertTask(Task task) async {
    final db = await _dbHelper.database;
    return db.insert('tasks', task.toMap());
  }

  // Cập nhật công việc
  Future<void> updateTask(Task task) async {
    final db = await _dbHelper.database;
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  // Bài tập 1: chỉ cập nhật trạng thái hoàn thành
  Future<void> updateStatus(int id, bool isCompleted) async {
    final db = await _dbHelper.database;
    await db.update(
      'tasks',
      {'isCompleted': isCompleted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Xoá công việc
  Future<void> deleteTask(int id) async {
    final db = await _dbHelper.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  // Kiểm tra công việc đã tồn tại theo title
  Future<bool> isTaskExist(String title) async {
    final db = await _dbHelper.database;
    final maps = await db.query('tasks', where: 'title = ?', whereArgs: [title]);
    return maps.isNotEmpty;
  }

  // Tìm công việc theo title hoặc description
  Future<List<Task>> searchTasks(String query) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'tasks',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return maps.map((obj) => Task.fromMap(obj)).toList();
  }

  // Lấy tất cả công việc
  Future<List<Task>> fetchTasks() async {
    final db = await _dbHelper.database;
    final maps = await db.query('tasks');
    return maps.map((obj) => Task.fromMap(obj)).toList();
  }
}
