import 'package:flutter/material.dart';
import 'package:taskmate/services/globals.dart';
import 'package:taskmate/view/screens/connector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskMate',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'roboto',
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
          backgroundColor: MyColors.bg,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            bottom: false,
            child: Connector(),
          )),
    );
  }
}
