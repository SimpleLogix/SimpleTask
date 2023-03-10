import 'package:flutter/material.dart';
import 'package:taskmate/view/home_screen.dart';

void main() {
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
        primarySwatch: Colors.blue,
      ),
      home: const  Scaffold(body: SafeArea(child: HomeScreen())),
    );
  }
}
