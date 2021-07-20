import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:photogram/app/theme_main.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Slidy',
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: themeMain,
      themeMode: ThemeMode.dark,
    ).modular();
  }
}
