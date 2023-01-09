import 'package:flutter/material.dart';

DateTime? _currentBackPressTime;

class WillPopFunction {
  static Future<bool> onWillPop({required BuildContext context}) {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('종료할까요?'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.blueGrey.shade700,
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
