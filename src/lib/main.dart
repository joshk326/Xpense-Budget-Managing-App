import 'package:flutter/material.dart';
import 'package:xpense/constants.dart';
import 'package:xpense/screens/navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpense',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: themeBackground,
          foregroundColor: themeForeground,
        ),
      ),
      home: MainPage(),
    );
  }
}
