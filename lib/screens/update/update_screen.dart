import 'dart:convert';
import 'package:arkhive/bloc/versionCheck/version_check_bloc.dart';
import 'package:arkhive/bloc/versionCheck/version_check_event.dart';
import 'package:arkhive/bloc/versionCheck/version_check_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/stage_model.dart';
import 'package:arkhive/models/updater_models.dart';
import 'package:arkhive/screens/update/widgets/update_indicator_widget.dart';
import 'package:arkhive/screens/update/widgets/updater_prts_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  String _updateStatus = 'Pending';
  int _downloadedAssets = 0;
  int _remainDownloadAssets = 0;

  void _onUpdateTap(VersionCheckStateABS state) async {
    if (state is! VersionCheckLoadedState) return;

    var targetDBVersion = state.targetDBVersion; // 업데이트 DB 버전
    if (targetDBVersion == '') return;

    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    const storage = FlutterSecureStorage();

    var targetVersion =
        targetDBVersion.split('_').last; // data_dependency에서 체크할 업데이트 버전
    if (targetVersion == 'N/A' || targetVersion == '') {
      targetVersion = '000000';
    }
    var currVersion = await storage.read(key: 'db_version') ?? 'N/A';
    currVersion = currVersion.split('_').last;
    if (currVersion == 'N/A' || currVersion == '') {
      currVersion = '000000';
    }

    _remainDownloadAssets = 0; // 남은 다운로드가 필요한 파일 수
    _downloadedAssets = 0; // 다운로드가 완료된 파일 수
    List<String> skipList = []; // 다운로드 실패한 항목의 key값을 저장하는 리스트

    // "operator": ["keys"] 형태로 데이터 저장
    // 차후 list_<category> key 값으로 데이터를 저장하여
    // 리스트를 불러오게 하기 위함.
    // 따라서 버전과 관계 없이 모든 데이터를 불러오도록 함.
    Map<String, List<String>> dataLists = {};

    // 업데이트 종속성 검사 단계 //
    setState(() {
      _updateStatus = 'Check dependency...';
    });

    // /data_dependency에서 업데이트 목록을 가져옴
    var depRef = databaseRef.child('data_dependency');
    DatabaseEvent databaseEvent = await depRef.once();
    Map<String, dynamic> jsonData =
        await json.decode(json.encode(databaseEvent.snapshot.value));

    // 아래와 같이 모델링
    // {
    //   "000001": {
    //     "operator": ["keys"],
    //     "enemy": ["keys"]
    //   },
    //   "230611": {
    //     "operator": ["keys"]
    //   },
    // }
    UpdateVersionsModel ver = UpdateVersionsModel.fromJson(jsonData);

    // 업데이트가 필요한 데이터만 저장
    // 아래와 같이 모델링 (ver에서 버전 정보가 빠짐)
    // {
    //   "operator": ["keys"],
    //   "enemy": ["keys"]
    // },
    UpdateDependencyModel updateRemain = UpdateDependencyModel();

    // 버전 검사
    // 기본적으로 000001에 모든 데이터를 저장하여 관리함.
    // 나중에 유지 보수, 버그 픽스시 데이터를 업데이트 해야 하는 경우에만 별도로 버전을 추가함.
    for (var version in ver.versions.keys) {
      if (ver.versions[version] == null) continue;
      // version <= targetVersion 인 경우에만 업데이트
      if (int.parse(version) > int.parse(targetVersion)) continue;

      // currVersion < version 인 경우 업데이트
      // 단, version == 000001은 반드시 탐색
      if (version != '000001' &&
          (int.parse(currVersion) >= int.parse(version))) {
        continue;
      }

      // dep에 ver와 같은 형태로 version에 해당하는 data_dependency를 저장
      UpdateDependencyModel dep = ver.versions[version]!;

      // 카테로리 순회 ("operator", "enemy", "module", "zone" ...)
      for (var category in dep.categories.keys) {
        if (dep.categories[category] == null) continue;

        // 카테고리가 operator_patch인 경우 operator로 변경
        var newCategory = category == 'operator_patch' ? 'operator' : category;

        // dataLists에 카테고리가 없으면 추가
        dataLists[newCategory] = dataLists[newCategory] ?? [];

        // 카테고리에 해당하는 데이터 순회
        for (var data in dep.categories[category]!) {
          // 앞서 말했 듯 dataLists는 데이터의 리스트를 저장하기에
          // 없는 데이터를 검사하지 않고 추가.
          dataLists[newCategory]!.add(data);

          // version == '000001'인 경우에는 데이터가 없는 경우에만 updateRemain에 추가
          // 그 외의 경우에는 반드시 updateRemain에 추가
          if (version == '000001') {
            if (await storage.containsKey(key: '$newCategory/$data')) continue;
          }
          updateRemain.add(key: category, value: data);
          // Add image
          if (newCategory == 'operator') {
            updateRemain.add(key: 'image/operator', value: data);
          }
          if (newCategory == 'enemy') {
            updateRemain.add(key: 'image/enemy', value: data);
          }
          // TODO: Item image 추가
          // Add module data
          if (newCategory == 'module') {
            updateRemain.add(key: 'module_data', value: data);
          }
          // Add enemy data
          if (newCategory == 'enemy') {
            updateRemain.add(key: 'enemy_data', value: data);
          }
          // Add zone2activity
          if (newCategory == 'zone' && data.contains('_zone')) {
            updateRemain.add(key: 'zone2activity', value: data);
          }
        }
      }
    }
    // Deduplication
    for (var category in updateRemain.categories.keys) {
      if (updateRemain.categories[category] == null) continue;

      // 배열 -> 집합 -> 배열로 바꿔 중복 제거
      updateRemain.categories[category] =
          updateRemain.categories[category]!.toSet().toList();

      // 업데이트할 데이터 수 계산
      _remainDownloadAssets += updateRemain.categories[category]!.length;
    }
    for (var category in dataLists.keys) {
      if (dataLists[category] == null) continue;

      // 배열 -> 집합 -> 배열로 바꿔 중복 제거
      dataLists[category] = dataLists[category]!.toSet().toList();
    }
    // 업데이트 종속성 검사 단계 종료 //

    // 업데이트 진행 단계 //
    setState(() {
      _updateStatus = 'Update...';
    });
    // 카테고리 별로 업데이트 진행
    for (var category in updateRemain.categories.keys) {
      if (updateRemain.categories[category] == null) continue;

      // _dataUpdater에서 카테고리 별로 업데이트 진행.
      // 실패한 항목만을 반환하여 skipList에 추가
      skipList.addAll(
        await _dataUpdater(
          databaseRef: databaseRef,
          category: category,
          dependencies: updateRemain.categories[category]!,
        ),
      );
    }

    // dataLists를 이용하여 카테고리별로 데이터를 빠르게 접근할 수 있게
    // list_<category>key를 추가하여 리스트 생성
    for (var category in dataLists.keys) {
      if (dataLists[category] == null) continue;

      Map<String, List<String>> listJson = {"data": dataLists[category]!};
      await storage.write(key: 'list_$category', value: json.encode(listJson));
    }

    // 펭귄 물류 데이터 분석 부서 업데이트
    setState(() {
      _updateStatus = 'Update penguin...';
    });
    if (await _penguinUpdater()) {
      skipList.add('penguin-stats');
    }

    // DB 버전 업데이트
    await storage.write(key: 'db_version', value: targetDBVersion);
    // 업데이트 진행 단계 종료 //

    // 업데이트 완료 //
    setState(() {
      _updateStatus = 'Completed!';
    });

    if (!mounted) return;
    context.read<VersionCheckBloc>().add(VersionCheckUpdateEvent(
          updatedDBVersion: targetDBVersion,
        ));

    // DEBUG: 업데이트 중 누락된 파일이 있는 경우 알림 (나중에 제거)
    if (skipList.isEmpty) return;
    _showDialog(skipList);
  }

  Future<List<String>> _dataUpdater({
    required DatabaseReference databaseRef,
    required String category,
    required List<String> dependencies,
  }) async {
    const storage = FlutterSecureStorage();
    Map<String, dynamic> localData = {}; // 로컬 json 데이터
    String serverPath = ''; // 서버 json 데이터 경로
    String savePath = ''; // 저장 경로(key)
    List<String> skipList = []; // 실패한 데이터 목록

    // 카테고리에 따라 경로 설정
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
      case 'skill':
        {
          try {
            localData = await json.decode(
                await rootBundle.loadString('assets/json/skill_table.json'));
          } catch (_) {}
          serverPath = 'data/skill_table';
          savePath = category;
          break;
        }
      case 'module':
        {
          try {
            localData = await json.decode(await rootBundle
                .loadString('assets/json/uniequip_table.json'))['equipDict'];
          } catch (_) {}
          serverPath = 'data/uniequip_table/equipDict';
          savePath = category;
          break;
        }
      case 'module_data':
        {
          try {
            localData = await json.decode(await rootBundle
                .loadString('assets/json/battle_equip_table.json'));
          } catch (_) {}
          serverPath = 'data/battle_equip_table';
          savePath = category;
          break;
        }
      case 'enemy':
        {
          try {
            localData = await json.decode(await rootBundle
                .loadString('assets/json/enemy_handbook_table.json'));
          } catch (_) {}
          serverPath = 'data/enemy_handbook_table';
          savePath = category;
          break;
        }
      case 'enemy_data':
        {
          try {
            localData = await json.decode(
                await rootBundle.loadString('assets/json/enemy_database.json'));
          } catch (_) {}
          serverPath = 'data/enemy_database';
          savePath = category;
          break;
        }
      case 'activity':
        {
          try {
            localData = await json.decode(await rootBundle
                .loadString('assets/json/activity_table.json'))['basicInfo'];
          } catch (_) {}
          serverPath = 'data/activity_table/basicInfo';
          savePath = category;
          break;
        }
      case 'zone':
        {
          try {
            localData = await json.decode(await rootBundle
                .loadString('assets/json/zone_table.json'))['zones'];
          } catch (_) {}
          serverPath = 'data/zone_table/zones';
          savePath = category;
          break;
        }
      case 'zone2activity':
        {
          try {
            localData = await json.decode(await rootBundle.loadString(
                'assets/json/activity_table.json'))['zoneToActivity'];
          } catch (_) {}
          serverPath = 'data/activity_table/zoneToActivity';
          savePath = category;
          break;
        }
      case 'stage':
        {
          try {
            localData = await json.decode(await rootBundle
                .loadString('assets/json/stage_table.json'))['stages'];
          } catch (_) {}
          serverPath = 'data/stage_table/stages';
          savePath = category;
          break;
        }
      case 'item':
        {
          try {
            localData = await json.decode(await rootBundle
                .loadString('assets/json/item_table.json'))['items'];
          } catch (_) {}
          serverPath = 'data/item_table/items';
          savePath = category;
          break;
        }
    }

    if (category.contains('image/')) {
      // 이미지 데이터 다운로드
      Reference storageRef = FirebaseStorage.instance.ref("data");
      for (var dependency in dependencies) {
        String imageCat = category.split('/').last;
        Uint8List? imageData;
        // 이미지 다운로드
        try {
          // From local
          imageData =
              (await rootBundle.load('assets/images/$imageCat/$dependency.png'))
                  .buffer
                  .asUint8List();
        } catch (_) {
          try {
            // From firebase
            var storageChild = storageRef.child('$imageCat/$dependency.png');
            imageData = await storageChild.getData(1024 * 200);
          } catch (_) {
            // local, firebase 모두 없음
            skipList.add('skip download: $imageCat/$dependency.png');
            setState(() {
              _downloadedAssets += 1;
            });
            continue;
          }
        }
        // 이미지 저장
        try {
          if (imageData == null) throw Exception();

          await storage.write(
              key: '$category/$dependency', value: base64.encode(imageData));
        } catch (_) {
          skipList.add('save fail: $category/$dependency.png');
        }

        setState(() {
          _downloadedAssets += 1;
        });
      }
    } else {
      // json 데이터 다운로드

      // FOR INDEXING //
      // 스테이지 인덱싱
      // 카테고리가 stage인 경우, 스테이지 인덱싱 데이터를 불러옴.
      // 없으면 생성하고, 아래와 같이 모델링 함.
      // {
      //   "zone1": ["stages"],
      //   "zone2": ["stages"]
      // }
      late StagesIndexingModel stageIndex;
      if (category == 'stage') {
        var stageIndexString = await storage.read(key: 'index/stage');
        if (stageIndexString == null || stageIndexString == 'null') {
          stageIndex = StagesIndexingModel.init();
        } else {
          stageIndex =
              StagesIndexingModel.fromJson(await json.decode(stageIndexString));
        }
      }

      for (var dependency in dependencies) {
        Map<String, dynamic>? resData; // 일반적인 경우
        String? resString; // zoneToActivity와 같이 string만 있는 경우
        // json 다운로드
        try {
          if (localData[dependency] != null) {
            // From local
            try {
              // zoneToActivity와 같이 string만 있는 경우
              // 문자열을 json으로 변환하는 과정에서 예외 발생
              resData = localData[dependency];
            } catch (_) {
              resString = localData[dependency];
            }
          } else {
            // From firebase
            var depRef = databaseRef.child('$serverPath/$dependency');
            DatabaseEvent databaseEvent = await depRef.once();
            try {
              // zoneToActivity와 같이 string만 있는 경우
              // 문자열을 json으로 변환하는 과정에서 예외 발생
              resData =
                  await json.decode(json.encode(databaseEvent.snapshot.value));
            } catch (_) {
              resString = databaseEvent.snapshot.value.toString();
            }
          }
        } catch (_) {
          // local, firebase 모두 없음
          skipList.add('skip download: $serverPath/$dependency');
          setState(() {
            _downloadedAssets += 1;
          });
          continue;
        }
        // json 저장
        try {
          if (resData == null && resString == null) throw Exception();

          if (resString != null) {
            // zoneToActivity와 같이 string만 있는 경우
            await storage.write(key: '$savePath/$dependency', value: resString);
          } else {
            // 일반적인 경우
            await storage.write(
                key: '$savePath/$dependency', value: json.encode(resData));

            // FOR INDEXING //
            // 스테이지 인덱싱
            if (category == 'stage') {
              var stage = StageModel.fromJson(resData!);
              stageIndex.addStage(zone: stage.zoneId!, stage: dependency);
            }
          }
        } catch (_) {
          skipList.add('save fail: $category/$dependency');
        }

        setState(() {
          _downloadedAssets += 1;
        });
      }

      // FOR INDEXING
      // 스테이지 인덱스 저장
      if (category == 'stage') {
        await storage.write(
            key: 'index/stage', value: json.encode(stageIndex.zone));
      }
    }

    return skipList;
  }

  Future<bool> _penguinUpdater() async {
    const storage = FlutterSecureStorage();
    String data;

    try {
      // use penguin api
      Uri uri = Uri.parse(
          'https://penguin-stats.io/PenguinStats/api/v2/result/matrix');
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        data = res.body;
      } else {
        throw Exception('Fail penguin api');
      }
    } catch (_) {
      try {
        // use local penguin data
        data = await rootBundle.loadString('assets/json/item_drop_table.json');
      } catch (_) {
        // fail
        return true;
      }
    }
    // isFail = false;
    await storage.write(key: 'penguin_stats', value: data);
    return false;
  }

  void _onDeleteTap() async {
    if (!mounted) return;
    context.read<VersionCheckBloc>().add(const VersionCheckResetEvent());
    _updateStatus = "Pending";
  }

  void _showDialog(List<String> list) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Failed to update (${list.length})',
            style: const TextStyle(
              fontFamily: FontFamily.nanumGothic,
              fontWeight: FontWeight.w700,
              fontSize: Sizes.size16,
            ),
          ),
          content: SizedBox(
            height: Sizes.size96 * 4,
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  for (var skip in list)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(Sizes.size3),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size2,
                            horizontal: Sizes.size5,
                          ),
                          child: Text(
                            skip.split(":").first,
                            style: const TextStyle(
                              fontFamily: FontFamily.nanumGothic,
                              fontSize: Sizes.size12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          skip.split(":").last,
                          style: const TextStyle(
                            fontFamily: FontFamily.nanumGothic,
                            fontSize: Sizes.size12,
                            fontWeight: FontWeight.w700,
                            color: Colors.redAccent,
                          ),
                        ),
                        Gaps.v5,
                      ],
                    ),
                ],
              ),
            ),
          ),
          actions: [
            const Text(
              '신고 부탁드립니다!',
              style: TextStyle(
                fontFamily: FontFamily.nanumGothic,
                fontSize: Sizes.size12,
                color: Colors.blue,
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
              ),
              child: const Text(
                "확인",
                style: TextStyle(
                  fontFamily: FontFamily.nanumGothic,
                  fontSize: Sizes.size12,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VersionCheckBloc, VersionCheckStateABS>(
      buildWhen: (previous, current) => current is VersionCheckLoadedState,
      builder: (context, state) => Scaffold(
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
                  text: _updateStatus == "Pending"
                      ? "현재 버전: ${(state as VersionCheckLoadedState).currDBVersion}\n새 버전: ${state.targetDBVersion == '' ? '이미 최신버전 입니다.' : state.targetDBVersion}"
                      : _updateStatus == "Completed!"
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
                                _updateStatus,
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
                      current: _downloadedAssets,
                      remain: _remainDownloadAssets,
                    ),
                    Gaps.v28,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: _updateStatus == 'Pending'
                              ? () => _onUpdateTap(state)
                              : null,
                          style: TextButton.styleFrom(
                            backgroundColor: _updateStatus == 'Pending'
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
                        // For Development //
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
      ),
    );
  }
}
