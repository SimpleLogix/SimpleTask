import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';

import '../../model/profile.dart';

/// displays the selected to do list but also has access to the other todo's in a
/// page view for easy seamless swapping between pages
class TodoScreen extends StatefulWidget {
  TodoList list;
  TodoScreen({super.key, required this.list});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Profile profile = Get.find<Profile>();
  final controller = Get.find<PageController>();

  @override
  Widget build(BuildContext context) {
    TodoList list = widget.list;

    return Material(
      color: list.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                list.name,
                style: TextStyle(color: MyColors.lightTxt),
              )
            ],
          ),
          IconButton(
              onPressed: () {
                controller.animateToPage(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              icon: const Icon(
                Icons.keyboard_arrow_left_rounded,
                size: 48,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
