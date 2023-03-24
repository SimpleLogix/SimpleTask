import 'package:flutter/material.dart';
import 'package:taskmate/services/globals.dart';
import 'package:taskmate/view/screens/connector.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Task',
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colors.transparent,
        ),
        fontFamily: 'roboto',
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
