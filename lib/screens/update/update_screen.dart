import 'dart:convert';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/global_data.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/update/widgets/update_indicator_widget.dart';
import 'package:arkhive/screens/update/widgets/updater_prts_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
        if (await storage.read(key: '$category/$key') == null) {
          // Get data
          try {
            // From local
            imageData =
                (await rootBundle.load('assets/images/$category/$key.png'))
                    .buffer
                    .asUint8List();
          } catch (_) {
            try {
              // From firebase
              var storageChild = storageRef.child("$category/$key.png");
              imageData = await storageChild
                  .getData(1024 * 200); // get under 200kb image
            } catch (_) {
              continue;
            }
          }
          // Save Data
          if (imageData != null) {
            await storage.write(
                key: '$category/$key', value: base64.encode(imageData));
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
        await storage.write(key: 'update_checker', value: stringData);
        globalData.oldVer = jsonEncode(databaseEvent.snapshot.value);
      } else {
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

  void newUpdater() async {
    setState(() {
      updateStatus = 'Update...';
    });

    const storage = FlutterSecureStorage();

    final String operatorList =
        await rootBundle.loadString('assets/json/list_operator.json');
    await storage.write(key: 'list_operator', value: operatorList);

    List<String> operatorListData =
        await json.decode(operatorList)['data']?.cast<String>();
    remainDownloadAssets = operatorListData.length * 2;
    cnt = 0;

    setState(() {
      updateStatus = 'Update data...';
    });
    final String opsString =
        await rootBundle.loadString('assets/json/charactet_table.json');
    var opsJson = await json.decode(opsString);
    if (opsJson != null) {
      for (var operator_ in operatorListData) {
        await storage.write(
            key: 'operator/$operator_', value: json.encode(opsJson[operator_]));
        setState(() {
          cnt += 1;
        });
      }
    }

    setState(() {
      updateStatus = 'Update image...';
    });
    for (var operator_ in operatorListData) {
      final String opImageString = base64.encode(
          (await rootBundle.load('assets/images/operator/$operator_.png'))
              .buffer
              .asUint8List());
      await storage.write(
          key: 'image/operator/$operator_', value: opImageString);
      setState(() {
        cnt += 1;
      });
    }

    setState(() {
      updateStatus = 'Update Completed!';
    });
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
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        child: Column(
          children: [
            Gaps.v20,
            SizedBox(
              height: Sizes.size80,
              child: UpdaterPRTS(
                text: globalData.newVer == null
                    ? "오프라인 상태에선 업데이트 할 수 없습니다.\n종료하신 후 네트워크에 연결하신 후 다시 시도해주세요."
                    : updateStatus == "Pending"
                        ? "박사님, [데이터 업데이트]를 터치하시어 업데이트를 진행하실 수 있습니다. 서버 과부화 방지를 위해 잦은 업데이트는 삼가 부탁드립니다."
                        : updateStatus == "Update Completed!"
                            ? "업데이트가 완료되었습니다. 이 화면에서 나가셔도 좋습니다."
                            : "데이터 업데이트 중에는 이 화면에서 나가지 말아주시길 당부드립니다.",
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
                          blurRadius: Sizes.size2,
                          spreadRadius: Sizes.size1 / 10,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: Sizes.size20,
                          width: Sizes.size40,
                          child: Center(
                            child: Text(
                              "상태",
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: Sizes.size10,
                                fontFamily: FontFamily.nanumGothic,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: Sizes.size20,
                          padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size5),
                          color: Colors.yellow.shade700,
                          child: Center(
                            child: Text(
                              updateStatus,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size12,
                                fontFamily: FontFamily.nanumGothic,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v36,
                  UpdateIndicator(
                    current: cnt,
                    remain: remainDownloadAssets,
                  ),
                  Gaps.v28,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: updateStatus == 'Pending' &&
                                globalData.newVer != null
                            // ? firebaseUpdater
                            ? newUpdater
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
                            fontSize: Sizes.size14,
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
