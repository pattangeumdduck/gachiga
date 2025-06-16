import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 상단 카드
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // 프로필 정보
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person, size: 36),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Chip(
                            label: Text(
                              '주니어',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor: Colors.blue,
                            visualDensity: VisualDensity.compact,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '같이가 테스터 님',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'gachiga123@gmail.com',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.settings),
                          SizedBox(width: 8),
                          Icon(Icons.notifications_none),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 내 프로필 보기 버튼
                  OutlinedButton(
                    onPressed: () {
                      // TODO: 프로필 보기
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: theme.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('내 프로필 보기'),
                  ),

                  const SizedBox(height: 16),

                  // 신청 목록 + 돌봄 데이터 버튼 (SVG)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // TODO: 신청 목록 보기
                        },
                        child: SvgPicture.asset(
                          'assets/images/mypage_admit_list_button.svg',
                          height: 30,
                        ),
                      ),
                      const SizedBox(width: 24),
                      GestureDetector(
                        onTap: () {
                          // TODO: 돌봄 데이터 보기
                        },
                        child: SvgPicture.asset(
                          'assets/images/care_data_button.svg',
                          height: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 하단 메뉴 1
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '메뉴 1',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ...List.generate(
              3,
              (i) => const ListTile(
                title: Text('마이 홈 메뉴'),
              ),
            ),
            const Divider(),

            // 하단 메뉴 2
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '메뉴 2',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ...List.generate(
              3,
              (i) => const ListTile(
                title: Text('마이 홈 메뉴'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
