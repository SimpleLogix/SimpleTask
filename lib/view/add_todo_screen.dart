import 'package:flutter/material.dart';
import 'package:taskmate/services/globals.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: ColoredBox(
        color: MyColors.main,
        child: Center(
          child: Text("Add Screen"),
        ),
      ),
    );
  }
}
