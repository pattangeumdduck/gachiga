import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/screens/login.dart';
import 'package:gachiga1/screens/user_type_selection_screen.dart';
import 'package:gachiga1/theme.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // ✅ 반응형 로고
              Image.asset(
                'assets/images/logo.png',
                width: size.width * 0.6,
                height: size.width * 0.6,
              ),
              const SizedBox(height: 16),
              Text(
                '~한 돌봄서비스,\n 같이 가',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.primary,  
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const LoginScreen()),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('로그인'),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => Get.to(() => UserTypeSelectionScreen()),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: BorderSide(color: theme.primaryColor),
                ),
                child: const Text.rich(
                  TextSpan(
                    text: '회원이 아니신가요? ',
                    style: TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(
                        text: '회원가입 하기',
                        style: TextStyle(
                          color: Color(0xFF0062FF),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
