import 'dart:typed_data';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_module_container.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_skill_container.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_description_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_detail_header_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_star_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_stat_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_tag_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_talents_widget.dart';
import 'package:arkhive/tools/profession_selector.dart';
import 'package:arkhive/tools/required_pot_elite_selector.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OperatorDetailScreen extends StatefulWidget {
  const OperatorDetailScreen({
    super.key,
    required this.operator_,
    this.opImage,
  });

  final OperatorModel operator_;
  final Uint8List? opImage;

  @override
  State<OperatorDetailScreen> createState() => _OperatorDetailScreenState();
}

class _OperatorDetailScreenState extends State<OperatorDetailScreen> {
  int _potential = 0;
  int _elite = 0;
  int _level = 1;
  int _favor = 0;

  void _onPotSelected(int pot) {
    setState(() {
      _potential = pot;
    });
  }

  void _onEliteSelected(int elite) {
    setState(() {
      _elite = elite;
    });
  }

  void _onLevelChange(int level) {
    setState(() {
      _level = level;
    });
  }

  void _onFavorChange(int favor) {
    setState(() {
      _favor = favor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "이력서",
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
            onPressed: () {
              //TODO: 즐겨찾기 추가/삭제 알고리즘 추가
            },
            icon: Icon(
              Icons.star_border_outlined,
              color: Colors.yellow.shade700,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
              child: Column(
                children: [
                  Gaps.v96,
                  Hero(
                    tag: widget.operator_.phases.first.characterPrefabKey!,
                    child: Transform.scale(
                      scale: 0.65,
                      child: Transform.rotate(
                        angle: 45 * math.pi / 180,
                        child: Container(
                          width: Sizes.size96,
                          height: Sizes.size96,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100,
                            border: Border.all(
                              width: Sizes.size7,
                              color: Colors.yellow.shade800,
                              strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                          ),
                          child: Transform.scale(
                            scale: 1.4,
                            child: Transform.rotate(
                              angle: -45 * math.pi / 180,
                              child: widget.opImage != null
                                  ? Image.memory(
                                      widget.opImage!,
                                      width: Sizes.size96,
                                      height: Sizes.size96,
                                      gaplessPlayback: true,
                                    )
                                  : Image.asset(
                                      'assets/images/prts.png',
                                      width: Sizes.size96,
                                      height: Sizes.size96,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.v10,
                  CommonTitleWidget(
                    text: widget.operator_.name!,
                    color: Colors.yellow.shade800,
                  ),
                  Gaps.v5,
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: Sizes.size4,
                    runSpacing: Sizes.size4,
                    children: [
                      if (widget.operator_.rarity != null)
                        OperatorStarWidget(rarity: widget.operator_.rarity!),
                      if (widget.operator_.profession != null)
                        OperatorTagWidget(
                          tag: proSelector(widget.operator_.profession!),
                        ),
                      if (widget.operator_.subProfessionId != null)
                        OperatorTagWidget(
                          tag:
                              subProSelector(widget.operator_.subProfessionId!),
                        ),
                    ],
                  ),
                  Gaps.v16,
                  if (widget.operator_.position != null ||
                      widget.operator_.tagList.isNotEmpty)
                    OperatorTagWrapWidget(
                      position: widget.operator_.position,
                      tagList: widget.operator_.tagList,
                    ),
                  if (widget.operator_.phases.isNotEmpty &&
                      widget.operator_.phases.first.attributesKeyFrames
                          .isNotEmpty)
                    Column(
                      children: [
                        const CommonTitleWidget(text: '스탯'),
                        Gaps.v5,
                        OperatorStatWidget(
                          phase: widget.operator_.phases[_elite],
                          pot: _potential,
                          level: _level,
                          favor: _favor,
                          favorPhase: widget.operator_.favorKeyFrames,
                          potRanks: widget.operator_.potentialRanks,
                        ),
                      ],
                    ),
                  if (widget.operator_.description != null)
                    OperatorDescriptionWidget(
                      description: widget.operator_.description!,
                      candidate: widget.operator_.traitCandidate.isNotEmpty
                          ? reqPotEliteSelector(
                              candidates: widget.operator_.traitCandidate,
                              currPot: _potential,
                              currElite: _elite,
                              currLevel: _level,
                            )
                          : null,
                    ),
                  if (widget.operator_.talents.isNotEmpty &&
                      reqPotEliteSelector(
                            candidates:
                                widget.operator_.talents.first.candidates,
                            currPot: _potential,
                            currElite: _elite,
                            currLevel: _level,
                          ) !=
                          null)
                    OperatorTalentsWidget(
                      talents: widget.operator_.talents,
                      pot: _potential,
                      elite: _elite,
                      level: _level,
                    ),
                  if (widget.operator_.skills.isNotEmpty)
                    OperatorSkillContainer(skills: widget.operator_.skills),
                  if (widget.operator_.phases.first.characterPrefabKey != null)
                    OperatorModuleContainer(
                      operatorKey:
                          widget.operator_.phases.first.characterPrefabKey!,
                      potential: _potential,
                    ),
                  Gaps.v60,
                ],
              ),
            ),
          ),
          OperatorDetailHeader(
            image: widget.opImage,
            operator_: widget.operator_,
            onPotSelected: _onPotSelected,
            onEliteSelected: _onEliteSelected,
            onLevelChange: _onLevelChange,
            onFavorChange: _onFavorChange,
          ),
        ],
      ),
    );
  }
}
