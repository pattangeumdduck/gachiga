import 'package:flutter/material.dart';

class CareDetailScreen extends StatelessWidget {
  final Map<String, dynamic> careItem;

  const CareDetailScreen({Key? key, required this.careItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    // 좌우 16px 패딩을 고려한 후 화면 가로 폭의 80%를 정사각형으로 사용
    final double imageSize = (deviceWidth - 32) * 0.8;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            // 중앙에서 위쪽으로 약간 이동 (y: -0.3)
            alignment: const Alignment(0, -0.6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 정사각형 이미지 영역
                Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                  child: careItem['profileImageUrl'] != null
                      ? Image.network(
                          careItem['profileImageUrl'],
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                ),
                const SizedBox(height: 16),
                // 간단한 설명
                Text(
                  careItem['description'] ?? '',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // 설문 내용
                Text(
                  careItem['survey'] ?? '',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
