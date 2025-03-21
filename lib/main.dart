import 'package:flutter/material.dart';
import 'screens/intro_screen.dart'; // ⚠️ 반드시 이 경로여야 합니다!

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '같이가',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const IntroScreen(),
    );
  }
}
