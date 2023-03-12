import 'package:flutter/material.dart';
import 'package:taskmate/model/todo_list.dart';

import '../model/task.dart';

class MyColors {
  // colors for pallete
  static const Color bg = Silver;
  static const Color main = Color(0xff2980B9);
  static const Color lightTxt = Color(0xffECF0F1);
  static const Color darkTxt = lightTxt;

  static const Color transparent = Color(0x00ffffff);

  // colors for ui components
  static const Color pressed = Color(0xff7F8C8D);
  static const Color badge = Color(0xdd444554);

  // Flat UI Palette
  static const Color Turquoise = Color(0xff1ABC9C);
  static const Color GreenSea = Color(0xff16A085);
  static const Color Emerald = Color(0xff2ECC71);
  static const Color Nephritis = Color(0xff27AE60);
  static const Color BelizeHole = Color(0xff3498DB);
  static const Color SteelBlue = Color(0xff2980B9);
  static const Color Amethyst = Color(0xff9B59B6);
  static const Color Wisteria = Color(0xff8E44AD);
  static const Color WetAsphalt = Color(0xff34495E);
  static const Color MidnightBlue = Color(0xff2C3E50);
  static const Color SunFlower = Color(0xffF1C40F);
  static const Color Orange = Color(0xffF39C12);
  static const Color Carrot = Color(0xffE67E22);
  static const Color Pumpkin = Color(0xffD35400);
  static const Color Alizarin = Color(0xffE74C3C);
  static const Color Pomegranate = Color(0xffC0392B);
  static const Color Clouds = Color(0xffECF0F1);
  static const Color Silver = Color(0xffBDC3C7);
  static const Color Concrete = Color(0xff95A5A6);
  static const Color Asbestos = Color(0xff7F8C8D);
}

class MyWidgets {
  static List<TodoList> sampleList = [
    TodoList(
      name: "Health",
      color: MyColors.Alizarin,
      icon: Icons.heart_broken,
      tasks: [
        Task(name: "name", isDone: false, isImportant: false),
        Task(name: "name", isDone: true, isImportant: true)
      ],
    ),
    TodoList(
      name: "Life",
      color: MyColors.SunFlower,
      icon: Icons.star_border_purple500_outlined,
      tasks: [
        Task(name: "name", isDone: true, isImportant: false),
        Task(name: "name", isDone: true, isImportant: true)
      ],
    ),
    TodoList(
      name: "Work",
      color: MyColors.Nephritis,
      icon: Icons.cases_outlined,
      tasks: [
        Task(name: "name", isDone: true, isImportant: false),
        Task(name: "name", isDone: true, isImportant: true)
      ],
    ),
    TodoList(
      name: "Shopping List",
      color: MyColors.Pumpkin,
      icon: Icons.shopping_cart_outlined,
      tasks: [
        Task(name: "name", isDone: true, isImportant: false),
        Task(name: "name", isDone: true, isImportant: true)
      ],
    ),
    TodoList(
      name: "Home & Yard & School Improvements",
      color: MyColors.Amethyst,
      icon: Icons.house_outlined,
      tasks: [
        Task(name: "name", isDone: true, isImportant: false),
        Task(name: "name", isDone: true, isImportant: true),
        Task(name: "name", isDone: false, isImportant: true),
      ],
    ),
    TodoList(
      name: "Projects",
      color: MyColors.BelizeHole,
      icon: Icons.rocket_launch_outlined,
      tasks: [
        Task(name: "name", isDone: true, isImportant: false),
        Task(name: "name", isDone: true, isImportant: true)
      ],
    ),
    TodoList(
      name: "School",
      color: MyColors.MidnightBlue,
      icon: Icons.school_outlined,
      tasks: [
        Task(name: "name", isDone: true, isImportant: false),
        Task(name: "name", isDone: true, isImportant: true)
      ],
    ),
  ];
}
