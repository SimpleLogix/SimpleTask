import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/profile.dart';
import 'package:taskmate/model/task.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';
import 'package:taskmate/services/service.dart';
import 'package:taskmate/view/todo_screen.dart';

class TodoCard extends StatefulWidget {
  TodoList list;
  TodoCard({super.key, required this.list});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  PageController controller = Get.put(PageController(initialPage: 0));
  @override
  Widget build(BuildContext context) {
    // grab to do list from widget and do some quick maths
    TodoList list = widget.list;
    int done = 0;
    for (Task task in list.tasks) {
      if (task.isDone) {
        done++;
      }
    }

    return IconButton(
      onPressed: () {
        // get user todo's and find index of selected todo
        Profile user = Get.find<Profile>();
        final int index = user.todoLists.indexOf(list) + 1;

        controller.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      },
      highlightColor: MyColors.pressed,
      icon: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Card(
                elevation: 20,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                color: list.color,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 45),
                    child: Text(
                      list.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: MyColors.lightTxt,
                        fontSize: 18,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 45,
            height: 45,
            margin: const EdgeInsets.fromLTRB(0, 0, 4, 4),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              color: MyColors.badge,
            ),
            child: Icon(
              list.icon,
              color: MyColors.lightTxt,
            ),
          ),
          Container(
            height: 10,
            width: 200,
            margin: const EdgeInsets.fromLTRB(4, 0, 48, 4),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
              ),
              color: MyColors.badge,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(13, 0, 0, 18),
              child: Text(
                "${done.toString()} / ${list.tasks.length.toString()}",
                style: const TextStyle(
                  color: MyColors.lightTxt,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
