import 'dart:math';
import 'package:flutter/material.dart';

class MyColors {
  //? colors for pallette
  static const Color bg = Silver;
  static const Color lightTxt = Color(0xffECF0F1);
  static const Color darkTxt = Colors.black87;

  //? UI component colors
  static const Color uiButton = Colors.black54;
  static const Color removeBadge = Color(0xbb444444);
  static const Color pressed = Color(0xff7F8C8D);
  static const Color badge = Color(0xdd444554);
  static const Color transparent = Color(0x00ffffff);

  //? Flat UI Palette
  static const Color Turquoise = Color(0xff1ABC9C);
  static const Color GreenSea = Color(0xff16A085);
  static const Color Emerald = Color(0xff2ECC71);
  static const Color BelizeHole = Color(0xff3498DB);
  static const Color Wisteria = Color(0xff8E44AD);
  static const Color MidnightBlue = Color(0xff2C3E50);
  static const Color SunFlower = Color(0xfff9ca24);
  static const Color Carrot = Color(0xffE67E22);
  static const Color Pomegranate = Color(0xffC0392B);
  static const Color Asbestos = Color(0xff7F8C8D);
  static const Color BlueBell = Color(0xff474787);
  static const Color JungleGreen = Color(0xff227093);
  static const Color Patina = Color(0xff6ab04c);
  static const Color Melon = Color(0xffffb8b8);
  static const Color WaterMelon = Color(0xffff6b81);
  static const Color Silver = Color(0xffe5e6e9);
  static const Color TreeTrunk = Color(0xff8B5A2B);

  static const Color TurquoiseLight = Color(0xff58D3F7);
  static const Color NephritisLight = Color(0xff61E294);
  static const Color BelizeHoleLight = Color(0xff7FB9E5);
  static const Color SteelBlueLight = Color(0xff5AC8FA);
  static const Color MidnightBlueLight = Color(0xff53A8D3);
  static const Color WisteriaLight = Color(0xffB793D4);
  static const Color SunFlowerLight = Color(0xffFDE3A7);
  static const Color CarrotLight = Color(0xffF3C563);
  static const Color PomegranateLight = Color(0xffE08283);
  static const Color AsbestosLight = Color(0xffA2AFD0);
  static const Color BlueBellLight = Color(0xff807DBA);
  static const Color JungleGreenLight = Color(0xff1B9CFC);
  static const Color PatinaLight = Color(0xff2BAE7F);
  static const Color MelonLight = Color(0xffFFD2D2);
  static const Color WaterMelonLight = Color(0xffff9ca7);
  static const Color TreeTrunkLight = Color(0xffD9B48F);

  static const Color SunflowerDark = Color(0xffEAB543);

  //? List of actively used colors in the pallette
  static final List<Color> colorList = [
    MyColors.Turquoise,
    MyColors.Patina,
    MyColors.Emerald,
    MyColors.BelizeHole,
    MyColors.MidnightBlue,
    MyColors.JungleGreen,
    MyColors.Wisteria,
    MyColors.BlueBell,
    MyColors.SunFlower,
    MyColors.Melon,
    MyColors.WaterMelon,
    MyColors.Carrot,
    MyColors.Pomegranate,
    MyColors.Asbestos,
    MyColors.TreeTrunk,
  ];
  static final List<Color> colorListLight = [
    MyColors.TurquoiseLight,
    MyColors.PatinaLight,
    MyColors.JungleGreenLight,
    MyColors.BelizeHoleLight,
    MyColors.MidnightBlueLight,
    MyColors.JungleGreenLight,
    MyColors.WisteriaLight,
    MyColors.BlueBellLight,
    MyColors.SunFlowerLight,
    MyColors.MelonLight,
    MyColors.WaterMelonLight,
    MyColors.CarrotLight,
    MyColors.PomegranateLight,
    MyColors.AsbestosLight,
    MyColors.TreeTrunkLight,
  ];
  static final Map<Color, Color> secondaries = {
    MyColors.Turquoise: MyColors.TurquoiseLight,
    MyColors.Patina: MyColors.PatinaLight,
    MyColors.Emerald: MyColors.Emerald,
    MyColors.BelizeHole: MyColors.BelizeHoleLight,
    MyColors.MidnightBlue: MyColors.MidnightBlueLight,
    MyColors.JungleGreen: MyColors.JungleGreenLight,
    MyColors.Wisteria: MyColors.WisteriaLight,
    MyColors.BlueBell: MyColors.BlueBellLight,
    MyColors.SunFlower: MyColors.SunflowerDark,
    MyColors.Melon: MyColors.Melon,
    MyColors.WaterMelon: MyColors.WaterMelonLight,
    MyColors.Carrot: MyColors.CarrotLight,
    MyColors.Pomegranate: MyColors.PomegranateLight,
    MyColors.Asbestos: MyColors.AsbestosLight,
    MyColors.TreeTrunk: MyColors.TreeTrunkLight,
  };

  //? Gradients created from color pallettes
  // this is a list of all gradients
  static final gradientList = List.generate(
      colorList.length,
      (index) => LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [colorList[index], colorListLight[index]],
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp,
            transform: const GradientRotation(160 * (pi / 180)),
          ));

  // This is a map of all of the gradients
  //? { Color : Gradient }
  static final gradients = Map.fromIterables(
    colorList,
    gradientList,
  );

  static LinearGradient greyBorder = LinearGradient(
    colors: [
      Colors.grey[400]!,
      Colors.grey[500]!,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: const [0.0, 1.0],
    tileMode: TileMode.clamp,
    transform: const GradientRotation(160 * (pi / 180)),
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
    stops: const [0.0, 0.25, 0.55, 1.0],
    tileMode: TileMode.clamp,
    transform: const GradientRotation(160 * (pi / 180)),
  );

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
    Icons.phone_android_rounded,
    Icons.cloudy_snowing,
    Icons.time_to_leave_outlined,
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
    Icons.home,
  ];
  static List<Icon> icons =
      List.generate(iconsData.length, (index) => Icon(iconsData[index]));
}
