import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';
import 'package:taskmate/services/service.dart';
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Expanded(
                  child: ColoredBox(
                      color: MyColors.bg,
                      child: Center(
                        child: Text(
                          "implemeted",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )),
                ),
              ],
            );
          }
        });
  }
}
