import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/controllers/signup_controller.dart';
import 'package:gachiga1/screens/survey_senior.dart';
import 'package:gachiga1/screens/survey_junior.dart';

class SurveyCommonScreen extends StatefulWidget {
  const SurveyCommonScreen({super.key});

  @override
  State<SurveyCommonScreen> createState() => _SurveyCommonScreenState();
}

class _SurveyCommonScreenState extends State<SurveyCommonScreen> {
  final PageController _pageController = PageController();
  final SignupController controller = Get.find<SignupController>();
  int _currentIndex = 0;

  final List<List<Map<String, dynamic>>> pages = [
    [
      {
        'key': 'wake_sleep',
        'question': '평소 기상 및 취침 시간은?',
        'options': ['아침형', '밤형', '유동적']
      },
      {
        'key': 'home_time',
        'question': '집에서 주로 보내는 시간:',
        'options': ['많음', '보통', '적음']
      },
      {
        'key': 'active_time',
        'question': '하루 중 가장 활발한 시간대는 언제인가?',
        'options': null
      },
    ],
    [
      {
        'key': 'weekday_weekend',
        'question': '주중과 주말의 생활 패턴은?',
        'options': null
      },
      {
        'key': 'pets',
        'question': '반려동물이 있거나 계획이 있는가?',
        'options': ['네', '아니요']
      },
      {
        'key': 'smoking_drinking',
        'question': '흡연 및 음주 여부:',
        'options': null
      },
    ],
    [
      {
        'key': 'beliefs',
        'question': '종교 또는 신념이 있는가?',
        'options': ['네', '아니요']
      },
      {
        'key': 'cleanliness',
        'question': '청결 기준이 높은가?',
        'options': ['예', '보통', '아니요']
      },
      {
        'key': 'shared_living',
        'question': '공동생활에서 가장 중요하게 생각하는 요소는?',
        'options': null
      },
    ],
  ];

  void _saveAnswer(String key, dynamic value) {
    controller.setSurveyAnswer(key, value);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('생활 패턴 설문 (${_currentIndex + 1}/${pages.length})'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemBuilder: (context, pageIndex) {
          final questions = pages[pageIndex];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                for (var q in questions)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        q['question'],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      q['options'] != null
                          ? Wrap(
                              spacing: 8,
                              children: List<Widget>.from(
                                q['options'].map<Widget>(
                                  (opt) => ChoiceChip(
                                    label: Text(opt),
                                    selected:
                                        controller.commonSurvey[q['key']] == opt,
                                    onSelected: (_) =>
                                        setState(() => _saveAnswer(q['key'], opt)),
                                  ),
                                ),
                              ),
                            )
                          : TextFormField(
                              initialValue: controller.commonSurvey[q['key']] ?? '',
                              onChanged: (val) => _saveAnswer(q['key'], val),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                            ),
                      const SizedBox(height: 16),
                    ],
                  ),
                const Spacer(),
                if (_currentIndex < pages.length - 1)
                  ElevatedButton(
                    onPressed: () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease),
                    child: const Text('다음'),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      if (controller.userType.value == 'senior') {
                        Get.to(() => const SeniorSurveyScreen());
                      } else {
                        Get.to(() => const JuniorSurveyScreen());
                      }
                    },
                    child: const Text('제출'),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
