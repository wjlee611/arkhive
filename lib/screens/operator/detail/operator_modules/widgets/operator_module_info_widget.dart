import 'package:arkhive/bloc/operator/operator_data/operator_data_bloc.dart';
import 'package:arkhive/bloc/operator/operator_data/operator_data_state.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_bloc.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/module_model.dart';
import 'package:arkhive/tools/required_pot_elite_selector.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorModuleInfoWidget extends StatefulWidget {
  const OperatorModuleInfoWidget({
    super.key,
    required this.module,
  });

  final ModuleModel module;

  @override
  State<OperatorModuleInfoWidget> createState() =>
      _OperatorModuleInfoWidgetState();
}

class _OperatorModuleInfoWidgetState extends State<OperatorModuleInfoWidget>
    with TickerProviderStateMixin {
  late TabController _levelTabController;
  ModuleDataModel? moduleData;

  ModuleTraitDataBundleModel? _updateTrait;
  ModuleTalentDataBundleModel? _updateTalent;

  @override
  void initState() {
    super.initState();
    moduleData =
        (context.read<OperatorDataBloc>().state as OperatorDataLoadedState)
            .moduleDatas[widget.module.uniEquipId]!;

    _levelTabController = TabController(
      length: moduleData!.phases.length,
      vsync: this,
    );
    _levelTabController.addListener(_handleTabSelection);

    _updateContents();
  }

  @override
  void dispose() {
    _levelTabController.removeListener(_handleTabSelection);
    _levelTabController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant OperatorModuleInfoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.module != widget.module) {
      moduleData =
          (context.read<OperatorDataBloc>().state as OperatorDataLoadedState)
              .moduleDatas[widget.module.uniEquipId]!;
      _updateContents();
    }
  }

  void _handleTabSelection() {
    if (_levelTabController.indexIsChanging) {
      _updateContents();
    }
  }

  void _updateContents() {
    int potential = context.read<OperatorStatusBloc>().state.potential;
    _updateTrait = null;
    _updateTalent = null;

    for (var part in moduleData!.phases[_levelTabController.index].parts) {
      if (part.isToken == null || part.isToken!) continue;
      // update trait
      if (part.target!.contains('TRAIT') || part.target!.contains('DISPLAY')) {
        _updateTrait = reqPotEliteSelector<ModuleTraitDataBundleModel>(
          candidates: part.overrideTraitDataBundle,
          currPot: potential,
        );
      }
      // update talent
      else if (part.target!.contains('TALENT')) {
        var nullTest = reqPotEliteSelector<ModuleTalentDataBundleModel>(
          candidates: part.addOrOverrideTalentDataBundle,
          currPot: potential,
        );
        if (nullTest == null || nullTest.name == null) continue;
        _updateTalent = nullTest;
      }
    }

    setState(() {});
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
      case 'block_cnt':
        result = '저지 가능 수';
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
          child: SizedBox(
            height: Sizes.size32,
            child: TabBar(
              controller: _levelTabController,
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.yellow.shade800,
                    width: Sizes.size3,
                  ),
                ),
              ),
              labelColor: Colors.yellow.shade800,
              unselectedLabelColor: Colors.black,
              tabs: [
                for (int i = 0; i < moduleData!.phases.length; i++)
                  SizedBox(
                    width: Sizes.size40,
                    child: Tab(
                      child: Padding(
                        padding: const EdgeInsets.only(top: Sizes.size2),
                        child: Text(
                          '레벨 ${i + 1}',
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
        CommonSubTitleWidget(text: widget.module.uniEquipName!),
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
                color: _moduleColorPicker(widget.module.equipShiningColor),
              ),
              child: Text(
                widget.module.typeIcon!.toUpperCase(),
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
              color: _moduleColorPicker(widget.module.equipShiningColor),
              isShadow: false,
            ),
            Gaps.v1,
            for (var attr in moduleData!
                .phases[_levelTabController.index].attributeBlackboard)
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
        BlocBuilder<OperatorStatusBloc, OperatorStatusState>(
          buildWhen: (previous, current) {
            if (previous.potential != current.potential) {
              _updateContents();
              return true;
            }
            return false;
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        color:
                            _moduleColorPicker(widget.module.equipShiningColor),
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
                        color:
                            _moduleColorPicker(widget.module.equipShiningColor),
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
          },
        ),
      ],
    );
  }
}
