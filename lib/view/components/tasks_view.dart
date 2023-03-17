import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/profile.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';
import 'package:taskmate/services/service.dart';

class TasksView extends StatefulWidget {
  TodoList list;
  TasksView({super.key, required this.list});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  Profile profile = Get.find<Profile>();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final Column tasks = Column(
        children: List.generate(widget.list.tasks.length, (index) {
      //? current task in index & the index of the todo list
      final list = widget.list;
      final task = list.tasks[index];
      final listIndex = profile.todoLists.indexOf(list);
      //? calculate the position of the strikethrough line based on text size
      final rightPosition = (task.name.length >= 40)
          ? _width
          : (task.name.length < 40 && task.name.length >= 30)
              ? _width * 3 / 4
              : (task.name.length < 30 && task.name.length >= 20)
                  ? _width / 2
                  : _width / 3;

      return Row(
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  profile.todoLists[listIndex].tasks[index].isDone =
                      !profile.todoLists[listIndex].tasks[index].isDone;
                  MyServices.updateTodoList(widget.list);
                });
              },
              icon: Icon(
                task.isDone
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_unchecked_rounded,
                size: 18,
                color: list.color,
              )),
          Flexible(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Text(
                  task.name,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
                AnimatedPositioned(
                  duration: Duration(
                      milliseconds: (task.name.length < 20) ? 250 : 550),
                  left: 0,
                  right: task.isDone ? 0 : rightPosition,
                  child: Container(
                    height: 1.4,
                    decoration: const BoxDecoration(color: MyColors.uiButton),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }));
    return Container(
      color: MyColors.bg,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: tasks,
          )),
    );
  }
}
