import 'package:flutter/material.dart';
import 'package:taskmate/model/task.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';

class TodoCard extends StatefulWidget {
  TodoList list;
  TodoCard({super.key, required this.list});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
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
    // Build the components going into the Todo Card-
    // The text:
    final text = Padding(
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
    );
    return Stack(
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
                child: text,
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
              style: TextStyle(
                color: MyColors.lightTxt,
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
  }
}
