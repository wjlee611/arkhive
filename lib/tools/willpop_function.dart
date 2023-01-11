import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

DateTime? _currentBackPressTime;

class WillPopFunction {
  static Future<bool> onWillPop({required BuildContext context}) async {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            '종료할까요?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: FontFamily.nanumGothic,
              fontWeight: FontWeight.w700,
            ),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
