// lib/widgets/custom_snackbar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  required String title,
  required String message,
  IconData icon = Icons.error_outline,
  Color backgroundColor = const Color(0xFF2D2F34),
}) {
  Get.snackbar(
    '', '', // title/message는 아래 커스텀 위젯으로 대체됨
    snackPosition: SnackPosition.TOP,
    backgroundColor: backgroundColor,
    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    padding: const EdgeInsets.all(16),
    borderRadius: 16,
    duration: const Duration(seconds: 2),
    isDismissible: true,
    icon: Icon(icon, color: Colors.white, size: 24),
    titleText: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 14,
      ),
    ),
  );
}
