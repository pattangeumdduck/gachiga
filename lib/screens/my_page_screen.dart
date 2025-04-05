import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  String nickname = "사용자 닉네임";
  // 프로필 사진 URL 또는 파일 경로 (없으면 null)
  String? profileImageUrl;

  void _onProfilePhotoTap() {
    // 실제 이미지 피커나 사진 등록 로직
    Get.snackbar("프로필 사진", "프로필 사진을 선택합니다.");
  }

  void _onEditProfile() {
    // 수정 로직 (예: 다이얼로그 또는 별도 화면)
    Get.snackbar("프로필 수정", "프로필 정보를 수정합니다.");
  }

  void _onTermsTap() {
    Get.snackbar("이용약관", "이용약관 페이지로 이동합니다.");
  }

  void _onPrivacyTap() {
    Get.snackbar("개인정보 처리 방침", "개인정보 처리 방침 페이지로 이동합니다.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바 제거
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // 세로 방향으로 가운데 정렬
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 프로필 이미지
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _onProfilePhotoTap,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: profileImageUrl != null
                      ? NetworkImage(profileImageUrl!)
                      : const AssetImage('assets/images/image_needs.jpg')
                          as ImageProvider,
                ),
              ),
              const SizedBox(height: 16),
              // 닉네임
              Text(
                nickname,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // 수정 버튼
              TextButton(
                onPressed: _onEditProfile,
                child: const Text("수정"),
              ),
              const Spacer(),
              // 하단 링크 버튼들
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _onTermsTap,
                    child: const Text("이용약관"),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: _onPrivacyTap,
                    child: const Text("개인정보 처리 방침"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
