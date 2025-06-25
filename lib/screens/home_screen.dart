import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gachiga1/controllers/auth_controller.dart';
import 'package:gachiga1/screens/my_page_screen.dart';
import 'package:gachiga1/screens/care_screen.dart';
import 'package:gachiga1/screens/matching_screen.dart';

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
      appBar: AppBar(
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                _selectedIndex == 0
                    ? 'assets/images/Selected=Yes, Type=Home.svg'
                    : 'assets/images/Selected=No, Type=Home.svg',
                fit: BoxFit.contain,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                _selectedIndex == 1
                    ? 'assets/images/Selected=Yes, Type=Share.svg'
                    : 'assets/images/Selected=No, Type=Share.svg',
                fit: BoxFit.contain,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                _selectedIndex == 2
                    ? 'assets/images/Selected=Yes, Type=Care.svg'
                    : 'assets/images/Selected=No, Type=Care.svg',
                fit: BoxFit.contain,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                _selectedIndex == 3
                    ? 'assets/images/Selected=Yes, Type=My.svg'
                    : 'assets/images/Selected=No, Type=My.svg',
                fit: BoxFit.contain,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
