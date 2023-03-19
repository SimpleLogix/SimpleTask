import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:get/get.dart';
import 'package:taskmate/services/globals.dart';
import 'package:taskmate/services/service.dart';
import 'package:taskmate/view/screens/add_todo_screen.dart';
import 'package:taskmate/view/components/add_card.dart';
import 'package:taskmate/view/components/todo_card.dart';
import 'package:taskmate/view/screens/todo_screen.dart';

import '../../model/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Profile profile = Get.find<Profile>();
  bool isDragged = false;
  late List<DraggableGridItem> draggableItems;
  PageController controller = Get.put(PageController(initialPage: 6));
  ScrollController gridController = ScrollController();
  @override
  Widget build(BuildContext context) {
    //? These are the draggable items going in the sliver for the main home screen
    draggableItems = List.generate(
        profile.todoLists.length,
        (index) => DraggableGridItem(
              isDraggable: true,
              dragCallback: (context, i) {
                if (i != isDragged) {
                  setState(() {
                    isDragged = i;
                  });
                }
              },
              child: Material(
                color: MyColors.transparent,
                child: TodoCard(
                  list: profile.todoLists[index],
                  isEditModeOn: false,
                  onRemoveTodo: () {
                    setState(() {
                      MyServices.removeTodoList(profile.todoLists[index]);
                      profile.todoLists.removeAt(index);
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
      controller: gridController,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: gridView),
              isDragged
                  ? OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          backgroundColor: MyColors.uiButton,
                          shape: const StadiumBorder()),
                      child: const Text(
                        "done",
                        style: TextStyle(color: MyColors.lightTxt),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      )
    ];

    // add the todo's and add screen
    //? This is the actual displayed screens/pages of the selected todo
    List<Widget> todoPages = List.generate(profile.todoLists.length,
        (index) => TodoScreen(list: profile.todoLists[index]));
    pages += todoPages;
    pages.add(AddTodoScreen(
      //? The reason for having the callback in the homescreen instead of
      //? the todo screen is to set the state of the homescreen after adding
      //? the new to do list; can't do that if these functions are in HS.
      callback: (todo, isUnique) {
        setState(() {
          FocusScope.of(context).unfocus();
          if (isUnique && todo.name.isNotEmpty) {
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
    setState(() {
      profile.todoLists = moveItem(profile.todoLists, beforeIndex, afterIndex);
      MyServices.updateTodoListOrder(profile.todoLists);
    });
  }

  List<T> moveItem<T>(List<T> list, int oldIndex, int newIndex) {
    final item = list[oldIndex];
    list.removeAt(oldIndex);
    list.insert(newIndex, item);
    return list;
  }
}
