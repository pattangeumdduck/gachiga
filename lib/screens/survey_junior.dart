// 📄 survey_junior.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JuniorSurveyScreen extends StatefulWidget {
  const JuniorSurveyScreen({super.key});

  @override
  State<JuniorSurveyScreen> createState() => _JuniorSurveyScreenState();
}

class _JuniorSurveyScreenState extends State<JuniorSurveyScreen> {
  String experience = '';
  String timeSlot = '';
  final TextEditingController scopeController = TextEditingController();
  final TextEditingController importantController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  @override
  void dispose() {
    scopeController.dispose();
    importantController.dispose();
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  _buildStepCircle(context, step: 1, isActive: false),
                  _buildStepLine(context),
                  _buildStepCircle(context, step: 2, isActive: false),
                  _buildStepLine(context),
                  _buildStepCircle(context, step: 3, isActive: true),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '설문에 응답해주세요',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle("1. 돌봄 제공 경험이 있나요?"),
                    _buildChoiceChips(['네', '아니요'], experience, (val) {
                      setState(() => experience = val);
                    }),
                    const SizedBox(height: 16),

                    _buildTitle("2. 돌봄을 제공할 수 있는 시간대"),
                    _buildChoiceChips(['아침', '점심', '저녁', '무관'], timeSlot, (val) {
                      setState(() => timeSlot = val);
                    }),
                    const SizedBox(height: 16),

                    _buildTitle("3. 제공 가능한 돌봄 범위"),
                    _buildInput(scopeController),
                    const SizedBox(height: 16),

                    _buildTitle("4. 노인과 함께 생활할 때 가장 중요하게 생각하는 것은?"),
                    _buildInput(importantController),
                    const SizedBox(height: 16),

                    _buildTitle("5. 돌봄에 대한 기대 수준"),
                    _buildInput(valueController),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text("이전"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      child: const Text("제출"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String text) => Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      );

  Widget _buildChoiceChips(
      List<String> options, String selected, Function(String) onSelected) {
    return Wrap(
      spacing: 8,
      children: options.map((opt) {
        return ChoiceChip(
          label: Text(opt),
          selected: selected == opt,
          onSelected: (_) => onSelected(opt),
        );
      }).toList(),
    );
  }

  Widget _buildInput(TextEditingController controller, {String? hint}) {
    return TextField(
      controller: controller,
      maxLines: 3,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint ?? '입력해주세요',
      ),
    );
  }

  Widget _buildStepCircle(BuildContext context,
      {required int step, required bool isActive}) {
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

  void _handleSubmit() {
    if (experience.isEmpty || timeSlot.isEmpty || scopeController.text.isEmpty) {
      Get.snackbar('오류', '필수 항목을 입력해주세요');
      return;
    }
    final data = {
      'userType': 'junior',
      'timeSlot': timeSlot,
      'experience': experience,
      'scope': scopeController.text,
      'important': importantController.text,
      'value': valueController.text,
    };
    print(data);
    Get.snackbar('제출 완료', '주니어 설문이 제출되었습니다');
  }
}