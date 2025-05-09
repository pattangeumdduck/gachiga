import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/screens/home_screen.dart';

class SignupCompleteScreen extends StatelessWidget {
  const SignupCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.blue, size: 80),
              const SizedBox(height: 24),
              const Text(
                '가입 완료',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const HomeScreen()),
                  child: const Text('홈으로 가기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
