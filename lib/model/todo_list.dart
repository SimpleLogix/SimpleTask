import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/task.dart';

class TodoList {
  String name;
  Color color;
  IconData icon;
  List<Task> tasks;

  // Default Constructor
  TodoList(
      {required this.name,
      required this.color,
      required this.icon,
      required this.tasks});

  // Json Constructor
  factory TodoList.fromJson(Map<String, dynamic> map) {
    // parse tasks from list of maps to list of task objects
    List<Task> tasks = [];
    for (Map<String, dynamic> task in map['tasks']) {
      tasks.add(Task.fromJson(task));
    }
    return TodoList(
      name: map['name'],
      color: Color(map['color']),
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
      tasks: tasks,
    );
  }

  // Serialize object into a map
  Map<String, dynamic> toMap() {
    // convert list of task objects into a list of maps representing the tasks
    List<Map<String, dynamic>> tasks = [];
    for (Task task in this.tasks) {
      tasks.add(task.toMap());
    }
    return {
      'name': name,
      'color': color.value,
      'icon': icon.codePoint,
      'tasks': tasks,
    };
  }
}
