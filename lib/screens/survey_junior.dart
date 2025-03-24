import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JuniorSurveyScreen extends StatefulWidget {
  const JuniorSurveyScreen({super.key});

  @override
  State<JuniorSurveyScreen> createState() => _JuniorSurveyScreenState();
}

class _JuniorSurveyScreenState extends State<JuniorSurveyScreen> {
  String timeSlot = '';
  String experience = '';
  final TextEditingController scopeController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final TextEditingController importantController = TextEditingController();

  @override
  void dispose() {
    scopeController.dispose();
    valueController.dispose();
    importantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('주니어 전용 설문')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('돌봄을 제공할 수 있는 시간대:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: ['아침', '점심', '저녁', '무관']
                .map((option) => ChoiceChip(
                      label: Text(option),
                      selected: timeSlot == option,
                      onSelected: (_) => setState(() => timeSlot = option),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          const Text('돌봄 제공 경험이 있는가?',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: ['네', '아니요']
                .map((option) => ChoiceChip(
                      label: Text(option),
                      selected: experience == option,
                      onSelected: (_) => setState(() => experience = option),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          const Text('제공 가능한 돌봄 범위:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: scopeController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          const Text('노인과 함께 생활할 때 가장 중요하게 생각하는 점은?',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: importantController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          const Text('돌봄에 대한 기대 수준:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: valueController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (timeSlot.isEmpty ||
                  experience.isEmpty ||
                  scopeController.text.isEmpty) {
                Get.snackbar('오류', '필수 항목을 모두 입력해주세요');
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
              try {
                final response = await GetConnect()
                    .post('https://your-server.com/api/survey/junior', data);
                if (response.statusCode == 200) {
                  Get.snackbar('제출 완료', '주니어 설문이 저장되었습니다');
                } else {
                  Get.snackbar('에러',
                      '제출에 실패했습니다: ${response.statusText}');
                }
              } catch (e) {
                Get.snackbar(
                    '예외 발생', '네트워크 오류 또는 서버 에러: $e');
              }
            },
            child: const Text('제출하기'),
          ),
        ],
      ),
    );
  }
}
