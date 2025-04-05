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
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 상단 진행상황 표시 (왼쪽 상단)
                Align(
                  alignment: Alignment.topLeft,
                  child: _buildProgressIndicator(context),
                ),
                const SizedBox(height: 16),
                // 안내 문구: "가입 유형을 선택하세요"를 좌측 정렬
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '가입 유형을 선택하세요',
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 24),
                // 카드 영역은 그대로 가운데 정렬
                Expanded(
                  child: Align(
                    alignment: const Alignment(0, -0.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildUserTypeCard(
                          context: context,
                          title: '시니어',
                          subtitle: '만 60세 이상',
                          iconData: Icons.elderly,
                          isSelected: controller.userType.value == 'senior',
                          onTap: () => controller.setUserType('senior'),
                        ),
                        const SizedBox(width: 16),
                        _buildUserTypeCard(
                          context: context,
                          title: '주니어',
                          subtitle: '만 19세 ~ 59세',
                          iconData: Icons.face,
                          isSelected: controller.userType.value == 'junior',
                          onTap: () => controller.setUserType('junior'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // 하단 "다음" 버튼
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

  // 진행상황(1-2-3) 표시 위젯
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

  Widget _buildStepCircle(BuildContext context, int step,
      {required bool isActive}) {
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

  // 시니어/주니어 선택 카드 위젯
  Widget _buildUserTypeCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData iconData,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF0062FF) : const Color(0xFFE5E5E5),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: 40,
              color: isSelected ? const Color(0xFF0062FF) : Colors.grey,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFF0062FF) : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
