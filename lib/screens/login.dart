import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/screens/home_screen.dart'; // HomeScreen import
import 'package:gachiga1/controllers/auth_controller.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final AuthController authController = Get.find<AuthController>(); // AuthController 찾기

    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('이메일', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: '이메일을 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('비밀번호', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: '비밀번호를 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;

                if (email.isEmpty || password.isEmpty) {
                  Get.snackbar('오류', '이메일과 비밀번호를 입력해주세요');
                  return;
                }

                // 로그인 성공 처리: 상태 변경 및 HomeScreen으로 이동
                authController.login();
                Get.offAll(() => const HomeScreen()); // 뒤로가기 불가능하게 처리
              },
              child: const Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
