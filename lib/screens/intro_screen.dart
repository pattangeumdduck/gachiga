import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gachiga1/screens/login.dart';
import 'package:gachiga1/screens/user_type_selection_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // 로고 SVG
              SvgPicture.asset(
                'assets/images/login_logo.svg',
                height: 80,
              ),

              const Spacer(),

              // 로그인 버튼 + 얼굴인식 버튼
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => LoginScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          '로그인',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),

                  // 얼굴인식 SVG 버튼 전체 대체
                  GestureDetector(
                    onTap: () {
                      // TODO: 얼굴 인식 동작
                    },
                    child: SvgPicture.asset(
                      'assets/images/face_login.svg',
                      width: 70,
                      height: 70,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // 회원가입 버튼
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Get.to(() =>  UserTypeSelectionScreen());
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: '회원이 아니신가요? ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: const [
                        TextSpan(
                          text: '회원가입',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30), // 하단 여백
            ],
          ),
        ),
      ),
    );
  }
}
