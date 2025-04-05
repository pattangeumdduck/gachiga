import 'package:flutter/material.dart';

class AppTheme {
  // 스크린샷에 나타난 파란색, 텍스트, 배경색 등 추정 색상
  static const Color primary = Color(0xFF0062FF);  // 상단바 및 주요 버튼 컬러
  static const Color background = Color(0xFFFFFFFF); // 흰색 배경
  static const Color text = Color(0xFF333333);      // 어두운 회색 텍스트
  static const Color borderColor = Color(0xFFE5E5E5); // 카드/테두리에 사용
  static const Color stepInactiveCircle = Color(0xFFF2F2F2); // 단계표시 비활성 원

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: background,
    primaryColor: primary,
    // ColorScheme을 직접 지정해서 전체적인 색상 정의
    colorScheme: const ColorScheme(
      primary: primary,
      onPrimary: Colors.white,
      secondary: primary,      // 보조색도 동일하게 사용 (필요시 변경)
      onSecondary: Colors.white,
      background: background,
      onBackground: text,
      surface: background,
      onSurface: text,
      error: Colors.red,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    // AppBar 스타일
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    // 텍스트 스타일
    textTheme: const TextTheme(
      // 화면 제목(예: "가입 유형을 선택하세요")에 사용
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: text,
      ),
      // 일반 본문
      bodyMedium: TextStyle(
        fontSize: 14,
        color: text,
      ),
    ),
    // TextField, TextFormField 등 입력창 스타일
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white, // 배경 흰색
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: primary),
      ),
    ),
    // ElevatedButton 스타일
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
