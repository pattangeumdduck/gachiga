
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/screens/signup_complete_screen.dart';
import 'package:gachiga1/widgets/custom_snackbar.dart';

class SeniorSurveyScreen extends StatefulWidget {
  const SeniorSurveyScreen({super.key});

  @override
  State<SeniorSurveyScreen> createState() => _SeniorSurveyScreenState();
}

class _SeniorSurveyScreenState extends State<SeniorSurveyScreen> {
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController otherServiceController = TextEditingController();
  final TextEditingController healthNoteController = TextEditingController();

  double careHours = 1;
  List<String> selectedServices = [];

  final List<Map<String, String>> careOptions = [
    {'label': '정서 교류 및 관계 형성', 'desc': '정서적 돌봄: 말벗, 식사 함께하기 등'},
    {'label': '생활 및 자립 지원', 'desc': '정리정돈, 식사 준비, 인지자극 활동 등'},
    {'label': '건강관리 보조', 'desc': '약 복용, 간단한 스트레칭 등'},
    {'label': '외출 동행', 'desc': '병원/약국 동행, 산책, 행정적 도움 등'},
  ];

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
                    const SizedBox(height: 24),

                    _buildTitle("2. 필요한 돌봄 서비스 (다중선택 가능)"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: careOptions.map((item) {
                        final selected = selectedServices.contains(item['label']);
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
                                      selectedServices.add(item['label']!);
                                    } else {
                                      selectedServices.remove(item['label']!);
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
                    const SizedBox(height: 12),
                    _buildInput(otherServiceController, hint: "기타 (직접 작성)"),
                    const SizedBox(height: 24),

                    _buildTitle("3. 하루에 필요한 돌봄 시간은?"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) {
                        final labels = ['1-2시간', '3-4시간', '5-6시간', '7시간 이상'];
                        final isActive = careHours.round() == index + 1;
                        return Text(
                          labels[index],
                          style: TextStyle(
                            fontSize: 12,
                            color: isActive ? theme.primaryColor : Colors.grey,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          ),
                        );
                      }),
                    ),
                    Text(
                      getCareHourLabel(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: theme.primaryColor,
                        inactiveTrackColor: Colors.grey.shade300,
                        thumbColor: theme.primaryColor,
                        overlayColor: theme.primaryColor.withAlpha(51),
                        trackHeight: 3.0,
                      ),
                      child: Slider(
                        label: '',  // required to avoid error but hidden
                        value: careHours,
                        onChanged: (val) => setState(() => careHours = val),
                        min: 1,
                        max: 4,
                        divisions: 3,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildTitle("4. 특별히 고려해야 할 건강 상태나 제한사항이 있나요?"),
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
    if (reasonController.text.isEmpty || selectedServices.isEmpty) {
      showCustomSnackbar(
        title: '입력 오류',
        message: '필수 항목을 모두 입력해주세요',
      );
      return;
    }

    final data = {
      'userType': 'senior',
      'reason': reasonController.text,
      'services': selectedServices,
      'otherService': otherServiceController.text,
      'careDuration': getCareHourLabel(),
      'healthNotes': healthNoteController.text,
    };
    debugPrint(data.toString());

    Get.to(() => const SignupCompleteScreen());
  }

  String getCareHourLabel() {
    switch (careHours.round()) {
      case 1:
        return '1-2시간';
      case 2:
        return '3-4시간';
      case 3:
        return '5-6시간';
      case 4:
      default:
        return '7시간 이상';
    }
  }
}