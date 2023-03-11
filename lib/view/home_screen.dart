import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/task.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';
import 'package:taskmate/services/service.dart';
import 'package:taskmate/view/components/todo_card.dart';
import 'package:taskmate/view/loading_screen.dart';
import 'package:taskmate/view/todo_screen.dart';

import '../model/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MyServices.getTodoLists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else {
            // GetX controller stuff
            Profile profile = Profile(todoLists: snapshot.data!);
            Get.put(profile, permanent: true);
            PageController controller = Get.put(PageController(initialPage: 0));
            //! fill todlist with sample for now
            if (profile.todoLists.isEmpty) {
              profile.todoLists += MyWidgets.sampleList;
            }
            // convert todoList obj => todoCards
            List<Widget> todoCards = List.generate(profile.todoLists.length,
                (index) => TodoCard(list: profile.todoLists[index]));

            // import add card from my global file
            //? These are used as the HomeScreen cards
            todoCards.add(MyWidgets.addCard);

            //? This is the actual displayed screen of the selected todo
            List<Widget> todoPages = List.generate(profile.todoLists.length,
                (index) => TodoScreen(list: profile.todoLists[index]));

            // create pages consisting of home, todo's, and add screen
            List<Widget> pages = [
              //? Home Screen GridView of cards
              ColoredBox(
                  color: MyColors.bg,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 35,
                    children: todoCards,
                  )),
            ];
            // add the todo's and add screen
            pages += todoPages;
            return PageView(
              controller: controller,
              children: pages,
            );
          }
        });
  }
}
