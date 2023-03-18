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
        future: futureStages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var stages in snapshot.data!)
                      StagesContainer(stages: stages),
                  ],
                ),
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

class _StagesContainerState extends State<StagesContainer>
    with TickerProviderStateMixin {
  TabController? _tabController;
  bool _isOpen = false;

  Future<Map<String, List<StageModel>>> futureStage() async {
    const storage = FlutterSecureStorage();
    Map<String, List<StageModel>> result = {};

    String? stageIndexString = await storage.read(key: 'index/stage');
    if (stageIndexString == null || stageIndexString == 'null') return {};

    var stageIndexData = await json.decode(stageIndexString);
    var stageIndex = StagesIndexingModel.fromJson(stageIndexData);

    for (var zone in widget.stages.zones) {
      for (var stage in stageIndex.zone[zone] ?? []) {
        String? stageString = await storage.read(key: 'stage/$stage');
        if (stageString == null || stageString == 'null') continue;

        var stageData = await json.decode(stageString);
        var modeledStageData = StageModel.fromJson(stageData);
        if ((modeledStageData.isStoryOnly ?? true) ||
            (modeledStageData.isPredefined ?? true) ||
            (modeledStageData.isStagePatch ?? true)) continue;

        if (result[modeledStageData.zoneId] == null) {
          result[modeledStageData.zoneId!] = [];
        }
        result[modeledStageData.zoneId!]!.add(modeledStageData);
      }
    }

    if (_tabController == null) {
      _tabController = TabController(length: result.keys.length, vsync: this);
      _tabController!.addListener(_onTabChange);
    }

    Map<String, List<StageModel>> resultInv = {};
    resultInv = {
      for (var key in result.keys.toList().reversed) key: result[key]!,
    };

    return resultInv;
  }

  @override
  void dispose() {
    _tabController?.removeListener(_onTabChange);
    _tabController?.dispose();
    super.dispose();
  }

  void _onOpenTap() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _onTabChange() {
    setState(() {});
  }

  Future<String> _zone2Name(String zone) async {
    const storage = FlutterSecureStorage();
    String? zoneString = await storage.read(key: 'zone/$zone');
    if (zoneString == null || zoneString == 'null') return zone;

    var zoneData = await json.decode(zoneString);
    var modeledZoneData = ZoneModel.fromJson(zoneData);
    if (modeledZoneData.zoneNameSecond == null) return zone;

    return modeledZoneData.zoneNameSecond!;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      padding: _isOpen
          ? const EdgeInsets.symmetric(
              vertical: Sizes.size16,
              horizontal: Sizes.size5,
            )
          : const EdgeInsets.symmetric(vertical: Sizes.size5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size10),
          boxShadow: [
            BoxShadow(
              blurRadius: Sizes.size1,
              blurStyle: BlurStyle.outer,
              color: Colors.black.withOpacity(0.4),
            ),
          ],
        ),
        child: Column(
          children: [
            InkWell(
              onTap: _onOpenTap,
              borderRadius: BorderRadius.circular(Sizes.size10),
              child: Container(
                height: Sizes.size40,
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
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
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isOpen)
              FutureBuilder(
                future: futureStage(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CustomScrollView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              children: [
                                if (snapshot.data!.keys.length > 1)
                                  TabBar(
                                    controller: _tabController,
                                    isScrollable: true,
                                    physics: const BouncingScrollPhysics(),
                                    indicatorColor: Colors.yellow.shade800,
                                    tabs: [
                                      for (var key in snapshot.data!.keys)
                                        Tab(
                                          child: FutureBuilder(
                                            future: _zone2Name(key),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(snapshot.data!);
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        Colors.yellow.shade800,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                for (var value in snapshot.data![(snapshot
                                    .data!.keys
                                    .toList())[_tabController!.index]]!)
                                  Text(value.code!),
                              ],
                            ),
                            childCount: 1,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: Sizes.size20),
                        child: CircularProgressIndicator(
                          color: Colors.yellow.shade800,
                        ),
                      ),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
