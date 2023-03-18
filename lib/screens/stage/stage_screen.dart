import 'dart:convert';

import 'package:arkhive/models/stage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StageScreen extends StatefulWidget {
  const StageScreen({super.key});

  @override
  State<StageScreen> createState() => _StageScreenState();
}

class _StageScreenState extends State<StageScreen> {
  Future<List<StagesModel>> futureStages() async {
    const storage = FlutterSecureStorage();
    Map<String, StagesModel> resultMap = {};
    List<StagesModel> result = [];

    String? zoneListString = await storage.read(key: 'list_zone');
    if (zoneListString == null || zoneListString == 'null') return [];

    var zoneListData = await json.decode(zoneListString)['data'];
    for (var zone in zoneListData) {
      String? zoneString = await storage.read(key: 'zone/$zone');
      if (zoneString == null || zoneString == 'null') continue;

      var zoneData = await json.decode(zoneString);
      var modeledZoneData = ZoneModel.fromJson(zoneData);
      if (modeledZoneData.type == 'ACTIVITY') {
        String? act = await storage.read(key: 'zone2activity/$zone');
        if (act == null || act == 'null') continue;

        String? actString = await storage.read(key: 'activity/$act');
        if (actString == null || actString == 'null') continue;

        var actData = await json.decode(actString);
        var modeledActData = ActivityModel.fromJson(actData);
        if (modeledActData.name?.contains('재개방') ?? true) continue;

        if (resultMap[act] == null) {
          resultMap[act] = StagesModel(
            nameSecond: modeledActData.name,
            open: modeledActData.startTime,
            close: modeledActData.endTime,
            shopClose: modeledActData.rewardEndTime,
            isEvent: true,
            stages: [],
            zones: [zone],
          );
        } else {
          resultMap[act]!.addZone(zone: zone);
        }
      } else {
        resultMap[modeledZoneData.zoneId!] = StagesModel(
          nameFirst: modeledZoneData.zoneNameFirst,
          nameSecond: modeledZoneData.zoneNameSecond,
          isEvent: false,
          stages: [],
          zones: [zone],
        );
      }
    }

    result = [for (var key in resultMap.keys) resultMap[key]!];

    return result;
  }

  Future<List<StageModel>> futureStage() async {
    const storage = FlutterSecureStorage();
    List<StageModel> result = [];
    Map<String, List<StageModel>> zoneStageList = {};

    String? stageListString = await storage.read(key: 'list_stage');
    if (stageListString == null || stageListString == 'null') return [];

    var stageListData = await json.decode(stageListString)['data'];
    for (var stage in stageListData) {
      String? stageString = await storage.read(key: 'stage/$stage');
      if (stageString == null || stageString == 'null') continue;

      var stageData = await json.decode(stageString);
      var modeledStageData = StageModel.fromJson(stageData);
      var zoneId = modeledStageData.zoneId ?? 'none';
      if (!zoneStageList.containsKey(zoneId)) {
        zoneStageList[zoneId] = [];
      }
      zoneStageList[zoneId]!.add(modeledStageData);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureStages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var stages in snapshot.data!)
                    Text('${stages.nameFirst} - ${stages.nameSecond}')
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
