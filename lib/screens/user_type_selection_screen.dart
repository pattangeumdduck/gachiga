import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/controllers/signup_controller.dart';
import 'package:gachiga1/screens/signup_form.dart';

class UserTypeSelectionScreen extends StatelessWidget {
  UserTypeSelectionScreen({Key? key}) : super(key: key);

  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: _buildProgressIndicator(context),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '가입 유형을 선택하세요',
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Align(
                    alignment: const Alignment(0, -0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildUserTypeImageButton(
                          imagePath: controller.userType.value == 'senior'
                              ? 'assets/images/selected_yes_senior.png'
                              : 'assets/images/selected_no_senior.png',
                          onTap: () => controller.setUserType('senior'),
                        ),
                        const SizedBox(width: 16),
                        _buildUserTypeImageButton(
                          imagePath: controller.userType.value == 'junior'
                              ? 'assets/images/selected_yes_junior.png'
                              : 'assets/images/selected_no_junior.png',
                          onTap: () => controller.setUserType('junior'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.userType.value.isEmpty) {
                        Get.snackbar('오류', '가입 유형을 선택해주세요.');
                        return;
                      }
                      Get.to(() => const SignupFormScreen());
                    },
                    child: const Text('다음'),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStepCircle(context, 1, isActive: true),
        _buildStepLine(context),
        _buildStepCircle(context, 2, isActive: false),
        _buildStepLine(context),
        _buildStepCircle(context, 3, isActive: false),
      ],
    );
  }

  Widget _buildStepCircle(BuildContext context, int step, {required bool isActive}) {
    final theme = Theme.of(context);
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ? theme.primaryColor : const Color(0xFFF2F2F2),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$step',
        style: TextStyle(
          color: isActive ? Colors.white : theme.textTheme.bodyMedium?.color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStepLine(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 20,
      height: 2,
      color: theme.primaryColor,
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildUserTypeImageButton({
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        imagePath,
        width: 140,
        fit: BoxFit.contain,
      ),
    );
  }
}