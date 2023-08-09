import 'package:flutter/material.dart';
import 'package:money_management_project/screens/home/screen_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Management Application',
      theme: ThemeData(
        primaryColor: Colors.purpleAccent.shade200
      ),
      home: ScreenHome(),
    );
  }
}