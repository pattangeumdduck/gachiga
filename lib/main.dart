import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/screens/signup/signup_intro.dart';
import 'theme.dart';

void main() {
  runApp(const GachigaApp());
}

class GachigaApp extends StatelessWidget {
  const GachigaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gachiga',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SignupIntroScreen(),
    );
  }
}
