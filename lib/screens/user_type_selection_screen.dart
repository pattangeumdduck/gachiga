import 'package:flutter/material.dart';

class UserTypeSelectionScreen extends StatelessWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 유형 선택'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '회원 유형을 선택해주세요.',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                // 시니어 회원가입 화면 이동 (추후 구현)
              },
              child: const Text('시니어로 가입하기'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                // 주니어 회원가입 화면 이동 (추후 구현)
              },
              child: const Text('주니어로 가입하기'),
            ),
          ],
        ),
      ),
    );
  }
}
