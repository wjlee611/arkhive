import 'dart:convert';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/global_data.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/updater_models.dart';
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
  int downloadedAssets = 0;
  int remainDownloadAssets = 0;

  // void firebaseUpdater() async {
  //   const storage = FlutterSecureStorage();
  //   // OPERATOR
  //   await _dataUpdater(
  //     category: "operator",
  //     jsonImageKey: "image_name",
  //     storage: storage,
  //   );
  //   // ENEMY
  //   await _dataUpdater(
  //     category: "enemy",
  //     jsonImageKey: "code",
  //     storage: storage,
  //   );
  //   // ITEMS
  //   await _dataUpdater(
  //     category: "item",
  //     jsonImageKey: "code",
  //     storage: storage,
  //   );

  //   try {
  //     // APPLY
  //     await globalData.globalDataInitializer();

  //     if (globalData.newVer == null) {
  //       // VERSION UPDATE
  //       DatabaseReference databaseRef =
  //           FirebaseDatabase.instance.ref("update_checker");
  //       // Get data
  //       DatabaseEvent databaseEvent = await databaseRef.once();
  //       // Save data
  //       String? stringData = jsonEncode(databaseEvent.snapshot.value);
  //       await storage.write(key: 'update_checker', value: stringData);
  //       globalData.oldVer = jsonEncode(databaseEvent.snapshot.value);
  //     } else {
  //       await storage.write(key: 'update_checker', value: globalData.newVer!);
  //       globalData.oldVer = globalData.newVer!;
  //     }

  //     setState(() {
  //       updateStatus = 'Update Completed!';
  //     });
  //   } catch (e) {
  //     print('error at firebaseUpdater: $e');
  //   }
  // }

  void _onUpdateTap() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    const storage = FlutterSecureStorage();
    remainDownloadAssets = 0;
    downloadedAssets = 0;
    Map<String, List<String>> dataLists = {};

    setState(() {
      updateStatus = 'Check dependency...';
    });
    // Add update required file depend on version
    var depRef = databaseRef.child('data_dependency');
    DatabaseEvent databaseEvent = await depRef.once();
    Map<String, dynamic> jsonData =
        await json.decode(json.encode(databaseEvent.snapshot.value));
    UpdateVersionsModel ver = UpdateVersionsModel.fromJson(jsonData);
    UpdateDependencyModel updateRemain = UpdateDependencyModel();
    for (var version in ver.versions.keys) {
      if (ver.versions[version] != null) {
        UpdateDependencyModel dep = ver.versions[version]!;
        for (var category in dep.categories.keys) {
          if (dep.categories[category] != null) {
            var newCategory =
                category == 'operator_patch' ? 'operator' : category;
            dataLists[newCategory] = dataLists[newCategory] ?? [];
            for (var data in dep.categories[category]!) {
              dataLists[newCategory]!.add(data);
              // Add only missing data
              if (!await storage.containsKey(key: '$newCategory/$data')) {
                updateRemain.add(key: category, value: data);
                // Add image
                if (newCategory == 'operator') {
                  updateRemain.add(key: 'image/operator', value: data);
                }
              }
            }
          }
        }
      }
    }
    // Deduplication
    for (var category in updateRemain.categories.keys) {
      if (updateRemain.categories[category] != null) {
        updateRemain.categories[category] =
            updateRemain.categories[category]!.toSet().toList();
        remainDownloadAssets += updateRemain.categories[category]!.length;
      }
    }
    for (var category in dataLists.keys) {
      if (dataLists[category] != null) {
        dataLists[category] = dataLists[category]!.toSet().toList();
      }
    }

    setState(() {
      updateStatus = 'Update...';
    });
    for (var category in updateRemain.categories.keys) {
      if (updateRemain.categories[category] != null) {
        await _dataUpdater(
          databaseRef: databaseRef,
          category: category,
          dependencies: updateRemain.categories[category]!,
        );
      }
    }
    for (var category in dataLists.keys) {
      if (dataLists[category] != null) {
        Map<String, List<String>> listJson = {"data": dataLists[category]!};
        await storage.write(
            key: 'list_$category', value: json.encode(listJson));
      }
    }

    setState(() {
      updateStatus = 'Completed!';
    });
  }

  Future<void> _dataUpdater({
    required DatabaseReference databaseRef,
    required String category,
    required List<String> dependencies,
  }) async {
    const storage = FlutterSecureStorage();
    Map<String, dynamic> localData = {};
    String serverPath = '';
    String savePath = '';

    switch (category) {
      case 'operator':
      case 'token':
      case 'trap':
        {
          try {
            localData = await json.decode(await rootBundle
                .loadString('assets/json/character_table.json'));
          } catch (_) {}
          serverPath = 'data/character_table';
          savePath = category;
          break;
        }
      case 'operator_patch':
        {
          try {
            localData = await json.decode(await rootBundle
                .loadString('assets/json/char_patch_table.json'))['patchChars'];
          } catch (_) {}
          serverPath = 'data/char_patch_table/patchChars';
          savePath = 'operator';
          break;
        }
    }

    if (category.contains('image/')) {
      // Image
      for (var dependency in dependencies) {
        Reference storageRef = FirebaseStorage.instance.ref("data");
        String imageCat = category.split('/').last;
        Uint8List? imageData;
        try {
          // From local
          imageData =
              (await rootBundle.load('assets/images/$imageCat/$dependency.png'))
                  .buffer
                  .asUint8List();
        } catch (_) {
          // From firebase
          print('image');
          var storageChild = storageRef.child("$imageCat/$dependency.png");
          imageData = await storageChild.getData(1024 * 200);
        }
        if (imageData != null) {
          await storage.write(
              key: '$category/$dependency', value: base64.encode(imageData));
        } else {
          print('skip: $category/$dependency');
        }

        setState(() {
          downloadedAssets += 1;
        });
      }
    } else {
      // Data
      for (var dependency in dependencies) {
        Map<String, dynamic>? resData;
        if (localData[dependency] != null) {
          // From local
          resData = localData[dependency];
        } else {
          // From firebase
          print('data');
          var depRef = databaseRef.child('$serverPath/$dependency');
          DatabaseEvent databaseEvent = await depRef.once();
          resData =
              await json.decode(json.encode(databaseEvent.snapshot.value));
        }
        if (resData != null) {
          await storage.write(
              key: '$savePath/$dependency', value: json.encode(resData));
        } else {
          print('skip: $category/$dependency');
        }

        setState(() {
          downloadedAssets += 1;
        });
      }
    }
  }

  void _onDeleteTap() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
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
                    current: downloadedAssets,
                    remain: remainDownloadAssets,
                  ),
                  Gaps.v28,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: updateStatus == 'Pending' &&
                                globalData.newVer != null
                            ? _onUpdateTap
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
                      Gaps.v10,
                      TextButton(
                        onPressed: _onDeleteTap,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          '데이터 초기화',
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
