// screens/signup_intro.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';
import 'signup_form.dart';

class SignupIntroScreen extends StatelessWidget {
  const SignupIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());

    return Scaffold(
      appBar: AppBar(title: const Text('가입 유형 선택')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('가입할 유형을 선택하세요', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                controller.setUserType('senior');
                Get.to(() => const SignupFormScreen());
              },
              child: const Text('시니어로 가입하기'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.setUserType('junior');
                Get.to(() => const SignupFormScreen());
              },
              child: const Text('주니어로 가입하기'),
            ),
          ],
        ),
      ),
    );
  }
}
