import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/profile.dart';
import 'package:taskmate/services/services.dart';
import 'package:taskmate/view/screens/home_screen.dart';

import '../components/loading_screen.dart';

/// Future builder to go through and set the state of the app
/// and initialize everything before going into the app
class Connector extends StatefulWidget {
  const Connector({super.key});

  @override
  State<Connector> createState() => _ConnectorState();
}

class _ConnectorState extends State<Connector> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MyServices.getTodoLists(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else {
            
            //? GetX controller stuff
            Profile profile = Profile(todoLists: snap.data!);
            Get.put(profile, permanent: true);
            
            return const HomeScreen();
          }
        });
  }
}
