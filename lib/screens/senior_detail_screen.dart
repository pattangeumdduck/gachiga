import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SeniorDetailScreen extends StatelessWidget {
  const SeniorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("시니어 정보"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.favorite_border), // 찜하기
          SizedBox(width: 12),
          Icon(Icons.share), // 공유하기
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            const SizedBox(height: 24),
            _buildCareInfoSection(),
            const SizedBox(height: 24),
            _buildLocationInfoSection(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // 케어 제안 처리
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size.fromHeight(48),
          ),
          child: const Text("케어 제안하기"),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        const CircleAvatar(radius: 32, child: Icon(Icons.person)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("양찬구 봉주역", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("가입일: 2025-07-10", style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(height: 8),
              Wrap(
                spacing: 12,
                children: [
                  _Tag("여성"),
                  _Tag("65세"),
                  _Tag("무직"),
                  _Tag("경기도"),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCareInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("케어 정보", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 12),
        Text("필요한 케어", style: TextStyle(color: Colors.grey)),
        SizedBox(height: 4),
        Text("정서 교류 및 관계 형성\n생활 및 자립 지원", style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 12),
        Text("돌봄 일정", style: TextStyle(color: Colors.grey)),
        SizedBox(height: 4),
        Text("월요일, 화요일, 수요일, 시간 협의 가능"),
        SizedBox(height: 12),
        Text("참고사항", style: TextStyle(color: Colors.grey)),
        SizedBox(height: 4),
        Text("돌봄 경험이 있는 선호자를 찾고 있습니다. 대형견 1마리를 기르고 있습니다."),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            _Tag("63세"),
            _Tag("여성"),
            _Tag("생활지원"),
            _Tag("서울 용산구"),
            _Tag("시간 협의 가능"),
            _Tag("정서케어"),
            _Tag("언어교류"),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("지역 정보", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        const Text("서울 구로구 경인로 661 (신도림동, 신도림1차푸르지오) 힐포인트타워 23층 바비앤4S교육센터"),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          children: [
            _SubwayBadge("1호선", Colors.blue),
            _SubwayBadge("2호선", Colors.green),
            _SubwayBadge("도림천", Colors.lightBlue),
          ],
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () async {
            final encoded = Uri.encodeFull("신도림동");
            final url = Uri.parse("https://map.naver.com/v5/search/$encoded");
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text("🗺 지도 보기", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}

class _SubwayBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _SubwayBadge(this.label, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }
}
