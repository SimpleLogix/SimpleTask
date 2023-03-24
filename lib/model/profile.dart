import 'package:get/get.dart';
import 'package:taskmate/model/todo_list.dart';

/// Profile class holds data about user including lists since GetX cant put down lists
///
class Profile extends GetxController {
  List<TodoList> todoLists;
  // These were added to check if user is editing a 
  bool isEditing = false;
  TodoList? editingList;

  Profile({required this.todoLists});

  factory Profile.empty() {
    return Profile(todoLists: []);
  }
}
