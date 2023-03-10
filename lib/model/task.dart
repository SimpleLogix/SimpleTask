class Task {
  String name;

  Task({required this.name});

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
