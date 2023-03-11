class Task {
  String name;
  bool isDone;

  Task({required this.name, required this.isDone});

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      name: map['name'],
      isDone: map['isDone']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isDone': isDone,
    };
  }
}
