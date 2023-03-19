import 'dart:convert';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/stage_model.dart';
import 'package:arkhive/screens/stage/widgets/stage_list_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StageListContainer extends StatefulWidget {
  const StageListContainer({
    super.key,
    required this.stages,
  });

  final StagesModel stages;

  @override
  State<StageListContainer> createState() => _StageListContainerState();
}

class _StageListContainerState extends State<StageListContainer>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void dispose() {
    _tabController?.removeListener(_onTabChange);
    _tabController?.dispose();
    super.dispose();
  }

  void _onTabChange() {
    setState(() {});
  }

  Future<Map<String, List<StageModel>>> _futureStage() async {
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

    Map<String, List<StageModel>> resultInv = {};
    resultInv = {
      for (var key in result.keys.toList().reversed) key: result[key]!,
    };

    // FOR MAIN 9~ ZONE
    Map<String, List<StageModel>> tmp = {};
    for (var key in resultInv.keys) {
      for (var stage in resultInv[key]!) {
        String key = stage.zoneId ?? 'NONE';
        switch (stage.diffGroup) {
          case 'EASY':
            key = '스토리 체험 환경';
            break;
          case 'NORMAL':
            key = '표준 실전 환경';
            break;
          case 'TOUGH':
            key = '고난 험지 환경';
            break;
        }
        if (tmp[key] == null) tmp[key] = [];
        tmp[key]!.add(stage);
      }
    }
    resultInv = tmp;

    if (_tabController == null) {
      _tabController =
          TabController(length: resultInv.keys.length, vsync: this);
      _tabController!.addListener(_onTabChange);
    }

    return resultInv;
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
    return FutureBuilder(
      future: _futureStage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var stageList = snapshot.data![
                        (snapshot.data!.keys.toList())[_tabController!.index]]!;
                    return ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                                    initialData: key,
                                    builder: (context, snapshot) => Text(
                                      snapshot.data!,
                                      style: const TextStyle(
                                        fontFamily: FontFamily.nanumGothic,
                                        fontWeight: FontWeight.w700,
                                        fontSize: Sizes.size12,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return StageListCardWidget(stage: stageList[index]);
                          },
                          separatorBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: Sizes.size1,
                            color: Colors.black12,
                            margin: const EdgeInsets.symmetric(
                                horizontal: Sizes.size16),
                          ),
                          itemCount: stageList.length,
                        ),
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
              child: CircularProgressIndicator(
                color: Colors.yellow.shade800,
              ),
            ),
          );
        }
      },
    );
  }
}
