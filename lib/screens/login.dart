import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gachiga1/screens/home_screen.dart';
import 'package:gachiga1/widgets/custom_snackbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool autoLogin = true;
    bool obscurePassword = true;

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(),

                // 중앙 로고
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 170), // 👈 여기만 추가
                    child: SvgPicture.asset(
                      'assets/images/login_logo.svg',
                      height: 80,
                    ),
                  ),
                ),

                const Spacer(),

                // 하단 로그인 폼
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            StatefulBuilder(
                              builder: (context, setState) {
                                return Checkbox(
                                  value: autoLogin,
                                  onChanged: (val) {
                                    setState(() {
                                      autoLogin = val ?? true;
                                    });
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                );
                              },
                            ),
                            const Text('자동로그인'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            '아이디 / 비밀번호 찾기',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // 이메일 입력
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: '이메일',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 비밀번호 입력
                    StatefulBuilder(
                      builder: (context, setState) {
                        return TextFormField(
                          controller: passwordController,
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                            hintText: '비밀번호',
                            suffixIcon: IconButton(
                              icon: Icon(obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // 로그인 버튼
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            showCustomSnackbar(
                              title: '오류',
                              message: '이메일과 비밀번호를 입력해주세요',
                            );
                            return;
                          }
                          Get.offAll(() => const HomeScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          '로그인',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40), // 여유 공간
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
