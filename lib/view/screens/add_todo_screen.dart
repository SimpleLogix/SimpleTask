import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/profile.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';
import 'dart:math';

import 'package:taskmate/services/service.dart';

class AddTodoScreen extends StatefulWidget {
  // call back is called when user presses save
  // will take in the todo list user created
  Function(TodoList todo, bool isUnique) callback;
  AddTodoScreen({super.key, required this.callback});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  static final rng = Random();
  int iconIdx = 0;
  int colorIdx = rng.nextInt(MyWidgets.iconsData.length);
  final controller = Get.find<PageController>();
  final user = Get.find<Profile>();
  String errTxt = "";
  bool isUnique = false;
  TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //? get a list of names of all the current to do lists, which will be used
    //? to check on the submitted to do list name
    List<String> listNames =
        user.todoLists.map((todoList) => todoList.name).toList();

    //? Generate icons for the gridview
    List<InkWell> icons = List.generate(
        MyWidgets.iconsData.length,
        (index) => InkWell(
              onTap: () {
                setState(() {
                  FocusScope.of(context).unfocus();
                  iconIdx = index;
                  if (listNames.contains(inputController.text.toString())) {
                    isUnique = false;
                  } else {
                    isUnique = true;
                  }
                });
              },
              customBorder: const CircleBorder(),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: (iconIdx == index)
                      ? MyWidgets.colorList[colorIdx]
                      : MyColors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(MyWidgets.iconsData[index]),
              ),
            ));
    //? Generate the colors for the gridview
    List<Widget> colors = List.generate(
      MyWidgets.colorList.length,
      (index) => InkWell(
        onTap: () {
          setState(() {
            FocusScope.of(context).unfocus();
            colorIdx = index;
          });
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: MyWidgets.colorList[index],
            shape: BoxShape.circle,
          ),
          child: SizedBox(
            width: 5,
            height: 5,
            child: Icon(
              Icons.close_rounded,
              size: (colorIdx == index) ? 12 : 0,
            ),
          ),
        ),
      ),
    );
    //? This is the border for the input field, which changes colors based on colorIdx
    //? Reused multiple times; made sense to make a single one and reuse
    final borderDeco = OutlineInputBorder(
        borderSide: BorderSide(color: MyWidgets.colorList[colorIdx]),
        borderRadius: const BorderRadius.all(Radius.circular(12)));

    //? Gesture detector to capture tap to close keyboard
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        if (listNames.contains(inputController.text.toString())) {
          isUnique = false;
        } else {
          isUnique = true;
        }
      },
      child: ColoredBox(
        color: MyColors.bg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 18, 18, 0),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    controller.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear,
                    );
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    color: MyColors.uiButton,
                    size: 40,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Name",
                        style: TextStyle(
                          color: MyColors.darkTxt,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: inputController,
                      onFieldSubmitted: (val) {},
                      decoration: InputDecoration(
                        fillColor: MyWidgets.colorList[colorIdx],
                        border: borderDeco,
                        hintText: "To-do list name",
                        focusedBorder: borderDeco,
                        enabledBorder: borderDeco,
                      ),
                    ),
                    Center(
                      child: Text(
                        (inputController.text.isEmpty || !isUnique)
                            ? "Unique list name required"
                            : "",
                        style: const TextStyle(
                            color: MyColors.Pomegranate, fontSize: 11),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Icon",
                      style: TextStyle(
                        color: MyColors.darkTxt,
                        fontSize: 22,
                      ),
                    ),
                    Flexible(
                      child: GridView.count(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        children: icons,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Color",
                      style: TextStyle(
                        color: MyColors.darkTxt,
                        fontSize: 22,
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        children: colors,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => widget.callback(
                TodoList(
                  name: inputController.text.toString(),
                  color: MyWidgets.colorList[colorIdx],
                  icon: MyWidgets.iconsData[iconIdx],
                  tasks: [],
                ),
                isUnique,
              ),
              onTapUp: (up) {
                setState(() {
                  //? checking all the list names and if the user entered a unique list name
                  if (listNames.contains(inputController.text.toString())) {
                    isUnique = false;
                  } else {
                    isUnique = true;
                  }
                });
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                color: MyWidgets.colorList[colorIdx],
                height: 90,
                child: const Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 36,
                        color: MyColors.lightTxt,
                        fontFamily: 'monospace'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
