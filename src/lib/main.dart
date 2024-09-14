import 'package:flutter/material.dart';
import 'package:xpense/constants.dart';
import 'package:xpense/screens/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
