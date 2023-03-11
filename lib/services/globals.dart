import 'package:flutter/material.dart';
import 'package:taskmate/model/todo_list.dart';

import '../model/task.dart';

class MyColors {
  // colors for pallete
  static const Color bg = Color(0xffECF0F1);
  static const Color main = Color(0xff2980B9);
  static const Color lightTxt = Color(0xffECF0F1);
  static const Color darkTxt = lightTxt;

  // colors for ui components
  static const Color pressed = Color(0xaaeeeeee);
  static const badge = Color(0xdd444554);
}

class MyWidgets {
  static Widget addCard = IconButton(
      onPressed: () {
        debugPrint("+++");
      },
      icon: Card(
        elevation: 20,
        color: Colors.grey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: ColoredBox(color: Colors.black45),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(14),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: ColoredBox(color: Colors.grey),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Expanded(
                    flex: 5,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      child: ColoredBox(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Expanded(
                    flex: 5,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      child: ColoredBox(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(),
                  ),
                ],
              ),
              const Center(
                  child: Icon(
                Icons.add,
                size: 64,
                color: Colors.white,
              )),
            ],
          ),
        ),
      ));

  static List<TodoList> sampleList = [
    TodoList(
      name: "Health",
      color: Colors.red[800]!,
      icon: Icons.heart_broken,
      tasks: [
        Task(name: "name", isDone: false, isImportant: false),
        Task(name: "name", isDone: true, isImportant: true)
      ],
    ),
    TodoList(
      name: "Life",
      color: Colors.amber[700]!,
      icon: Icons.star_border_purple500_outlined,
      tasks: [
        Task(name: "name", isDone: true, isImportant: false),
        Task(name: "name", isDone: true, isImportant: true)
      ],
    ),
    TodoList(
      name: "Work",
      color: Colors.greenAccent[700]!,
      icon: Icons.cases_outlined,
      tasks: [
        Task(name: "name", isDone: true, isImportant: false),
        Task(name: "name", isDone: true, isImportant: true)
      ],
    )
  ];
}
