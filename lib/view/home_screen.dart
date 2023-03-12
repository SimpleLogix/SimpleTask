import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:get/get.dart';
import 'package:taskmate/services/globals.dart';
import 'package:taskmate/services/service.dart';
import 'package:taskmate/view/add_todo_screen.dart';
import 'package:taskmate/view/components/add_card.dart';
import 'package:taskmate/view/components/shake_widget.dart';
import 'package:taskmate/view/components/todo_card.dart';
import 'package:taskmate/view/components/loading_screen.dart';
import 'package:taskmate/view/todo_screen.dart';

import '../model/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Profile profile = Profile.empty();
  //! find an alternative to setting state because it is buggy, slow, and not ux friendly
  bool isEditModeOn = false;
  late List<DraggableGridItem> draggableItems;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MyServices.getTodoLists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else {
            //? GetX controller stuff
            profile = Profile(todoLists: snapshot.data!);
            Get.put(profile, permanent: true);
            PageController controller = Get.put(PageController(initialPage: 0));
            //! fill todlist with sample for now
            if (profile.todoLists.isEmpty) {
              profile.todoLists += MyWidgets.sampleList;
            }

            //? These are the draggable items going in the sliver for the main home screen
            draggableItems = List.generate(
                profile.todoLists.length,
                (index) => DraggableGridItem(
                      isDraggable: isEditModeOn,
                      child: Material(
                        key: Key(index.toString()),
                        color: MyColors.transparent,
                        child: isEditModeOn? ShakeWidget(
                          child: TodoCard(
                            list: profile.todoLists[index],
                            onLongPress: () {
                              setState(() {
                                isEditModeOn = true;
                              });
                            },
                          ),
                        ) : TodoCard(
                            list: profile.todoLists[index],
                            onLongPress: () {
                              setState(() {
                                isEditModeOn = true;
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
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeInCirc,
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
              padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
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
                  child: gridView,
                ),
              )
            ];
            // add the todo's and add screen
            pages += todoPages;
            pages.add(const AddTodoScreen());
            return PageView(
              controller: controller,
              children: pages,
            );
          }
        });
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
