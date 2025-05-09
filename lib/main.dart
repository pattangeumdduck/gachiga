import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:gachiga1/controllers/auth_controller.dart';
import 'package:gachiga1/controllers/signup_controller.dart';
import 'package:gachiga1/screens/intro_screen.dart';
import 'package:gachiga1/theme.dart'; // theme.dart가 있다면 import
import 'package:gachiga1/screens/splash_screen.dart'; 

void main() {
  runApp(const GachigaApp());
}

class GachigaApp extends StatelessWidget {
  const GachigaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gachiga',
      theme: AppTheme.lightTheme, // theme.dart에서 정의한 테마
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(SignupController());
      }),
      // ↓↓↓ 여기서 로컬라이제이션 설정 ↓↓↓
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ko', 'KR'),
      ],
    );
  }
}
