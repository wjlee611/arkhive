import 'dart:convert';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/stage_model.dart';
import 'package:arkhive/screens/stage/widgets/stage_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StageScreen extends StatefulWidget {
  const StageScreen({super.key});

  @override
  State<StageScreen> createState() => _StageScreenState();
}

class _StageScreenState extends State<StageScreen> {
  Future<List<StagesModel>> _futureStages() async {
    const storage = FlutterSecureStorage();
    Map<String, StagesModel> resultMap = {};
    List<StagesModel> result = [];

    String? zoneListString = await storage.read(key: 'list_zone');
    if (zoneListString == null || zoneListString == 'null') return [];

    var zoneListData = await json.decode(zoneListString)['data'];
    for (var zone in (zoneListData as List).reversed) {
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
        if (!(modeledActData.hasStage ?? false)) continue;

        if (modeledActData.isReplicate ?? false) {
          for (var key in resultMap.keys) {
            if (resultMap[key]!.nameSecond!.replaceAll(' ', '') ==
                modeledActData.name!
                    .replaceAll('(재개방)', '')
                    .replaceAll(' ', '')) {
              resultMap[key]!.addZone(zone: zone);
              break;
            }
          }
          continue;
        }

        if (resultMap[act] == null) {
          resultMap[act] = StagesModel(
            nameSecond: modeledActData.name,
            open: modeledActData.startTime,
            close: modeledActData.endTime,
            shopClose: modeledActData.rewardEndTime,
            isEvent: true,
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
          zones: [zone],
        );
      }
    }

    result = [for (var key in resultMap.keys) resultMap[key]!];
    List<StagesModel> resultInv = [];
    resultInv = [for (var stages in result.reversed) stages];

    return resultInv;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _futureStages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v32,
                    for (var stages in snapshot.data!)
                      StagesContainer(stages: stages),
                    Gaps.v130,
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Image.asset(
                'assets/images/prts.png',
                color: Colors.grey.shade400,
                width: Sizes.size60,
                height: Sizes.size60,
              ),
            );
          }
        },
      ),
    );
  }
}
