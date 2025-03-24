import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeniorSurveyScreen extends StatefulWidget {
  const SeniorSurveyScreen({super.key});

  @override
  State<SeniorSurveyScreen> createState() => _SeniorSurveyScreenState();
}

class _SeniorSurveyScreenState extends State<SeniorSurveyScreen> {
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController healthNoteController = TextEditingController();
  final Map<String, bool> services = {
    '식사 준비': false,
    '말벗 및 정서적 교류': false,
    '병원 동행': false,
    '가벼운 집안일': false,
  };
  String careDuration = '';

  @override
  void dispose() {
    reasonController.dispose();
    healthNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('시니어 전용 설문')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('돌봄이 필요한 이유:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: reasonController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          const Text('필요한 돌봄 서비스:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          ...services.keys.map((service) => CheckboxListTile(
                title: Text(service),
                value: services[service],
                onChanged: (val) =>
                    setState(() => services[service] = val ?? false),
              )),
          TextField(
            decoration: const InputDecoration(
              hintText: '기타 (직접 작성)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('하루에 필요한 돌봄 시간은?',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: ['1~2시간', '3~4시간', '5시간 이상']
                .map((option) => ChoiceChip(
                      label: Text(option),
                      selected: careDuration == option,
                      onSelected: (_) =>
                          setState(() => careDuration = option),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          const Text('특별히 고려해야 할 건강 상태나 제한 사항이 있는가?',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: healthNoteController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (reasonController.text.isEmpty || careDuration.isEmpty) {
                Get.snackbar('오류', '필수 항목을 모두 입력해주세요');
                return;
              }
              final data = {
                'userType': 'senior',
                'reason': reasonController.text,
                'services': services.entries
                    .where((e) => e.value)
                    .map((e) => e.key)
                    .toList(),
                'careDuration': careDuration,
                'healthNotes': healthNoteController.text,
              };
              try {
                final response = await GetConnect()
                    .post('https://your-server.com/api/survey/senior', data);
                if (response.statusCode == 200) {
                  Get.snackbar('제출 완료', '시니어 설문이 저장되었습니다');
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
