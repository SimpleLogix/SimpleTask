import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/task.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';
import 'package:taskmate/services/service.dart';
import 'package:taskmate/view/components/tasks_view.dart';
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
  TextEditingController inputController = TextEditingController();
  late FocusNode textNode; // focus node to find text input to activate
  //? delta x and y offset for user swipe detection
  //? easier to detect when and where user is swiping from and respond accordingly
  double dy = 0;
  double dx = 0;
  final threshold = 50;
  bool isTextformEnabled = false;
  @override
  void initState() {
    super.initState();
    textNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    isTextformEnabled ? textNode.requestFocus() : null;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          dy = 0;
          isTextformEnabled = false;
        });
      },
      onVerticalDragUpdate: (details) {
        //? if the swipe gesture is between the threshold, drag down and keep
        if (dy + details.primaryDelta! >= 0 &&
            dy + details.primaryDelta! < 100) {
          setState(() {
            dy += details.primaryDelta!;
          });
        }
      },
      onVerticalDragEnd: (details) {
        if (dy < threshold) {
          setState(() {
            isTextformEnabled = false;
            dy = 0;
          });
        } else {
          setState(() {
            dy = 100;
            isTextformEnabled = true;
          });
        }
      },

      //? the first translate is to move the screen based on the user input (dy)
      child: Material(
        color: MyColors.bg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Transform.translate(
              offset: Offset(0, dy - 100),
              child: Column(
                children: [
                  ColoredBox(
                    color: MyColors.bg,
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Add a New Task",
                            style: TextStyle(color: MyColors.uiButton),
                          ),
                          Icon(
                            widget.list.icon,
                            color: widget.list.color,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      focusNode: textNode,
                      controller: inputController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.uiButton,
                            width: 1,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.uiButton,
                            width: 1,
                          ),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          //close keyboard
                          isTextformEnabled = false;
                          textNode.unfocus();
                          dy = 0;
                          // save task
                          if (value.isNotEmpty) {
                            final task = Task(
                              name: value,
                              isDone: false,
                              isImportant: false,
                            );
                            final idx = profile.todoLists.indexOf(widget.list);
                            widget.list.tasks.add(task);
                            profile.todoLists[idx] = widget.list;
                            inputController.text = "";
                            MyServices.updateTodoList(widget.list);
                          }
                        });
                      },
                      onTap: () {
                        setState(() {
                          dy = 100;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 22,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.keyboard_double_arrow_down_rounded,
                          color: widget.list.color,
                          size: 12,
                        ),
                        Text(
                          "Swipe down to add a task",
                          style: TextStyle(
                            color: widget.list.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_double_arrow_down_rounded,
                          color: widget.list.color,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TasksView(list: widget.list),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        dy = 0;
                        inputController.text = "";
                      });
                      controller.animateToPage(controller.page!.toInt() - 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_left_rounded,
                      size: 32,
                      color: MyColors.uiButton,
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        dy = 0;
                        inputController.text = "";
                      });
                      controller.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    icon: const Icon(
                      Icons.home_rounded,
                      size: 32,
                      color: MyColors.uiButton,
                    )),
                Text(
                  widget.list.name,
                  style: TextStyle(
                    color: widget.list.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        dy = 0;
                        inputController.text = "";
                      });
                      controller.animateToPage(controller.page!.toInt() + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 32,
                      color: MyColors.uiButton,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
