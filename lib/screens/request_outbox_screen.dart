import 'package:flutter/material.dart';
import 'package:gachiga1/screens/request_inbox_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RequestOutboxScreen extends StatefulWidget {
  const RequestOutboxScreen({super.key});

  @override
  State<RequestOutboxScreen> createState() => _RequestOutboxScreenState();
}

class _RequestOutboxScreenState extends State<RequestOutboxScreen> {
  bool isInboxSelected = false; // 보낸 신청이 선택된 상태

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("신청 목록", style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF1D60E7),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabBar(context),
          //const Divider(height: 1),
          Expanded(child: _buildRequestList()),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          // 받은 신청 버튼
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isInboxSelected = true;
                });
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const RequestInboxScreen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: isInboxSelected ? Colors.white : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    "받은 신청",
                    style: TextStyle(
                      color: isInboxSelected ? Colors.black : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 보낸 신청 버튼
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isInboxSelected = false;
                });
              },
              child: Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: !isInboxSelected ? Colors.white : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    "보낸 신청",
                    style: TextStyle(
                      color: !isInboxSelected ? Colors.black : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestList() {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (_, __) => SizedBox.shrink(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  'assets/images/Profile_Icon.svg',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("가느다란 물방울", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(
                      "시니어 가느다란 물방울님께 돌봄활동 제공 의향을 물었습니다.",
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _RequestTag("여성"),
                        _RequestTag("70대"),
                        _RequestTag("양천구"),
                        _RequestTag("아침, 점심"),
                        _RequestTag("3단계"),
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

class _RequestTag extends StatelessWidget {
  final String label;
  const _RequestTag(this.label, {super.key});

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
