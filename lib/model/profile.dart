import 'package:get/get.dart';
import 'package:taskmate/model/todo_list.dart';

/// Profile class holds data about user including lists since GetX cant put down lists
///
class Profile extends GetxController {
  List<TodoList> todoLists;

  Profile({required this.todoLists});

  factory Profile.empty() {
    return Profile(todoLists: []);
  } 

}
