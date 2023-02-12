import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/detail/module_card/module_card_widget.dart';
import 'package:arkhive/screens/operator/detail/skill_card/skill_card_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_image_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_name_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/posinfo_card_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/talent_card_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OperatorDetailScreen extends StatefulWidget {
  final OperatorModel operator_;
  final Uint8List? opImage;

  const OperatorDetailScreen({
    super.key,
    required this.operator_,
    required this.opImage,
  });

  @override
  State<OperatorDetailScreen> createState() => _OperatorDetailScreenState();
}

class _OperatorDetailScreenState extends State<OperatorDetailScreen> {
  String _classImageSelector(String operClass) {
    if (operClass == OperatorPositions.vanguard) {
      return "assets/images/class_vanguard.png";
    }
    if (operClass == OperatorPositions.guard) {
      return "assets/images/class_guard.png";
    }
    if (operClass == OperatorPositions.defender) {
      return "assets/images/class_defender.png";
    }
    if (operClass == OperatorPositions.sniper) {
      return "assets/images/class_sniper.png";
    }
    if (operClass == OperatorPositions.caster) {
      return "assets/images/class_caster.png";
    }
    if (operClass == OperatorPositions.medic) {
      return "assets/images/class_medic.png";
    }
    if (operClass == OperatorPositions.supporter) {
      return "assets/images/class_supporter.png";
    }
    return "assets/images/class_specialist.png";
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
          Container(
            color: Colors.blueGrey.shade700,
            child: Container(
              margin: const EdgeInsets.only(top: Sizes.size48),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(blurRadius: Sizes.size5),
                ],
                borderRadius: BorderRadiusDirectional.vertical(
                  top: Radius.circular(Sizes.size48),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: ListView(
                children: [
                  Gaps.v44,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < int.parse(widget.operator_.rare); i++)
                        SizedBox(
                          width: Sizes.size16 + Sizes.size2,
                          child: Transform.rotate(
                            angle: 17 * math.pi / 180,
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow.shade700,
                              size: Sizes.size24 + Sizes.size2,
                              shadows: const [
                                Shadow(blurRadius: Sizes.size5),
                              ],
                            ),
                          ),
                        ),
                      Gaps.h5,
                    ],
                  ),
                  Gaps.v20,
                  OperatorName(name: widget.operator_.name),
                  Gaps.v10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        _classImageSelector(widget.operator_.class_),
                        width: Sizes.size36,
                        height: Sizes.size36,
                        color: Colors.blueGrey.shade700,
                      ),
                      Gaps.h20,
                      Text(
                        widget.operator_.position.replaceFirst('*', ''),
                        style: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontSize: Sizes.size20,
                          fontFamily: FontFamily.nanumGothic,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v20,
                  PosInfoCard(operatorPos: widget.operator_.position),
                  Gaps.v20,
                  TalentCard(talents: widget.operator_.talent),
                  if (widget.operator_.skill.isNotEmpty) Gaps.v20,
                  if (widget.operator_.skill.isNotEmpty)
                    SkillCard(skills: widget.operator_.skill),
                  if (widget.operator_.module.isNotEmpty) Gaps.v20,
                  if (widget.operator_.module.isNotEmpty)
                    ModuleCard(modules: widget.operator_.module),
                  Gaps.v60,
                ],
              ),
            ),
          ),
          OperatorImage(
            imageNameTag: widget.operator_.imageName,
            opImage: widget.opImage,
          ),
        ],
      ),
    );
  }
}
