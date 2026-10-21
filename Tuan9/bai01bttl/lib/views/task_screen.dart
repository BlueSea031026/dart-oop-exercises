import 'package:flutter/material.dart';
import 'package:bai01bttl/controllers/task_controller.dart';
import 'package:bai01bttl/models/task.dart';
import 'package:bai01bttl/views/task_detail.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> _tasks = [];
  final TaskController _taskController = TaskController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Task? _selectedTask; // công việc đang được chọn (để xoá)

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _fetchTasks() async {
    final tasks = await _taskController.fetchTasks();
    setState(() => _tasks = tasks);
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _addTask() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    if (title.isEmpty) {
      _showMessage('Vui lòng nhập Title');
      return;
    }
    if (await _taskController.isTaskExist(title)) {
      _showMessage('Công việc "$title" đã tồn tại');
      return;
    }
    // id để null -> SQLite tự tăng
    await _taskController.insertTask(Task(title: title, description: description));
    titleController.clear();
    descriptionController.clear();
    _selectedTask = null;
    await _fetchTasks();
  }

  Future<void> _deleteTask() async {
    if (_tasks.isEmpty) return;
    // Xoá công việc đang chọn; nếu chưa chọn thì xoá công việc cuối (như bài mẫu)
    final task = _selectedTask ?? _tasks.last;
    await _taskController.deleteTask(task.id!);
    titleController.clear();
    descriptionController.clear();
    _selectedTask = null;
    await _fetchTasks();
  }

  // Bài tập 1: mở màn hình chi tiết, nhận kết quả trả về rồi tải lại danh sách
  Future<void> _openDetail(Task task) async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => TaskDetail(task: task)),
    );
    if (changed == true) await _fetchTasks();
  }

  InputDecoration _decoration(String label, TextStyle style) => InputDecoration(
        labelText: label,
        labelStyle: style,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      );

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.titleMedium!;
    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: _decoration('Title', textStyle)),
            const SizedBox(height: 10.0),
            TextField(
              controller: descriptionController,
              decoration: _decoration('Description', textStyle),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(onPressed: _addTask, child: const Text('Add Task')),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(onPressed: _deleteTask, child: const Text('Delete Task')),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  final selected = _selectedTask?.id == task.id;
                  return Card(
                    color: task.isCompleted ? Colors.green[100] : Colors.white,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: selected
                          ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
                          : BorderSide.none,
                    ),
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _openDetail(task),
                      ),
                      onTap: () {
                        setState(() => _selectedTask = task);
                        titleController.text = task.title;
                        descriptionController.text = task.description;
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
