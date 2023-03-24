import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmate/model/todo_list.dart';

class MyServices {
  //? creates or updates a pre-existing to list in the docs
  static void createTodoList(TodoList list) async {
    // connect to shared prefs
    final prefs = await SharedPreferences.getInstance();
    // final local path of docs
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    // encode to do list and write to file
    final jsonString = json.encode(list.toMap());
    File file = File('$path/${list.name}.json');
    file.writeAsStringSync(jsonString);
    //save to prefs
    final todoListNames = prefs.getStringList("todoListNames");
    if (todoListNames == null || todoListNames.isEmpty) {
      prefs.setStringList("todoListNames", [list.name]);
    } else {
      todoListNames.add(list.name);
      prefs.setStringList("todoListNames", todoListNames);
    }
  }

  //? get list of todo list names and files:
  static Future<List<TodoList>> getTodoLists() async {
    // list to be returned
    List<TodoList> todoLists = [];
    // connect to shared prefs
    final prefs = await SharedPreferences.getInstance();
    // Find the local path of the directories
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    // Get a list of todo names and files
    final todoListNames = prefs.getStringList("todoListNames");
    if (todoListNames == null || todoListNames.isEmpty) {
      return todoLists; // return empty
    } else {
      // parse through the list of names and read their files into an object
      for (String list in todoListNames) {
        File file = File('$path/$list.json');
        final content = await file.readAsString();
        final map = json.decode(content);
        final TodoList todo = TodoList.fromJson(map);
        todoLists.add(todo);
      }
      return todoLists;
    }
  }

  //? removes a todo list from shared prefs and user docs
  static void removeTodoList(TodoList list) async {
    // connect to shared prefs
    final prefs = await SharedPreferences.getInstance();
    // Find the local path of the directories
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    // change shared prefs
    final todoNames = prefs.getStringList("todoListNames");
    if (todoNames != null && todoNames.isNotEmpty) {
      todoNames.remove(list.name);
      prefs.setStringList("todoListNames", todoNames);
    }

    // remove doc from path
    File file = File('$path/${list.name}.json');
    file.delete();
  }

  //? works similar to adding a list but no need to access shared prefs
  static void updateTodoList(TodoList newList, TodoList oldList) async {
    // Find the local path of the directories
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    // encode to do list and write to file
    final jsonString = json.encode(newList.toMap());
    File file = File('$path/${oldList.name}.json');
    file.writeAsStringSync(jsonString);
    //? on name change update file name
    if (newList.name != oldList.name) {
      final newFile = File('$path/${newList.name}.json');
      await file.rename(newFile.path);
      file.writeAsStringSync(jsonString);
      // connect to shared prefs
      final prefs = await SharedPreferences.getInstance();
      List<String> names = prefs.getStringList("todoListNames")!;
      // update name in prefs
      names[names.indexOf(oldList.name)] = newList.name;
      prefs.setStringList("todoListNames", names);
    }
  }

  //? updates the order of lists in shared prefs without touching user docs
  static void updateTodoListOrder(List<TodoList> lists) async {
    // connect to shared prefs
    final prefs = await SharedPreferences.getInstance();
    final names = lists.map((list) => list.name).toList();
    prefs.setStringList("todoListNames", names);
  }
}
