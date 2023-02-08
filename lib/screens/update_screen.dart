import 'dart:convert';
import 'package:arkhive/global_data.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:square_percent_indicater/square_percent_indicater.dart';
import 'dart:math' as math;

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  GlobalData globalData = GlobalData();
  String updateStatus = 'Pending';
  int cnt = 0;
  int remainDownloadAssets = 0;

  Future<void> _dataUpdater({
    required String category,
    required String jsonImageKey,
    required FlutterSecureStorage storage,
  }) async {
    // DOWNLOAD
    try {
      setState(() {
        updateStatus = 'Update $category...';
        remainDownloadAssets = 0;
        cnt = 0;
      });
      // JSON DATA
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref("data");
      DatabaseReference databaseChild = databaseRef.child(category);
      // Get data
      DatabaseEvent databaseEvent = await databaseChild.once();
      // Save data
      // await prefs.setString(
      //     '${category}_data', jsonEncode(databaseEvent.snapshot.value));
      await storage.write(
          key: '${category}_data',
          value: jsonEncode(databaseEvent.snapshot.value));

      var jsonDatas =
          await jsonDecode(jsonEncode(databaseEvent.snapshot.value));
      remainDownloadAssets = jsonDatas['data'].length;

      // IMAGE DATA
      Reference storageRef = FirebaseStorage.instance.ref("data");
      Uint8List? imageData;
      for (var jsonData in jsonDatas['data']) {
        var key = jsonData[jsonImageKey];
        // 이미지는 데이터가 없는 경우만
        // if (prefs.getString('$category/$key') == null) {
        if (await storage.read(key: '$category/$key') == null) {
          // Get data
          try {
            // From local
            imageData =
                (await rootBundle.load('assets/images/$category/$key.png'))
                    .buffer
                    .asUint8List();
          } catch (_) {
            // From firebase
            var storageChild = storageRef.child("$category/$key.png");
            imageData =
                await storageChild.getData(1024 * 200); // get under 200kb image
          }
          // Save Data
          if (imageData != null) {
            // await prefs.setString('$category/$key', base64.encode(imageData));
            await storage.write(
                key: '$category/$key', value: base64.encode(imageData));
            print('save image @$category/$key');
          }
          setState(() {
            cnt = cnt + 1;
          });
        } else {
          remainDownloadAssets = remainDownloadAssets - 1;
        }
      }
    } catch (e) {
      print('error at _dataUpdater: $e');
    }
  }

  void firebaseUpdater() async {
    const storage = FlutterSecureStorage();
    // OPERATOR
    await _dataUpdater(
      category: "operator",
      jsonImageKey: "image_name",
      storage: storage,
    );
    // ENEMY
    await _dataUpdater(
      category: "enemy",
      jsonImageKey: "code",
      storage: storage,
    );
    // ITEMS
    await _dataUpdater(
      category: "item",
      jsonImageKey: "code",
      storage: storage,
    );

    try {
      // APPLY
      await globalData.globalDataInitializer();

      if (globalData.newVer == null) {
        // VERSION UPDATE
        DatabaseReference databaseRef =
            FirebaseDatabase.instance.ref("update_checker");
        // Get data
        DatabaseEvent databaseEvent = await databaseRef.once();
        // Save data
        String? stringData = jsonEncode(databaseEvent.snapshot.value);
        // await prefs.setString('update_checker', stringData);
        await storage.write(key: 'update_checker', value: stringData);
        globalData.oldVer = jsonEncode(databaseEvent.snapshot.value);
      } else {
        // await prefs.setString('update_checker', globalData.newVer!);
        await storage.write(key: 'update_checker', value: globalData.newVer!);
        globalData.oldVer = globalData.newVer!;
      }

      setState(() {
        updateStatus = 'Update Completed!';
      });
    } catch (e) {
      print('error at firebaseUpdater: $e');
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 80,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.shade100,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        Container(
                          color: Colors.blueGrey.shade600,
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/prts.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                globalData.newVer == null
                                    ? "오프라인 상태에선 업데이트 할 수 없습니다.\n종료하신 후 네트워크에 연결하신 후 다시 시도해주세요."
                                    : updateStatus == "Pending"
                                        ? "박사님, [데이터 업데이트]를 터치하시어 업데이트를 진행하실 수 있습니다. 서버 과부화 방지를 위해 잦은 업데이트는 삼가 부탁드립니다."
                                        : updateStatus == "Update Completed!"
                                            ? "업데이트가 완료되었습니다. 이 화면에서 나가셔도 좋습니다."
                                            : "데이터 업데이트 중에는 이 화면에서 나가지 말아주시길 당부드립니다.",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 0.1,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 22,
                          width: 40,
                          child: Center(
                            child: Text(
                              "상태",
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 10,
                                fontFamily: FontFamily.nanumGothic,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 22,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          color: Colors.yellow.shade700,
                          child: Center(
                            child: Text(
                              updateStatus,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: FontFamily.nanumGothic,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.rotate(
                        angle: 45 * math.pi / 180,
                        child: SquarePercentIndicator(
                          width: 100,
                          height: 100,
                          borderRadius: 0,
                          startAngle: StartAngle.topLeft,
                          shadowWidth: 2,
                          progressWidth: 5,
                          progressColor: Colors.yellow.shade700,
                          shadowColor: Colors.grey,
                          progress: remainDownloadAssets == 0
                              ? 0
                              : cnt / remainDownloadAssets,
                        ),
                      ),
                      remainDownloadAssets == 0
                          ? Container()
                          : Column(
                              children: [
                                Text(
                                  "${((cnt / remainDownloadAssets) * 100).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    color: Colors.yellow.shade700,
                                    fontFamily: FontFamily.nanumGothic,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "$cnt/$remainDownloadAssets",
                                  style: TextStyle(
                                    color: Colors.yellow.shade700,
                                    fontFamily: FontFamily.nanumGothic,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: updateStatus == 'Pending' &&
                                globalData.newVer != null
                            ? firebaseUpdater
                            : null,
                        style: TextButton.styleFrom(
                          backgroundColor: updateStatus == 'Pending' &&
                                  globalData.newVer != null
                              ? Colors.yellow.shade700
                              : Colors.grey,
                        ),
                        child: const Text(
                          '데이터 업데이트',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: FontFamily.nanumGothic,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
