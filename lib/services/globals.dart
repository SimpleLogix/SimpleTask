import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taskmate/model/todo_list.dart';

import '../model/task.dart';

class MyColors {
  // colors for pallete
  static const Color bg = Silver;
  static const Color lightTxt = Color(0xffECF0F1);
  static const Color darkTxt = Colors.black87;

  static const Color uiButton = Colors.black54;
  static const Color removeBadge = Color(0xbb444444);

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
  static const Color Wisteria = Color(0xff8E44AD);
  static const Color MidnightBlue = Color(0xff2C3E50);
  static const Color SunFlower = Color(0xffF1C40F);
  static const Color Carrot = Color(0xffE67E22);
  static const Color Pomegranate = Color(0xffC0392B);
  static const Color Silver = Color(0xffBDC3C7);
  static const Color Asbestos = Color(0xff7F8C8D);

  static const Color TurquoiseLight = Color(0xff58D3F7);
  static const Color NephritisLight = Color(0xff61E294);
  static const Color BelizeHoleLight = Color(0xff66B3FF);
  static const Color SteelBlueLight = Color(0xff5AC8FA);
  static const Color MidnightBlueLight = Color(0xff53A8D3);
  static const Color WisteriaLight = Color(0xffB793D4);
  static const Color SunFlowerLight = Color(0xffFFE270);
  static const Color CarrotLight = Color(0xffF3C563);
  static const Color PomegranateLight = Color(0xffE08283);
  static const Color AsbestosLight = Color(0xffA2AFD0);

  static LinearGradient greyBorder = LinearGradient(
    colors: [
      Colors.grey[400]!,
      Colors.grey[500]!,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp,
    transform: GradientRotation(160 * (pi / 180)),
  );

  static LinearGradient grey = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    colors: [
      Colors.grey[350]!,
      Colors.grey[400]!,
      Colors.grey,
      Colors.grey[600]!,
    ],
    stops: [0.0, 0.25, 0.55, 1.0],
    tileMode: TileMode.clamp,
    transform: GradientRotation(160 * (pi / 180)),
  );

  //? map that maps each color to a corresponding gradient
  static Map<Color, Gradient> gradients = {
    Turquoise: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Turquoise, TurquoiseLight],
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      transform: GradientRotation(160 * (pi / 180)),
    ),
    GreenSea: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [GreenSea, Turquoise],
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      transform: GradientRotation(160 * (pi / 180)),
    ),
    Emerald: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Emerald, Turquoise],
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      transform: GradientRotation(160 * (pi / 180)),
    ),
    Nephritis: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Nephritis, NephritisLight],
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      transform: GradientRotation(160 * (pi / 180)),
    ),
    BelizeHole: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [BelizeHole, BelizeHoleLight],
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      transform: GradientRotation(160 * (pi / 180)),
    ),
    SteelBlue: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [SteelBlue, SteelBlueLight],
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      transform: GradientRotation(160 * (pi / 180)),
    ),
    Wisteria: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Wisteria, WisteriaLight],
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      transform: GradientRotation(160 * (pi / 180)),
    ),
    MidnightBlue: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [MidnightBlue, MidnightBlueLight],
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      transform: GradientRotation(160 * (pi / 180)),
    ),
    SunFlower: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [SunFlower, CarrotLight],
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      transform: GradientRotation(160 * (pi / 180)),
    ),
    Carrot: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Carrot, CarrotLight],
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      transform: GradientRotation(160 * (pi / 180)),
    ),
    Pomegranate: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Pomegranate, PomegranateLight],
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      transform: GradientRotation(160 * (pi / 180)),
    ),
    Asbestos: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Asbestos, AsbestosLight],
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
      transform: GradientRotation(160 * (pi / 180)),
    ),
  };
}

class MyWidgets {
  static List<Color> colorList = [
    MyColors.Turquoise,
    MyColors.GreenSea,
    MyColors.Emerald,
    MyColors.Nephritis,
    MyColors.BelizeHole,
    MyColors.SteelBlue,
    MyColors.Wisteria,
    MyColors.MidnightBlue,
    MyColors.SunFlower,
    MyColors.Carrot,
    MyColors.Pomegranate,
    MyColors.Asbestos,
  ];
  static List<Widget> colors = List.generate(
    colorList.length,
    (index) => DecoratedBox(
      decoration: BoxDecoration(
        color: colorList[index],
        shape: BoxShape.circle,
      ),
      child: const SizedBox(
        width: 5,
        height: 5,
      ),
    ),
  );

  static List<IconData> iconsData = [
    Icons.person_outlined,
    Icons.rocket_launch_outlined,
    Icons.house_outlined,
    Icons.shopping_cart_outlined,
    Icons.star_border_outlined,
    Icons.favorite_border_rounded,
    Icons.school_outlined,
    Icons.work_outline_rounded,
    Icons.music_note_rounded,
    Icons.lightbulb_outline_rounded,
    Icons.calendar_month_outlined,
    Icons.delete_outlined,
    Icons.ramen_dining_outlined,
    Icons.card_giftcard_rounded,
    Icons.cloudy_snowing,
    Icons.check,
    Icons.access_time,
    Icons.calendar_today,
    Icons.notifications_outlined,
    Icons.priority_high,
    Icons.settings,
    Icons.lightbulb_outline,
    Icons.edit,
    Icons.send,
    Icons.cloud_outlined,
    Icons.battery_alert,
    Icons.camera_alt,
    Icons.mic,
    Icons.location_on,
    Icons.assignment_turned_in,
    Icons.assignment,
    Icons.bar_chart,
    Icons.dashboard,
    Icons.face,
    Icons.help,
    Icons.home,
  ];
  static List<Icon> icons =
      List.generate(iconsData.length, (index) => Icon(iconsData[index]));
}
