import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'request_inbox_screen.dart';
import 'profile_detail_screen.dart';

class CareScreen extends StatelessWidget {
  const CareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> bannerImages = [
      'assets/images/care_upper_banner=page1.svg',
      'assets/images/care_upper_banner=page2.svg',
      'assets/images/care_upper_banner=page3.svg',
    ];
    final List<VoidCallback> bannerRoutes = [
      () => Get.toNamed('/care-banner-1'),
      () => Get.toNamed('/care-banner-2'),
      () => Get.toNamed('/care-banner-3'),
    ];
    final PageController _pageController = PageController();
    int _currentPage = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: SvgPicture.asset(
            'assets/images/login_logo.svg',
            height: 28,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RequestInboxScreen()),
              );
            },
            child: const Text("신청목록", style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
      body: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: bannerImages.length,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: bannerRoutes[index],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: SvgPicture.asset(
                          bannerImages[index],
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // 페이지 인디케이터
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(bannerImages.length, (index) =>
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index ? Colors.blue : Colors.grey[300],
                    ),
                  ),
                ),
              ),
              _buildSearchBar(),
              _buildTagFilters(),
              const Divider(height: 1),
              Expanded(child: _buildCareList()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "닉네임, 검색 내용",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: 필터 기능
            },
          )
        ],
      ),
    );
  }

  Widget _buildTagFilters() {
    final tags = ["전체", "정서 교류 및 관계 형성", "맞춤형", "왕복", "차량", "폰 텔레 상담"];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          return Chip(
            label: Text(tags[index]),
            backgroundColor: Colors.grey[200],
          );
        },
      ),
    );
  }

  Widget _buildCareList() {
    return ListView.builder(
      itemCount: 4, // 샘플 4개
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(radius: 20, child: Icon(Icons.person)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("가나다란 돌봄 102", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(
                      "시니어 가나다란 돌봄활동 102건에 유니아버 분활을 요청합니다.",
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _CareTag("여성"),
                        _CareTag("70대"),
                        _CareTag("왕복"),
                        _CareTag("이해, 정서"),
                        _CareTag("정리"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _CareTag extends StatelessWidget {
  final String label;
  const _CareTag(this.label, {super.key});

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
