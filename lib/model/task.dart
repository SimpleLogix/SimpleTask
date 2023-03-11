class Task {
  String name;
  bool isDone;
  bool isImportant;

  Task({required this.name, required this.isDone, required this.isImportant});

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      name: map['name'],
      isDone: map['isDone'],
      isImportant: map['isImportant'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isDone': isDone,
      'isImportant': isImportant,
    };
  }
}
