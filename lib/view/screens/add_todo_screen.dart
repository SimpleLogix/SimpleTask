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
  int colorIdx = rng.nextInt(MyWidgets.colorList.length);
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
                  gradient: (iconIdx == index)
                      ? MyColors.gradients[MyWidgets.colorList[colorIdx]]
                      : null,
                  shape: BoxShape.circle,
                ),
                child: Icon(MyWidgets.iconsData[index]),
              ),
            ));
    //? Generate the colors for the gridview
    List<Widget> colors = List.generate(
      MyWidgets.colorList.length,
      (index) => Material(
        elevation: 4.0,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () {
            setState(() {
              FocusScope.of(context).unfocus();
              colorIdx = index;
            });
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.uiButton, width: 0.5),
              gradient: MyColors.gradients[MyWidgets.colorList[index]],
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 10,
              height: 10,
              child: Icon(
                Icons.check_rounded,
                size: (colorIdx == index) ? 24 : 0,
                color: MyColors.pressed,
              ),
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
          mainAxisAlignment: MainAxisAlignment.start,
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
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            color: MyColors.darkTxt,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: inputController,
                        onFieldSubmitted: (val) {
                          setState(() {
                            //? checking all the list names and if the user entered a unique list name
                            if (listNames
                                .contains(inputController.text.toString())) {
                              isUnique = false;
                            } else {
                              isUnique = true;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: MyWidgets.colorList[colorIdx],
                          border: borderDeco,
                          hintText: "To-do list name",
                          focusedBorder: borderDeco,
                          enabledBorder: borderDeco,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Center(
                        child: Text(
                          (inputController.text.isEmpty || !isUnique)
                              ? "Unique list name required"
                              : "",
                          style: const TextStyle(
                              color: MyColors.Pomegranate, fontSize: 11),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Text(
                        "Icon",
                        style: TextStyle(
                          color: MyColors.darkTxt,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 8,
                        children: icons,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Text(
                      "Color",
                      style: TextStyle(
                        color: MyColors.darkTxt,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.all(8),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      children: colors,
                    ),
                  ),
                ],
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
                height: 90,
                decoration: BoxDecoration(
                    gradient: MyColors.gradients[MyWidgets.colorList[colorIdx]],
                    border: Border.all(color: MyColors.uiButton)),
                child: Center(
                  child: Text(
                    "Create",
                    style: TextStyle(
                        fontSize: 36,
                        color: (MyWidgets.colorList[colorIdx] ==
                                MyColors.SunFlower)
                            ? Colors.black87
                            : MyColors.lightTxt,
                        fontFamily: 'roboto'),
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
