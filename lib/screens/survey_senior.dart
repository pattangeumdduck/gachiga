// 📄 survey_senior.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeniorSurveyScreen extends StatefulWidget {
  const SeniorSurveyScreen({super.key});

  @override
  State<SeniorSurveyScreen> createState() => _SeniorSurveyScreenState();
}

class _SeniorSurveyScreenState extends State<SeniorSurveyScreen> {
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController otherServiceController = TextEditingController();
  final TextEditingController healthNoteController = TextEditingController();
  String careDuration = '';
  final Map<String, bool> services = {
    '식사 준비': false,
    '말벗 및 정서적 교류': false,
    '병원 동행': false,
    '가벼운 집안일': false,
  };

  @override
  void dispose() {
    reasonController.dispose();
    otherServiceController.dispose();
    healthNoteController.dispose();
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
                    _buildTitle("1. 돌봄이 필요한 이유"),
                    _buildInput(reasonController),
                    const SizedBox(height: 16),

                    _buildTitle("2. 필요한 돌봄 서비스 (중복 선택 가능)"),
                    ...services.keys.map((service) => CheckboxListTile(
                          title: Text(service),
                          value: services[service],
                          onChanged: (val) =>
                              setState(() => services[service] = val ?? false),
                        )),
                    _buildInput(otherServiceController, hint: '기타 (직접 작성)'),
                    const SizedBox(height: 16),

                    _buildTitle("3. 하루에 필요한 돌봄 시간은?"),
                    _buildChoiceChips([
                      '1~2시간',
                      '3~4시간',
                      '5시간 이상'
                    ], careDuration, (val) {
                      setState(() => careDuration = val);
                    }),
                    const SizedBox(height: 16),

                    _buildTitle("4. 건강 상태나 제한 사항이 있는가?"),
                    _buildInput(healthNoteController),
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
    if (reasonController.text.isEmpty || careDuration.isEmpty) {
      Get.snackbar('오류', '필수 항목을 입력해주세요');
      return;
    }
    final data = {
      'userType': 'senior',
      'reason': reasonController.text,
      'services': services.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList(),
      'otherService': otherServiceController.text,
      'careDuration': careDuration,
      'healthNotes': healthNoteController.text,
    };
    print(data);
    Get.snackbar('제출 완료', '시니어 설문이 제출되었습니다');
  }
}