import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<Uint8List?> getImageFromSP(String key) async {
  const storage = FlutterSecureStorage();

  String? operatorImageStringData = await storage.read(key: key);
  if (operatorImageStringData != null) {
    return base64Decode(operatorImageStringData);
  }
  return null;
}
