import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/profile.dart';
import 'package:taskmate/model/task.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';
import 'package:taskmate/services/services.dart';
import 'package:taskmate/view/components/shake_widget.dart';

class TasksView extends StatefulWidget {
  final TodoList list;
  const TasksView({super.key, required this.list});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  Profile profile = Get.find<Profile>();
  late List<bool> pressedTasks =
      List.generate(widget.list.tasks.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    // update list with new tasks without rebuilding the list and losing old values
    //? if pressed tasks and tasks length font match that means a task was added
    while (pressedTasks.length < widget.list.tasks.length) {
      pressedTasks.insert(0, false);
    }
    final _width = MediaQuery.of(context).size.width;
    final list = widget.list;
    if (list.tasks.length > 1) {
      list.tasks = stableSort(list.tasks);
    }

    final listIndex = profile.todoLists.indexOf(list);

    final Column tasks = Column(
        children: List.generate(widget.list.tasks.length, (index) {
      //? current task in index & the index of the todo list
      final task = list.tasks[index];
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
          Padding(
              padding: const EdgeInsets.all(10),
              child: pressedTasks[index]
                  //? if longpressed, show X instead of radio button
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          profile.todoLists[listIndex].tasks.removeAt(index);
                          pressedTasks[index] = false;
                          MyServices.updateTodoList(list, list);
                        });
                      },
                      child: const Icon(
                        Icons.close_rounded,
                        color: MyColors.uiButton,
                        size: 20,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          profile.todoLists[listIndex].tasks[index].isDone =
                              !profile.todoLists[listIndex].tasks[index].isDone;
                          MyServices.updateTodoList(widget.list, widget.list);
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          pressedTasks[index] = !pressedTasks[index];
                        });
                      },
                      child: Icon(
                        task.isDone
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_unchecked_rounded,
                        size: 18,
                        color: MyColors.secondaries[list.color],
                      ),
                    )),
          Flexible(
            child: InkWell(
              onTap: () {
                setState(() {
                  profile.todoLists[listIndex].tasks[index].isDone =
                      !profile.todoLists[listIndex].tasks[index].isDone;
                  MyServices.updateTodoList(widget.list, widget.list);
                });
              },
              onLongPress: () {
                setState(() {
                  pressedTasks[index] = !pressedTasks[index];
                });
              },
              splashFactory: NoSplash.splashFactory,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    ShakeWidget(
                      enabled: pressedTasks[index],
                      child: Text(
                        task.name,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(
                          milliseconds: (task.name.length < 20) ? 350 : 550),
                      left: 0,
                      right: task.isDone ? 0 : rightPosition,
                      child: Container(
                        height: 1.4,
                        decoration:
                            const BoxDecoration(color: MyColors.uiButton),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }));
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.2,
          child: Icon(
            widget.list.icon,
            color: MyColors.secondaries[list.color],
            size: 150,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: tasks,
            )),
      ],
    );
  }

  List<Task> stableSort(List<Task> list) {
    final List<Task> trueList = [];
    final List<Task> falseList = [];
    for (Task task in list) {
      if (task.isDone) {
        trueList.add(task);
      } else {
        falseList.add(task);
      }
    }
    return falseList + trueList;
  }
}
