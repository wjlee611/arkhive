import 'dart:convert';

import 'package:arkhive/models/operator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestPageScreen extends StatefulWidget {
  const TestPageScreen({super.key});

  @override
  State<TestPageScreen> createState() => _TestPageScreenState();
}

class _TestPageScreenState extends State<TestPageScreen> {
  OperatorModel? skadi;

  Future<void> loadJsonData() async {
    String data =
        await rootBundle.loadString('assets/json/operator/char_263_skadi.json');
    Map<String, dynamic> jsonData = json.decode(data);
    skadi = OperatorModel.fromJson(jsonData['data']);
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: skadi != null
            ? Column(
                children: [
                  Text(skadi!.name),
                ],
              )
            : Container(),
      ),
    );
  }
}
