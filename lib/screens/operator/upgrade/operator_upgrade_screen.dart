import 'package:arkhive/bloc/item/item_list/item_list_bloc.dart';
import 'package:arkhive/bloc/item/item_list/item_list_event.dart';
import 'package:arkhive/bloc/item/item_list/item_list_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/module_model.dart';
import 'package:arkhive/models/operator_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemListBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "육성 재료",
            style: TextStyle(
              fontFamily: FontFamily.nanumGothic,
              fontWeight: FontWeight.w700,
            ),
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
                child: Text(
                  state.message,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.nanumGothic,
                  ),
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
                children: [
                  Gaps.v20,
                  const CommonTitleWidget(text: '정예화'),
                  for (var phase in operator_.phases)
                    Row(
                      children: [
                        for (var cost in phase.evolveCost)
                          Padding(
                            padding: const EdgeInsets.only(left: Sizes.size10),
                            child: Text(cost.id ?? 'na'),
                          )
                      ],
                    ),
                  Gaps.v20,
                  const CommonTitleWidget(text: '스킬'),
                  for (var skill in operator_.allSkillLvlup)
                    Row(
                      children: [
                        for (var cost in skill.lvlUpCost)
                          Padding(
                            padding: const EdgeInsets.only(left: Sizes.size10),
                            child: Text(cost.id ?? 'na'),
                          )
                      ],
                    ),
                  for (int i = 0; i < operator_.skills.length; i++)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: Sizes.size10),
                          child: CommonSubTitleWidget(text: '${i + 1} 스킬'),
                        ),
                        for (var skillLvl
                            in operator_.skills[i].levelUpCostCond)
                          Row(
                            children: [
                              for (var cost in skillLvl.levelUpCost)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: Sizes.size10),
                                  child: Text(cost.id ?? 'na'),
                                )
                            ],
                          )
                      ],
                    ),
                  Gaps.v20,
                  const CommonTitleWidget(text: '모듈'),
                  for (var module in modules)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: Sizes.size10),
                          child: CommonSubTitleWidget(
                              text: '${module.typeIcon} 타입'),
                        ),
                        for (var moduleStage in module.itemCost.entries)
                          Row(
                            children: [
                              for (var stage in moduleStage.value)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: Sizes.size10),
                                  child: Text(stage.id ?? 'na'),
                                )
                            ],
                          )
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
