import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/widgets/custom_snackbar.dart';
import 'package:gachiga1/screens/signup_complete_screen.dart';

class JuniorSurveyScreen extends StatefulWidget {
  const JuniorSurveyScreen({super.key});

  @override
  State<JuniorSurveyScreen> createState() => _JuniorSurveyScreenState();
}

class _JuniorSurveyScreenState extends State<JuniorSurveyScreen> {
  String experience = '';
  List<String> selectedTimeSlots = [];
  List<String> selectedCareTypes = [];
  final TextEditingController importantController = TextEditingController();

  final List<String> careTimeOptions = ['아침', '점심', '저녁', '무관'];

  final List<Map<String, String>> careTypeOptions = [
    {'label': '정서 교류 및 관계 형성', 'desc': '정서적 활동, 말벗, 식사 함께하기 등'},
    {'label': '생활 및 지원 제공', 'desc': '청소, 세탁, 식사 준비, 복약, 쓰레기 정리, 외부 교육 등'},
    {'label': '건강관리 보조', 'desc': '산책 동행, 복약 체크, 병원, 관련한 도움 등'},
  ];

  @override
  void dispose() {
    importantController.dispose();
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

                    _buildTitle("2. 돌봄을 제공할 수 있는 시간대 (다중선택 가능)"),
                    Wrap(
                      spacing: 8,
                      children: careTimeOptions.map((option) {
                        final isSelected = selectedTimeSlots.contains(option);
                        return FilterChip(
                          label: Text(option),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedTimeSlots.add(option);
                              } else {
                                selectedTimeSlots.remove(option);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    _buildTitle("3. 제공 가능한 돌봄 범위 (다중선택 가능)"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: careTypeOptions.map((item) {
                        final selected = selectedCareTypes.contains(item['label']);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FilterChip(
                                label: Text(item['label']!),
                                selected: selected,
                                onSelected: (bool value) {
                                  setState(() {
                                    if (value) {
                                      selectedCareTypes.add(item['label']!);
                                    } else {
                                      selectedCareTypes.remove(item['label']!);
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  item['desc']!,
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    _buildTitle("4. 함께 시간을 보낼 때 가장 중요하게 생각하는 것은 무엇인가요? \n"),
          
                    _buildInput(importantController),
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

  Widget _buildChoiceChips(List<String> options, String selected, Function(String) onSelected) {
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
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildStepCircle(BuildContext context, {required int step, required bool isActive}) {
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
    if (experience.isEmpty || selectedTimeSlots.isEmpty || selectedCareTypes.isEmpty) {
    showCustomSnackbar(title: '입력 오류', message: '필수 항목을 모두 입력해주세요');
      return;
    }
    final data = {
      'userType': 'junior',
      'experience': experience,
      'timeSlots': selectedTimeSlots,
      'careTypes': selectedCareTypes,
      'important': importantController.text,
    };
    print(data);
    Get.snackbar('제출 완료', '주니어 설문이 제출되었습니다');
    Get.to(() => const SignupCompleteScreen());
  }
}