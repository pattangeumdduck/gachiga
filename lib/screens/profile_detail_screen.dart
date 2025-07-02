import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // 예시: 실제로는 사용자 정보에서 받아와야 함
    String userType = 'junior';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // 살짝 그림자
        centerTitle: true,
        title: const Text(
          '내 프로필',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // 프로필 이미지 + user_type 뱃지 겹치기
            Stack(
              alignment: Alignment.center,
              children: [
                ClipOval(
                  child: SvgPicture.asset(
                    'assets/images/Profile_Icon.svg',
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SvgPicture.asset(
                    userType == 'senior'
                        ? 'assets/images/프로필_가입유형=시니어.svg'
                        : 'assets/images/프로필_가입유형=주니어.svg',
                    height: 28,
                  ),
                ),
              ],
            ),
            // 디바이더
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xFFF0F1F3),
              ),
            ),
            // '기본정보' 소제목
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '기본정보',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            // 나머지 정보(닉네임, 이름, 성별, 이메일, 소개 등)
            _buildTextField("별명", "같이가 테스터 님"),
            _buildTextField("이름", "홍길동"),
            _buildTextField("성별", "남성"),
            _buildTextField("이메일", "gachiga123@gmail.com"),
            _buildTextField("소개", "안녕하세요!"),
            const SizedBox(height: 24),
            // '서류 인증' 소제목 (학교/경력 카드 위에만 위치)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '서류 인증',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            // 서류 인증 카드 (학교)
            _buildDocumentCard(
              title: '학교',
              certified: true,
              certificationIcon: 'assets/images/certificated_icon.svg',
              editIcon: 'assets/images/edit_icon_pencil.svg',
              onEdit: () {},
              contentWidgets: [
                Row(
                  children: [
                    Text('홍익대학교 서울캠퍼스', style: TextStyle(fontSize: 15)),
                    SizedBox(width: 8),
                    Text('2학년 (재학중)', style: TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text('예술학 전공', style: TextStyle(fontSize: 15)),
                    SizedBox(width: 8),
                    Text('시각 디자인 복수전공', style: TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            _buildDocumentCard(
              title: '경력',
              certified: true,
              certificationIcon: 'assets/images/certificated_icon.svg',
              editIcon: 'assets/images/edit_icon_pencil.svg',
              onEdit: () {},
              contentWidgets: [
                Text('• 한 과의 사이트에서 23명 과외 경험', style: TextStyle(fontSize: 15)),
                Text('• 란다 멘토 참여', style: TextStyle(fontSize: 15)),
                Text('• 지식인 교육기부 활동 참여', style: TextStyle(fontSize: 15)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 64, // 항목명 너비(원하는 만큼 조절)
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              initialValue: value,
              readOnly: false,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF0F1F3)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF0F1F3)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBDBDBD)),
                ),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard({
    required String title,
    required bool certified,
    required String certificationIcon,
    required String editIcon,
    required VoidCallback onEdit,
    required List<Widget> contentWidgets,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFFD4DFF5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              if (certified)
                SvgPicture.asset(certificationIcon, height: 16),
              const Spacer(),
              GestureDetector(
                onTap: onEdit,
                child: SvgPicture.asset(editIcon, height: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...contentWidgets,
        ],
      ),
    );
  }
}
