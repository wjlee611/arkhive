import 'package:arkhive/bloc/item/item_list/item_list_bloc.dart';
import 'package:arkhive/bloc/item/item_list/item_list_event.dart';
import 'package:arkhive/bloc/item/item_list/item_list_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/module_model.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/upgrade/widgets/operator_upgrade_costs_widget.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:arkhive/widgets/common_no_result_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorUpgradeScreen extends StatelessWidget {
  final OperatorModel operator_;
  final List<ModuleModel> modules;

  const OperatorUpgradeScreen({
    super.key,
    required this.operator_,
    required this.modules,
  });

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemListBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const AppFont(
            "육성 재료",
            color: Colors.white,
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w700,
          ),
          backgroundColor: Colors.blueGrey.shade700,
        ),
        body: BlocBuilder<ItemListBloc, ItemListState>(
          builder: (context, state) {
            if (state is ItemListInitState) {
              context.read<ItemListBloc>().add(const ItemListInitEvent());
            }
            if (state is ItemListErrorState) {
              return Center(
                child: AppFont(
                  state.message,
                  fontSize: Sizes.size16,
                ),
              );
            }
            if (state is! ItemListLoadedState) {
              return const CommonLoadingWidget();
            }
            if (state.filteredItemList.isEmpty) {
              return const CommonNoResultWidget();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Gaps.v20,
                  const CommonTitleWidget(text: '정예화'),
                  for (int i = 1; i < operator_.phases.length; i++)
                    OperatorUpgradeCostsWidget(
                      costs: operator_.phases[i].evolveCost,
                    ),
                  Gaps.v20,
                  const CommonTitleWidget(text: '스킬'),
                  for (var skill in operator_.allSkillLvlup)
                    OperatorUpgradeCostsWidget(costs: skill.lvlUpCost),
                  for (int i = 0; i < operator_.skills.length; i++)
                    Column(
                      children: [
                        if (operator_.skills[i].levelUpCostCond.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: Sizes.size10,
                              top: Sizes.size20,
                            ),
                            child:
                                CommonSubTitleWidget(text: '${i + 1} 스킬 마스터리'),
                          ),
                        for (var skillLvl
                            in operator_.skills[i].levelUpCostCond)
                          OperatorUpgradeCostsWidget(
                            costs: skillLvl.levelUpCost,
                          ),
                      ],
                    ),
                  Gaps.v20,
                  const CommonTitleWidget(text: '모듈'),
                  for (var module in modules)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: Sizes.size10,
                            top: Sizes.size20,
                          ),
                          child: CommonSubTitleWidget(
                            text: module.typeIcon?.toUpperCase() ?? 'na',
                            color: _moduleColorPicker(module.equipShiningColor),
                          ),
                        ),
                        for (var moduleStage in module.itemCost.entries)
                          OperatorUpgradeCostsWidget(
                            costs: moduleStage.value,
                          ),
                      ],
                    ),
                  Gaps.v130,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
