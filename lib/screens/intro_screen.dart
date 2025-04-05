import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/screens/user_type_selection_screen.dart';
import 'package:gachiga1/screens/login.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade300, Colors.green.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '같이가',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              '함께하는 돌봄 서비스\n더 안전하고 따뜻한 동행을 시작하세요.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Get.to(() => UserTypeSelectionScreen());
              },
              child: const Text('시작할까요?'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(() => const LoginScreen());
              },
              child: const Text.rich(
                TextSpan(
                  text: '아이디가 있나요? ',
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: '로그인하기',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
