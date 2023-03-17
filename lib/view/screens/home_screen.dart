import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';
import 'package:taskmate/services/service.dart';
import 'package:taskmate/view/screens/add_todo_screen.dart';
import 'package:taskmate/view/components/add_card.dart';
import 'package:taskmate/view/components/shake_widget.dart';
import 'package:taskmate/view/components/todo_card.dart';
import 'package:taskmate/view/components/loading_screen.dart';
import 'package:taskmate/view/screens/todo_screen.dart';

import '../../model/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Profile profile = Get.find<Profile>();
  bool isEditModeOn = false;
  late List<DraggableGridItem> draggableItems;
  PageController controller = Get.put(PageController(initialPage: 1));

  @override
  Widget build(BuildContext context) {
    //? These are the draggable items going in the sliver for the main home screen
    draggableItems = List.generate(
        profile.todoLists.length,
        (index) => DraggableGridItem(
              isDraggable: isEditModeOn,
              child: Material(
                key: Key(index.toString()),
                color: MyColors.transparent,
                child: isEditModeOn
                    ?
                    // To do card with shake widget on (edit mode: on)
                    ShakeWidget(
                        child: TodoCard(
                          list: profile.todoLists[index],
                          isEditModeOn: isEditModeOn,
                          onRemoveTodo: () {
                            setState(() {
                              MyServices.removeTodoList(
                                  profile.todoLists[index]);
                              profile.todoLists.removeAt(index);
                            });
                            if (profile.todoLists.isEmpty) {
                              isEditModeOn = false;
                            }
                          },
                          onLongPress: () {
                            setState(() {
                              isEditModeOn = !isEditModeOn;
                            });
                          },
                        ),
                      )
                    // To do card with no shake widget (edit mode: off)
                    : TodoCard(
                        list: profile.todoLists[index],
                        isEditModeOn: isEditModeOn,
                        onRemoveTodo: () {
                          debugPrint("removed");
                        },
                        onLongPress: () {
                          setState(() {
                            isEditModeOn = !isEditModeOn;
                          });
                        },
                      ),
              ),
            ));

    //? import Add card from my global file
    final addCard = DraggableGridItem(
      isDraggable: false,
      child: AddCard(func: () {
        controller.animateToPage(
          profile.todoLists.length + 1,
          duration: const Duration(milliseconds: 800),
          curve: Curves.linear,
        );
      }),
    );
    draggableItems.add(addCard);

    //? This is the actual displayed screens/pages of the selected todo
    List<Widget> todoPages = List.generate(profile.todoLists.length,
        (index) => TodoScreen(list: profile.todoLists[index]));

    //? draggable grid view
    final gridView = DraggableGridViewBuilder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 25,
        mainAxisSpacing: 35,
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      padding: const EdgeInsets.all(30),
      dragCompletion: onDragAccept,
      children: draggableItems,
      isOnlyLongPress: false,
      dragFeedback: feedback,
      dragPlaceHolder: placeholder,
    );

    // create pages consisting of home, todo's, and add screen
    List<Widget> pages = [
      //? Home Screen GridView of cards
      Padding(
        padding: const EdgeInsets.all(4),
        child: ColoredBox(
          color: MyColors.bg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isEditModeOn
                  ? Align(
                      alignment: Alignment.topRight,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            isEditModeOn = false;
                          });
                        },
                        child: const Text("done"),
                      ),
                    )
                  : const SizedBox.shrink(),
              Expanded(child: gridView),
            ],
          ),
        ),
      )
    ];
    // add the todo's and add screen
    pages += todoPages;
    pages.add(AddTodoScreen(
      //? The reason for having the callback in the homescreen instead of
      //? the todo screen is to set the state of the homescreen after adding
      //? the new to do list; can't do that if these functions are in HS.
      callback: (todo, isUnique) {
        setState(() {
          FocusScope.of(context).unfocus();
          if (isUnique) {
            //save to services and rebuild ui
            profile.todoLists.add(todo);
            MyServices.createTodoList(todo);
            controller.animateToPage(
              profile.todoLists.length,
              duration: const Duration(milliseconds: 1500),
              curve: Curves.linear,
            );
          }
        });
      },
    ));
    return PageView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      children: pages,
    );
  }

  //-----------------------------------------------------------------------
  // Helper methods for the draggable grid view widget

  PlaceHolderWidget placeholder(List<DraggableGridItem> list, int index) {
    return PlaceHolderWidget(
      child: Container(
        color: MyColors.bg,
      ),
    );
  }

  Widget feedback(List<DraggableGridItem> list, int index) {
    return SizedBox(
      width: 160,
      height: 160,
      child: list[index].child,
    );
  }

  void onDragAccept(
      List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
    debugPrint('onDragAccept: $beforeIndex -> $afterIndex');
    //TODO: set a list of widget before homescreen is built and then set state here updating the order of the
    //* widgets and saving the order i the user profile and settings and rebuild the homescreen with an updated pageview
    debugPrint(list[1].child.key.toString());
  }
}
