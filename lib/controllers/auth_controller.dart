import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = true.obs;

  void login() {
    isLoggedIn.value = true;
  }

  void logout() {
    isLoggedIn.value = true;
  }
}
