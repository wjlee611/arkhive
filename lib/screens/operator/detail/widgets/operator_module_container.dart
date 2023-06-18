import 'dart:convert';

import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/module_model.dart';
import 'package:arkhive/tools/required_pot_elite_selector.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OperatorModuleContainer extends StatefulWidget {
  const OperatorModuleContainer({
    super.key,
    required this.operatorKey,
    required this.potential,
  });

  final String operatorKey;
  final int potential;

  @override
  State<OperatorModuleContainer> createState() =>
      _OperatorModuleContainerState();
}

class _OperatorModuleContainerState extends State<OperatorModuleContainer>
    with TickerProviderStateMixin {
  bool _isLoading = true;
  List<ModuleModel> modules = [];
  Map<String, ModuleDataModel> moduleDatas = {};
  late TabController _moduleTabController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _loadModule();
  }

  void _loadModule() async {
    const storage = FlutterSecureStorage();
    String operatorName = widget.operatorKey.split('_').last;
    for (int i = 2; i < 4; i++) {
      try {
        // Module
        var moduleString =
            await storage.read(key: 'module/uniequip_00${i}_$operatorName');
        var moduleJson = await json.decode(moduleString!);
        modules.add(ModuleModel.fromJson(moduleJson));

        // Module data
        moduleString = await storage.read(
            key: 'module_data/uniequip_00${i}_$operatorName');
        moduleJson = await json.decode(moduleString!);
        moduleDatas['uniequip_00${i}_$operatorName'] =
            ModuleDataModel.fromJson(moduleJson);
      } catch (_) {}
    }
    modules.sort(
      (a, b) => a.typeIcon!.compareTo(b.typeIcon!),
    );

    _moduleTabController = TabController(length: modules.length, vsync: this);
    _moduleTabController.addListener(_handleModuleTabSelection);
    try {
      setState(() {
        _isLoading = false;
      });
    } catch (_) {}
  }

  void _handleModuleTabSelection() {
    if (_moduleTabController.indexIsChanging) {
      setState(() {
        _index = _moduleTabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? modules.isNotEmpty
            ? ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const CommonTitleWidget(text: '모듈'),
                  Gaps.v5,
                  Center(
                    child: Container(
                      height: Sizes.size24,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(Sizes.size10),
                      ),
                      child: TabBar(
                        controller: _moduleTabController,
                        isScrollable: true,
                        physics: const NeverScrollableScrollPhysics(),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size10),
                          color: Colors.yellow.shade800,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        splashBorderRadius: BorderRadius.circular(Sizes.size10),
                        tabs: [
                          for (int i = 0; i < modules.length; i++)
                            SizedBox(
                              width: Sizes.size40,
                              child: Tab(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: Sizes.size2),
                                  child: Text(
                                    '${modules[i].typeIcon!.split('-').last.toUpperCase()}타입',
                                    style: const TextStyle(
                                      fontFamily: FontFamily.nanumGothic,
                                      fontWeight: FontWeight.w700,
                                      fontSize: Sizes.size12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Gaps.v5,
                  OperatorModuleInfoWidget(
                    name: modules[_index].uniEquipName!,
                    type: modules[_index].typeIcon!,
                    module: moduleDatas[modules[_index].uniEquipId!]!,
                    potential: widget.potential,
                    color: modules[_index].equipShiningColor,
                  ),
                ],
              )
            : Container()
        : Center(
            child: CircularProgressIndicator(
              color: Colors.yellow.shade800,
            ),
          );
  }
}

class OperatorModuleInfoWidget extends StatefulWidget {
  const OperatorModuleInfoWidget({
    super.key,
    required this.name,
    required this.type,
    required this.module,
    required this.potential,
    this.color,
  });

  final String name, type;
  final String? color;
  final ModuleDataModel module;
  final int potential;

  @override
  State<OperatorModuleInfoWidget> createState() =>
      _OperatorModuleInfoWidgetState();
}

class _OperatorModuleInfoWidgetState extends State<OperatorModuleInfoWidget>
    with TickerProviderStateMixin {
  late TabController _stageTabController;
  int _level = 0;
  ModuleTraitDataBundleModel? _updateTrait;
  ModuleTalentDataBundleModel? _updateTalent;

  @override
  void initState() {
    super.initState();
    _stageTabController =
        TabController(length: widget.module.phases.length, vsync: this);
    _stageTabController.addListener(_handleModuleTabSelection);
    _updateContents();
  }

  @override
  void didUpdateWidget(covariant OperatorModuleInfoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.module.phases.length != widget.module.phases.length) {
      _stageTabController.removeListener(_handleModuleTabSelection);
      _stageTabController.dispose();

      _stageTabController =
          TabController(length: widget.module.phases.length, vsync: this);
      _stageTabController.addListener(_handleModuleTabSelection);
    }

    if (oldWidget.module != widget.module) _updateContents();
    if (oldWidget.potential != widget.potential) _updateContents();
  }

  @override
  void dispose() {
    _stageTabController.dispose();
    super.dispose();
  }

  void _handleModuleTabSelection() {
    if (_stageTabController.indexIsChanging) {
      setState(() {
        _level = _stageTabController.index;
        _updateContents();
      });
    }
  }

  void _updateContents() {
    _updateTrait = null;
    _updateTalent = null;
    for (var part in widget.module.phases[_level].parts) {
      if (part.isToken == null || part.isToken!) continue;
      if (part.target!.contains('TRAIT') || part.target!.contains('DISPLAY')) {
        _updateTrait = reqPotEliteSelector<ModuleTraitDataBundleModel>(
          candidates: part.overrideTraitDataBundle,
          currPot: widget.potential,
        );
      } else if (part.target!.contains('TALENT')) {
        var nullTest = reqPotEliteSelector<ModuleTalentDataBundleModel>(
          candidates: part.addOrOverrideTalentDataBundle,
          currPot: widget.potential,
        );
        if (nullTest == null || nullTest.name == null) continue;
        _updateTalent = nullTest;
      }
    }
  }

  Color _moduleColorPicker(String? color) {
    Color result = Colors.grey;
    switch (color) {
      case 'red':
        result = Colors.red;
        break;
      case 'blue':
        result = Colors.blue;
        break;
      case 'green':
        result = Colors.green;
        break;
      case 'yellow':
        result = Colors.yellowAccent.shade700;
        break;
    }
    return result;
  }

  String _moduleStatPicker(String? key) {
    String result = key ?? '?';
    switch (key) {
      case 'max_hp':
        result = '체력';
        break;
      case 'atk':
        result = '공격';
        break;
      case 'def':
        result = '방어';
        break;
      case 'attack_speed':
        result = '공격 속도';
        break;
      case 'magic_resistance':
        result = '마법 저항';
        break;
      case 'cost':
        result = '배치 코스트';
        break;
      case 'respawn_time':
        result = '재배치 시간';
        break;
    }
    return result;
  }

  String _moduleStatFormatter(double value) {
    String result = '';
    if (value > 0) {
      result = '+${value.toStringAsFixed(1).replaceAll('.0', '')}';
    } else {
      result = value.toStringAsFixed(1).replaceAll('.0', '');
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Center(
          child: Container(
            height: Sizes.size24,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(Sizes.size10),
            ),
            child: TabBar(
              controller: _stageTabController,
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.size10),
                color: Colors.yellow.shade800,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              splashBorderRadius: BorderRadius.circular(Sizes.size10),
              tabs: [
                for (int i = 0; i < widget.module.phases.length; i++)
                  SizedBox(
                    width: Sizes.size40,
                    child: Tab(
                      child: Padding(
                        padding: const EdgeInsets.only(top: Sizes.size2),
                        child: Text(
                          '레벨${i + 1}',
                          style: const TextStyle(
                            fontFamily: FontFamily.nanumGothic,
                            fontWeight: FontWeight.w700,
                            fontSize: Sizes.size12,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Gaps.v7,
        CommonSubTitleWidget(text: widget.name),
        Gaps.v3,
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size1,
                horizontal: Sizes.size3,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.size2),
                color: _moduleColorPicker(widget.color),
              ),
              child: Text(
                widget.type.toUpperCase(),
                style: const TextStyle(
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                  fontSize: Sizes.size12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Gaps.v5,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonSubTitleWidget(
              text: '추가 스탯 상승치',
              color: _moduleColorPicker(widget.color),
              isShadow: false,
            ),
            Gaps.v1,
            for (var attr in widget.module.phases[_level].attributeBlackboard)
              Row(
                children: [
                  Text(
                    _moduleStatPicker(attr.key),
                    style: const TextStyle(
                      fontFamily: FontFamily.nanumGothic,
                      fontSize: Sizes.size12,
                      color: Colors.black87,
                    ),
                  ),
                  Gaps.h3,
                  Text(
                    _moduleStatFormatter(attr.value!),
                    style: const TextStyle(
                      fontFamily: FontFamily.nanumGothic,
                      fontSize: Sizes.size12,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            Gaps.v5,
          ],
        ),
        if (_updateTrait != null &&
            (_updateTrait!.additionalDescription != null ||
                _updateTrait!.overrideDescripton != null))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonSubTitleWidget(
                text: _updateTrait!.additionalDescription != null
                    ? '특성 추가'
                    : '특성 개선',
                color: _moduleColorPicker(widget.color),
                isShadow: false,
              ),
              Gaps.v1,
              FormattedTextWidget(
                text: _updateTrait!.additionalDescription ??
                    _updateTrait!.overrideDescripton!,
                variables: boardListAndDurationToMap(
                    blackboards: _updateTrait!.blackboard),
              ),
              const SizedBox(height: 10),
            ],
          ),
        if (_updateTalent != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonSubTitleWidget(
                text: _updateTalent!.name!,
                color: _moduleColorPicker(widget.color),
                isShadow: false,
              ),
              Gaps.v1,
              FormattedTextWidget(
                text: _updateTalent!.upgradeDescription!,
                variables: boardListAndDurationToMap(
                    blackboards: _updateTalent!.blackboard),
              ),
            ],
          ),
      ],
    );
  }
}
