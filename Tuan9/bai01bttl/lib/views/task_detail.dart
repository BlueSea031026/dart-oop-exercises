import 'package:flutter/material.dart';
import 'package:bai01bttl/controllers/task_controller.dart';
import 'package:bai01bttl/models/task.dart';

/// BÀI TẬP 1 (trên lớp): màn hình cập nhật trạng thái công việc.
/// Nhận Task được chọn từ TaskScreen; tick "Completed" -> cập nhật DB -> quay về.
class TaskDetail extends StatefulWidget {
  final Task task;
  const TaskDetail({super.key, required this.task});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  final TaskController _taskController = TaskController();
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.task.isCompleted;
  }

  Future<void> _onCompletedChanged(bool? value) async {
    if (value == null) return;
    setState(() => _isCompleted = value);
    await _taskController.updateStatus(widget.task.id!, value);
    if (!mounted) return;
    Navigator.pop(context, true); // true = có thay đổi, TaskScreen sẽ tải lại
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Title', style: labelStyle),
            const SizedBox(height: 4),
            Text(widget.task.title),
            const SizedBox(height: 16),
            const Text('Description', style: labelStyle),
            const SizedBox(height: 4),
            Text(widget.task.description),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Completed', style: labelStyle),
                Checkbox(value: _isCompleted, onChanged: _onCompletedChanged),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
