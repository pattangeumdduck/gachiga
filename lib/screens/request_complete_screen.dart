import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestCompleteScreen extends StatelessWidget {
  const RequestCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, size: 80, color: Colors.blue),
                const SizedBox(height: 24),
                const Text(
                  "케어\n신청 완료",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 48),
                OutlinedButton(
                  onPressed: () {
                    // 보낸 신청 목록 등으로 이동
                    Get.offNamed("/request-outbox");
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    side: const BorderSide(color: Colors.blue),
                  ),
                  child: const Text("목록으로 가기", style: TextStyle(color: Colors.blue)),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // 홈으로 이동
                    Get.offAllNamed("/home");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text("홈으로 이동"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
