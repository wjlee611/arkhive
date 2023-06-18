import 'dart:convert';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
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
  Future<Map<String, List<StagesModel>>> _futureStages() async {
    const storage = FlutterSecureStorage();
    Map<String, StagesModel> resultMap = {};
    Map<String, List<StagesModel>> result = {};

    String? zoneListString = await storage.read(key: 'list_zone');
    if (zoneListString == null || zoneListString == 'null') return {};

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
            type: 'EVENT',
            zones: [zone],
          );
        } else {
          resultMap[act]!.addZone(zone: zone);
        }
      } else {
        resultMap[modeledZoneData.zoneId!] = StagesModel(
          nameFirst: modeledZoneData.zoneNameFirst,
          nameSecond: modeledZoneData.zoneNameSecond,
          type: 'MAINLINE',
          zones: [zone],
        );
      }
    }

    for (var key in resultMap.keys.toList().reversed) {
      if (result[resultMap[key]!.type] == null) {
        result[resultMap[key]!.type!] = [];
      }
      result[resultMap[key]!.type!]!.add(resultMap[key]!);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          backgroundColor: Colors.blueGrey.shade700,
          bottom: TabBar(
            isScrollable: true,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: Sizes.size3,
                color: Colors.yellow.shade800,
              ),
              insets: const EdgeInsets.symmetric(horizontal: Sizes.size14),
            ),
            tabs: const [
              Tab(
                child: Text(
                  '메인',
                  style: TextStyle(
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                    fontSize: Sizes.size14,
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  '이벤트',
                  style: TextStyle(
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                    fontSize: Sizes.size14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: _futureStages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gaps.v32,
                          for (var stages in snapshot.data!['MAINLINE']!)
                            StagesContainer(stages: stages),
                          Gaps.v130,
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gaps.v32,
                          for (var stages in snapshot.data!['EVENT']!)
                            StagesContainer(stages: stages),
                          Gaps.v130,
                        ],
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }
}
