import 'dart:convert';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List<OperatorModel> operators = [];

  void firebaseUpdater() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DatabaseReference ref = FirebaseDatabase.instance.ref("data");
      // Access a child of the current reference
      DatabaseReference child = ref.child("operator");
      // Get data
      DatabaseEvent event = await child.once();
      // Save data
      await prefs.setString('operator_data', jsonEncode(event.snapshot.value));
    } catch (e) {
      print(e);
    }
  }

  void getData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final String? operatorStringData = prefs.getString('operator_data');
      if (operatorStringData != null) {
        var data = await json.decode(operatorStringData)['data'];
        for (var jsonData in data) {
          operators.add(OperatorModel.fromJson(jsonData));
        }
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Updater',
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: firebaseUpdater,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  '데이터 불러오기/저장',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: getData,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  '데이터 가져오기',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var op in operators) Text(op.name),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
