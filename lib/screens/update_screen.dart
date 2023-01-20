import 'dart:convert';
import 'package:arkhive/global_data.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List<OperatorModel> operators = [];
  String updateStatus = '대기';
  int cnt = 0;
  int remainDownloadAssets = 0;
  Uint8List? imageBytes1;
  Uint8List? imageBytes2;

  void firebaseUpdater() async {
    setState(() {
      updateStatus = '오퍼레이터 업데이트 중...';
    });
    // DOWNLOAD
    try {
      final prefs = await SharedPreferences.getInstance();
      /**
       * OPERATOR
       */
      // JSON DATA
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref("data");
      DatabaseReference databaseChild = databaseRef.child("operator");
      // Get data
      DatabaseEvent databaseEvent = await databaseChild.once();
      // Save data
      await prefs.setString(
          'operator_data', jsonEncode(databaseEvent.snapshot.value));

      var jsonDatas = jsonDecode(jsonEncode(databaseEvent.snapshot.value));
      remainDownloadAssets = jsonDatas['data'].length;

      // IMAGE DATA
      Reference storageRef = FirebaseStorage.instance.ref("data");
      Uint8List? imageData;
      for (var jsonData in jsonDatas['data']) {
        var opname = jsonData['image_name'];
        // 이미지는 데이터가 없는 경우만
        if (prefs.getString('operator/$opname') == null) {
          // Get data
          try {
            // From local
            imageData =
                (await rootBundle.load('assets/images/operators/$opname.png'))
                    .buffer
                    .asUint8List();
          } catch (_) {
            // From firebase
            var storageChild = storageRef.child("operator/$opname.png");
            imageData =
                await storageChild.getData(1024 * 100); // get under 500kb image
          }
          // Save Data
          if (imageData != null) {
            var base64Image = base64.encode(imageData);
            await prefs.setString('operator/$opname', base64Image);
          }
          setState(() {
            cnt = cnt + 1;
          });
        } else {
          remainDownloadAssets = remainDownloadAssets - 1;
        }
      }

      setState(() {
        remainDownloadAssets = 0;
        updateStatus = '적 업데이트 중...';
      });
      /**
       * ENEMY
       */
      // JSON DATA
      //  databaseRef = FirebaseDatabase.instance.ref("data");
      databaseChild = databaseRef.child("enemy");
      // Get data
      databaseEvent = await databaseChild.once();
      // Save data
      await prefs.setString(
          'operator_enemy', jsonEncode(databaseEvent.snapshot.value));

      jsonDatas = jsonDecode(jsonEncode(databaseEvent.snapshot.value));
      remainDownloadAssets = jsonDatas['data'].length;

      // IMAGE DATA
      // storageRef = FirebaseStorage.instance.ref("data");
      imageData = null;
      for (var jsonData in jsonDatas['data']) {
        var enemyname = jsonData['image_name'];
        // 이미지는 데이터가 없는 경우만
        if (prefs.getString('enemy/$enemyname') == null) {
          // Get data
          try {
            // From local
            imageData =
                (await rootBundle.load('assets/images/enemies/$enemyname.png'))
                    .buffer
                    .asUint8List();
          } catch (_) {
            // From firebase
            var storageChild = storageRef.child("enemy/$enemyname.png");
            imageData =
                await storageChild.getData(1024 * 100); // get under 500kb image
          }
          // Save Data
          if (imageData != null) {
            var base64Image = base64.encode(imageData);
            await prefs.setString('enemy/$enemyname', base64Image);
          }
          setState(() {
            cnt = cnt + 1;
          });
        } else {
          remainDownloadAssets = remainDownloadAssets - 1;
        }
      }
    } catch (e) {
      print(e);
    }

    // APPLY
    try {
      GlobalData().globalDataInitializer();
    } catch (e) {
      print(e);
    }
    setState(() {
      updateStatus = '업데이트 완료!';
    });
  }

  // void getData() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();

  //     // GET operator json data
  //     final String? operatorStringData = prefs.getString('operator_data');
  //     if (operatorStringData != null) {
  //       var data = await json.decode(operatorStringData)['data'];
  //       for (var jsonData in data) {
  //         operators.add(OperatorModel.fromJson(jsonData));
  //       }
  //     }

  //     // GET operator image data
  //     String? operatorImageStringData = prefs.getString('operator/12f');
  //     if (operatorImageStringData != null) {
  //       imageBytes1 = base64Decode(operatorImageStringData);
  //     }
  //     operatorImageStringData = prefs.getString('operator/suzuran');
  //     if (operatorImageStringData != null) {
  //       imageBytes2 = base64Decode(operatorImageStringData);
  //     }
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     setState(() {});
  //   }
  // }

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
              // const SizedBox(
              //   width: 10,
              // ),
              // TextButton(
              //   onPressed: getData,
              //   style: TextButton.styleFrom(
              //     backgroundColor: Colors.blue,
              //   ),
              //   child: const Text(
              //     '데이터 가져오기',
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // )
            ],
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('상태: $updateStatus'),
                  Text("데이터 다운로드: $cnt/$remainDownloadAssets"),
                  imageBytes1 != null
                      ? Image.memory(imageBytes1!)
                      : Container(),
                  imageBytes2 != null ? Image.memory(imageBytes2!) : Container()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
