import 'dart:convert';

import 'package:arkhive/constants/sizes.dart';
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
    List<StagesModel> resultRev = [];
    resultRev = [for (var stages in result.reversed) stages];

    return resultRev;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        child: FutureBuilder(
          future: futureStages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var stages in snapshot.data!)
                      StagesContainer(stages: stages),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow.shade800,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class StagesContainer extends StatefulWidget {
  const StagesContainer({
    super.key,
    required this.stages,
  });

  final StagesModel stages;

  @override
  State<StagesContainer> createState() => _StagesContainerState();
}

class _StagesContainerState extends State<StagesContainer> {
  bool _isOpen = false;

  Future<List<StageModel>> futureStage() async {
    const storage = FlutterSecureStorage();
    List<StageModel> result = [];

    String? stageIndexString = await storage.read(key: 'index/stage');
    if (stageIndexString == null || stageIndexString == 'null') return [];

    var stageIndexData = await json.decode(stageIndexString);
    var stageIndex = StagesIndexingModel.fromJson(stageIndexData);

    for (var zone in widget.stages.zones) {
      for (var stage in stageIndex.zone[zone] ?? []) {
        String? stageString = await storage.read(key: 'stage/$stage');
        if (stageString == null || stageString == 'null') continue;

        var stageData = await json.decode(stageString);
        result.add(StageModel.fromJson(stageData));
      }
    }

    return result;
  }

  void _onOpenTap() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (widget.stages.nameFirst != null)
                    Text('${widget.stages.nameFirst!} - '),
                  Text(widget.stages.nameSecond!),
                ],
              ),
              AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: _isOpen ? 0.5 : 0,
                child: IconButton(
                  onPressed: _onOpenTap,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_isOpen)
          FutureBuilder(
            future: futureStage(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    for (var stage in snapshot.data!) Text(stage.code!),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.yellow.shade800,
                  ),
                );
              }
            },
          )
      ],
    );
  }
}
