import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';
import 'package:taskmate/services/service.dart';
import 'package:taskmate/view/components/todo_card.dart';
import 'package:taskmate/view/loading_screen.dart';

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
            //? GetX controller
            Profile profile = Profile(todoLists: snapshot.data!);
            Get.put(profile, permanent: true);
            List<TodoCard> todoCards = List.generate(
                1,
                (index) => TodoCard(
                        list: TodoList(
                      name: "Health",
                      color: Colors.red[800]!,
                      icon: Icons.heart_broken,
                      tasks: [],
                    )));
            TodoCard addCard = TodoCard(
                list: TodoList(
              name: "Add a new List",
              color: MyColors.main,
              icon: Icons.add,
              tasks: [],
            ));
            todoCards.add(addCard);
            return ColoredBox(
                color: MyColors.bg,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 35,
                  children: todoCards,
                ));
          }
        });
  }
}
