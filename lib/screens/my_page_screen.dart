import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gachiga1/screens/profile_detail_screen.dart'; // import 추가
import 'request_inbox_screen.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // 예시: 실제로는 사용자 정보에서 받아와야 함
    String userType = 'junior';
    bool profileCompleted = true; // Assuming profileCompleted is true for this example
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 상단 파란색 배경
          Container(
            height: 150,
            color: theme.primaryColor,
          ),
          // 프로필 카드 고정
          Positioned(
            left: 16,
            right: 16,
            top: 14,
            child: Container(
              width: 339,
              height: 285,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFEFEFE),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.11),
                    blurRadius: 10,
                    offset: const Offset(3.109, 4.145),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // 오른쪽 상단 알림/세팅 버튼
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Row(
                      children: const [
                        Icon(Icons.notifications_none),
                        SizedBox(width: 8),
                        Icon(Icons.settings),
                      ],
                    ),
                  ),
                  // 나머지 프로필 카드 내용은 기존 Column 그대로
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 프로필 이미지 + user_type 뱃지 겹치기
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.grey[300],
                            child: const Icon(Icons.person, size: 36),
                          ),
                          Positioned(
                            bottom: -1, // 겹치는 정도 조절
                            child: SvgPicture.asset(
                              userType == 'senior'
                                  ? 'assets/images/프로필_가입유형=시니어.svg'
                                  : 'assets/images/프로필_가입유형=주니어.svg',
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // 뱃지와 이름/이메일 사이 간격 추가
                      SizedBox(height: 6),
                      // 이름, 이메일 등 나머지 정보
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            '같이가 테스터 님',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'gachiga123@gmail.com',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // 내 프로필 보기 버튼
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ProfileDetailScreen());
                        },
                        child: SvgPicture.asset(
                          profileCompleted
                            ? 'assets/images/My_profile_detail_완료여부=Yes.svg'
                            : 'assets/images/My_profile_detail_완료여부=No.svg',
                          width: double.infinity,
                          height: 32,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 신청 목록 + 돌봄 데이터 버튼 (SVG)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() => const RequestInboxScreen()),
                            child: SvgPicture.asset(
                              'assets/images/mypage_admit_list_button.svg',
                              height: 25,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 34,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            color: const Color(0xFFF0F1F3),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/images/care_data_button.svg',
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 메뉴도 스크롤 없이 고정
          Column(
            children: [
              const SizedBox(height: 305),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '계정',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('마이 홈 메뉴', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      SizedBox(height: 8),
                      Text('마이 홈 메뉴', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      SizedBox(height: 8),
                      Text('마이 홈 메뉴', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              // 기존 Divider를 커스텀 Divider로 교체
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFFF0F1F3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '메뉴 1',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('마이 홈 메뉴', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      SizedBox(height: 8),
                      Text('마이 홈 메뉴', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      SizedBox(height: 8),
                      Text('마이 홈 메뉴', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ],
      ),
    );
  }
}
