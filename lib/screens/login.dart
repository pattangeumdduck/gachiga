import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/screens/home_screen.dart';
import 'package:gachiga1/widgets/custom_snackbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // ✅ overflow 방지
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 80), // 약간 줄임
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: size.width * 0.5,
                    height: size.width * 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: size.height * 0.2), // 수정된 코드
                // ✅ 하단 로그인 폼
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (_) {},
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            const Text('자동로그인'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('아이디 / 비밀번호 찾기'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: '이메일',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '비밀번호',
                        suffixIcon: const Icon(Icons.visibility_off),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(                       
                        onPressed: () {
                          if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                            showCustomSnackbar(
                              title: '오류',
                              message: '이메일과 비밀번호를 입력해주세요',
                            );
                            return;
                          }
                          Get.offAll(() => const HomeScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('로그인'),
                      ),
                    ),
                    const SizedBox(height: 40), // 마지막 여백
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
