import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<Uint8List?> getImageFromSP(String key) async {
  // final prefs = await SharedPreferences.getInstance();
  const storage = FlutterSecureStorage();

  // String? operatorImageStringData = prefs.getString(key);
  String? operatorImageStringData = await storage.read(key: key);
  if (operatorImageStringData != null) {
    return base64Decode(operatorImageStringData);
  }
  return null;
}
