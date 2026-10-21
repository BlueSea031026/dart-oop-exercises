// Model công việc: id, title, description, isCompleted
class Task {
  int? id;
  String title;
  String description;
  bool isCompleted;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  // Task -> Map 
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  // Map (đọc từ SQLite) -> Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isCompleted: map['isCompleted'] == 1,
    );
  }

  Task copyWith({String? title, String? description, bool? isCompleted}) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
