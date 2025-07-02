import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gachiga1/controllers/auth_controller.dart';
import 'package:gachiga1/screens/my_page_screen.dart';
import 'package:gachiga1/screens/care_screen.dart';
import 'package:gachiga1/screens/matching_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': selectedIndex == 0
            ? 'assets/images/Selected=Yes, Type=Home.svg'
            : 'assets/images/Selected=No, Type=Home.svg',
        'label': '홈',
        'color': selectedIndex == 0 ? Colors.blue : Colors.grey,
      },
      {
        'icon': selectedIndex == 1
            ? 'assets/images/Selected=Yes, Type=Share.svg'
            : 'assets/images/Selected=No, Type=Share.svg',
        'label': '쉐어 하우스',
        'color': selectedIndex == 1 ? Colors.blue : Colors.grey,
      },
      {
        'icon': selectedIndex == 2
            ? 'assets/images/Selected=Yes, Type=Care.svg'
            : 'assets/images/Selected=No, Type=Care.svg',
        'label': '케어',
        'color': selectedIndex == 2 ? Colors.blue : Colors.grey,
      },
      {
        'icon': selectedIndex == 3
            ? 'assets/images/Selected=Yes, Type=My.svg'
            : 'assets/images/Selected=No, Type=My.svg',
        'label': '마이 홈',
        'color': selectedIndex == 3 ? Colors.blue : Colors.grey,
      },
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: SvgPicture.asset(
              items[index]['icon'] as String,
              width: 56,
              height: 56,
            ),
          );
        }),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: _selectedIndex == 2
          ? null
          : _selectedIndex == 1
          ? null
          : AppBar(
              title: Text(
                _selectedIndex == 3 ? '마이 홈' : '같이가',
              ),
              centerTitle: true,
              actions: [
                Obx(() => TextButton(
                      onPressed: () {
                        if (authController.isLoggedIn.value) {
                          authController.logout();
                          Get.snackbar('로그아웃', '로그아웃 되었습니다');
                        } else {
                          Get.toNamed('/login');
                        }
                      },
                      child: Text(
                        authController.isLoggedIn.value ? '로그아웃' : '로그인',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Center(
              child:
                  Text('홈', style: Theme.of(context).textTheme.headlineSmall)),
          const MatchingScreen(),
          const CareScreen(),
          const MyPageScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
