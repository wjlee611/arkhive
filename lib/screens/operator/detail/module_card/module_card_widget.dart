import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/detail/module_card/widgets/module_info_title_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/card_title_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/select_button_widget.dart';
import 'package:arkhive/screens/operator/detail/module_card/widgets/module_stage_button_widget.dart';
import 'package:flutter/material.dart';

class ModuleCard extends StatefulWidget {
  const ModuleCard({
    super.key,
    required this.modules,
  });

  final List<ModuleModel> modules;

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  int _selectedModule = 0;
  int _selectedStage = 0;

  void _onModuleButtonTap(int i) {
    setState(() {
      if (_selectedModule != i) {
        _selectedStage = 0;
      }
      _selectedModule = i;
    });
  }

  void _onModuleStageButtonTap(int i) {
    setState(() {
      _selectedStage = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.size20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.shade100,
            blurRadius: Sizes.size5,
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blueGrey.shade600,
            padding: const EdgeInsets.only(
              right: Sizes.size10,
              left: Sizes.size10,
              top: Sizes.size10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Sizes.size10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.ballot_outlined,
                        color: Colors.yellow.shade700,
                        size: Sizes.size20,
                      ),
                      Gaps.h5,
                      const Text(
                        "모듈",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                          fontFamily: FontFamily.nanumGothic,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    for (int i = 0; i < widget.modules.length; i++)
                      SelectButton(
                        index: i,
                        onTap: _onModuleButtonTap,
                        title: widget.modules[i].code.split('-').last,
                        isEnd: widget.modules.length - 1 == i,
                        isSelected: _selectedModule == i,
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardTitle(title: widget.modules[_selectedModule].name),
                Gaps.v2,
                Container(
                  padding: const EdgeInsets.only(
                    left: Sizes.size14,
                    top: Sizes.size2,
                    right: Sizes.size10,
                    bottom: Sizes.size2,
                  ),
                  decoration: BoxDecoration(
                    color:
                        widget.modules[_selectedModule].code.split('-').last ==
                                "X"
                            ? Colors.purple
                            : Colors.blue.shade800,
                    borderRadius: const BorderRadiusDirectional.horizontal(
                      end: Radius.circular(Sizes.size5),
                    ),
                  ),
                  child: Text(
                    widget.modules[_selectedModule].code,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size14,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Gaps.v10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            right: Sizes.size10,
                            top: Sizes.size5,
                            bottom: Sizes.size5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade600,
                            borderRadius:
                                const BorderRadiusDirectional.horizontal(
                              end: Radius.circular(Sizes.size10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: Sizes.size10),
                                child: Text(
                                  "Stage",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizes.size14,
                                    fontFamily: FontFamily.nanumGothic,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Gaps.v10,
                              for (int i = 0;
                                  i <
                                      widget.modules[_selectedModule].effect
                                          .length;
                                  i++)
                                ModuleStageButton(
                                  index: i,
                                  onModuleStageButtonTap:
                                      _onModuleStageButtonTap,
                                  title: "${i + 1}",
                                  isSelected: _selectedStage == i,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Gaps.h10,
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: Sizes.size10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ModuleInfoTitle(
                              code: widget.modules[_selectedModule].code
                                  .split('-')
                                  .last,
                              title: '스탯 증가',
                            ),
                            Gaps.v3,
                            for (var stat in widget.modules[_selectedModule]
                                .effect[_selectedStage].stat
                                .split(', '))
                              Text(
                                stat,
                                style: const TextStyle(
                                  fontSize: Sizes.size14,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
                              ),
                            Gaps.v7,
                            ModuleInfoTitle(
                              code: widget.modules[_selectedModule].code
                                  .split('-')
                                  .last,
                              title: widget.modules[_selectedModule].effect[0]
                                  .talent.name,
                            ),
                            Gaps.v3,
                            Text(
                              widget.modules[_selectedModule].effect[0].talent
                                  .info,
                              style: const TextStyle(
                                fontSize: Sizes.size14,
                                fontFamily: FontFamily.nanumGothic,
                              ),
                            ),
                            Gaps.v7,
                            if (_selectedStage != 0)
                              ModuleInfoTitle(
                                code: widget.modules[_selectedModule].code
                                    .split('-')
                                    .last,
                                title: widget.modules[_selectedModule]
                                    .effect[_selectedStage].talent.name,
                              ),
                            if (_selectedStage != 0) Gaps.v3,
                            if (_selectedStage != 0)
                              Text(
                                widget.modules[_selectedModule]
                                    .effect[_selectedStage].talent.info,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
