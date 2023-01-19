import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Uint8List?> getImageFromSP(String key) async {
  final prefs = await SharedPreferences.getInstance();

  String? operatorImageStringData = prefs.getString(key);
  if (operatorImageStringData != null) {
    return base64Decode(operatorImageStringData);
  }
  return null;
}
