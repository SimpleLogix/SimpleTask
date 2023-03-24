import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/profile.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';
import 'dart:math';

class AddTodoScreen extends StatefulWidget {
  // call back is called when user presses create
  // will take in the todo list user created
  final Function(TodoList todo) createCallback;
  const AddTodoScreen({super.key, required this.createCallback});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  static final rng = Random();
  int iconIdx = 0;
  int colorIdx = rng.nextInt(MyColors.colorList.length);
  final controller = Get.find<PageController>();
  final user = Get.find<Profile>();
  String errTxt = "";
  bool isUnique = false;
  TextEditingController inputController = TextEditingController();
  //? get a list of names of all the current to do lists, which will be used
  //? to check on the submitted to do list name
  late List<String> listNames;
  //? check if user is in edit list mode instead of create
  @override
  void initState() {
    if (user.isEditing) {
      colorIdx = MyColors.colorList.indexOf(user.editingList!.color);
      iconIdx = MyColors.iconsData.indexOf(user.editingList!.icon);
      isUnique = true;
      inputController.text = user.editingList!.name;
    }
    //? get a list of names of all the current to do lists, which will be used
    //? to check on the submitted to do list name
    listNames = user.todoLists.map((todoList) => todoList.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //? Generate icons for the gridview
    List<InkWell> icons = List.generate(
        MyColors.iconsData.length,
        (index) => InkWell(
              onTap: () {
                setState(() {
                  FocusScope.of(context).unfocus();
                  iconIdx = index;
                  isUnique = isUniqueName(inputController.text);
                });
              },
              customBorder: const CircleBorder(),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: (iconIdx == index)
                      ? MyColors.gradients[MyColors.colorList[colorIdx]]
                      : null,
                  shape: BoxShape.circle,
                ),
                child: Icon(MyColors.iconsData[index]),
              ),
            ));
    //? Generate the colors for the gridview
    List<Widget> colors = List.generate(
      MyColors.colorList.length,
      (index) => Material(
        elevation: 4.0,
        shape: const CircleBorder(),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            setState(() {
              FocusScope.of(context).unfocus();
              colorIdx = index;
            });
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.uiButton, width: 0.7),
              gradient: MyColors.gradients[MyColors.colorList[index]],
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 10,
              height: 10,
              child: Icon(
                Icons.check_rounded,
                size: (colorIdx == index) ? 32 : 0,
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
        borderSide: BorderSide(color: MyColors.colorList[colorIdx]),
        borderRadius: const BorderRadius.all(Radius.circular(12)));

    //? Gesture detector to capture tap to close keyboard
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          isUnique = isUniqueName(inputController.text);
        });
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
                    if (user.isEditing) {
                      setState(() {
                        user.isEditing = false;
                        user.editingList = null;
                      });
                    }
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
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                      onFieldSubmitted: (val) {
                        setState(() {
                          isUnique = isUniqueName(val);
                        });
                      },
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: MyColors.colorList[colorIdx],
                      decoration: InputDecoration(
                        fillColor: MyColors.colorList[colorIdx],
                        border: borderDeco,
                        hintText: "To-do list name",
                        focusedBorder: borderDeco,
                        enabledBorder: borderDeco,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Divider(
                indent: width / 4,
                endIndent: width / 4,
              ),
            ),
            Expanded(
              flex: 11,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 8),
                    child: Text(
                      "Icon",
                      style: TextStyle(
                        color: MyColors.darkTxt,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
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
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 11,
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
              onTap: (isUnique)
                  ? () => widget.createCallback(
                        TodoList(
                          name: inputController.text.toString(),
                          color: MyColors.colorList[colorIdx],
                          icon: MyColors.iconsData[iconIdx],
                          tasks: [],
                        ),
                      )
                  : null,
              onTapUp: (up) {
                setState(() {
                  isUnique = isUniqueName(inputController.text);
                });
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                height: 90,
                decoration: BoxDecoration(
                    gradient: MyColors.gradients[MyColors.colorList[colorIdx]],
                    border: Border.all(color: MyColors.uiButton)),
                child: Center(
                    child: Stack(
                  children: <Text>[
                    // Stroked text as border.
                    Text(
                      user.isEditing ? "Save" : "Create",
                      style: TextStyle(
                          fontSize: 36,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.black87,
                          fontFamily: 'roboto'),
                    ),
                    // Solid text as fill.
                    Text(
                      user.isEditing ? "Save" : "Create",
                      style: const TextStyle(
                          fontSize: 36,
                          color: MyColors.lightTxt,
                          fontFamily: 'roboto'),
                    ),
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isUniqueName(String list) {
    // if editing, the list that is being edited is excluded from the search
    // so it can be saved as the same, no new file necessary
    if (user.isEditing) {
      //? list without the current list name so we can 'save'
      if (listNames
          .where((name) => name != user.editingList!.name)
          .toList()
          .contains(inputController.text.toString())) {
        return false;
      } else {
        return true;
      }
    } else {
      if (listNames.contains(inputController.text.toString())) {
        return false;
      } else {
        return true;
      }
    }
  }
}
