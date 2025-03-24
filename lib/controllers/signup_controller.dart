import 'package:get/get.dart';

class SignupController extends GetxController {
  // 회원 유형 및 기타 상태 변수들
  final RxString userType = ''.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final Rx<DateTime> birthDate = DateTime.now().obs;

  // 설문 응답을 저장할 Map (필요에 따라 확장)
  final Map<String, dynamic> commonSurvey = {};

  // 회원 유형 설정 메서드
  void setUserType(String newUserType) {
    userType.value = newUserType;
  }

  // 이메일 설정 메서드
  void setEmail(String newEmail) {
    email.value = newEmail;
  }

  // 비밀번호 설정 메서드
  void setPassword(String newPassword) {
    password.value = newPassword;
  }

  // 생년월일 설정 메서드
  void setBirthDate(DateTime newBirthDate) {
    birthDate.value = newBirthDate;
  }

  // 설문 응답 저장 메서드
  void setSurveyAnswer(String key, dynamic value) {
    commonSurvey[key] = value;
  }
}
