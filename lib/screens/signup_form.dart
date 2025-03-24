import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/controllers/signup_controller.dart';
import 'package:gachiga1/screens/survey_common.dart';

class SignupFormScreen extends StatefulWidget {
  const SignupFormScreen({super.key});

  @override
  State<SignupFormScreen> createState() => _SignupFormScreenState();
}

class _SignupFormScreenState extends State<SignupFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.find<SignupController>();

    return Scaffold(
      appBar: AppBar(title: const Text('기본 정보 입력')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: '이메일'),
                validator: (value) =>
                    value!.isEmpty ? '이메일을 입력해주세요' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: '비밀번호'),
                obscureText: true,
                validator: (value) => value!.length < 6 ? '6자 이상 입력해주세요' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(_selectedDate == null
                      ? '생년월일을 선택해주세요'
                      : '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}'),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime(1950),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                    },
                    child: const Text('선택'),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _selectedDate != null) {
                    controller.setEmail(_emailController.text);
                    controller.setPassword(_passwordController.text);
                    controller.setBirthDate(_selectedDate!);
                    Get.to(() => const SurveyCommonScreen());
                  }
                },
                child: const Text('다음'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
