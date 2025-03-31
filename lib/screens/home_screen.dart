import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gachiga1/controllers/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('홈')),
    Center(child: Text('매칭')),
    Center(child: Text('케어')),
    Center(child: Text('마이')),
  ];

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('같이가'),
        centerTitle: true,
        actions: [
          Obx(() => TextButton(
                onPressed: () {
                  if (authController.isLoggedIn.value) {
                    // 로그아웃 상태로 변경
                    authController.logout();
                    Get.snackbar('로그아웃', '로그아웃 되었습니다');
                  } else {
                    // 로그인 화면으로 이동 (라우트 이름을 사용할 수도 있음)
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake),
            label: '매칭',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '케어',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이',
          ),
        ],
      ),
    );
  }
}
