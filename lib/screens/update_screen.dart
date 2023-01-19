import 'dart:convert';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List<OperatorModel> operators = [];
  Uint8List? imageBytes;

  void firebaseUpdater() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // GET JSON
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref("data");
      DatabaseReference databaseChild = databaseRef.child("operator");
      // Get data
      DatabaseEvent databaseEvent = await databaseChild.once();
      // Save data
      await prefs.setString(
          'operator_data', jsonEncode(databaseEvent.snapshot.value));

      // GET IMAGES
      Reference storageRef = FirebaseStorage.instance.ref("data");
      Reference storageChild = storageRef.child("operator/12f.png");
      // Get data
      Uint8List? imageData =
          await storageChild.getData(1024 * 500); // get under 500kb image
      // Save data
      String base64Image = base64.encode(imageData!);
      await prefs.setString('operator/12f', base64Image);
    } catch (e) {
      print(e);
    }
  }

  void getData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // GET operator json data
      final String? operatorStringData = prefs.getString('operator_data');
      if (operatorStringData != null) {
        var data = await json.decode(operatorStringData)['data'];
        for (var jsonData in data) {
          operators.add(OperatorModel.fromJson(jsonData));
        }
      }

      // GET operator image data
      String? operatorImageStringData = prefs.getString('operator/12f');
      if (operatorImageStringData != null) {
        imageBytes = base64Decode(operatorImageStringData);
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
                  Text("${operators.length} operator loaded"),
                  imageBytes != null ? Image.memory(imageBytes!) : Container()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
