import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/controllers/auth_controller.dart';
import 'package:gachiga1/controllers/signup_controller.dart';
import 'package:gachiga1/screens/intro_screen.dart';
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
      home: const IntroScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(SignupController()); // 💡 초기 바인딩을 여기서 처리
      }),
    );
  }
}
