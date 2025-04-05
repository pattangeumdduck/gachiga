import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({Key? key}) : super(key: key);

  void _onDownload() {
    Get.snackbar('신청서 다운로드', '신청서 다운로드 기능 구현 예정입니다.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱 바 제거됨
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "gachiga88@gmail.com 으로 \n신청서를 작성하여 보내주세요!",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onDownload,
                child: const Text("신청서 다운로드"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
