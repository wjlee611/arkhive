import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/detail/skill_card/widgets/skill_duration_widget.dart';
import 'package:arkhive/screens/operator/detail/skill_card/widgets/skill_sp_widget.dart';
import 'package:arkhive/screens/operator/detail/skill_card/widgets/skill_type_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/card_title_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/select_button_widget.dart';
import 'package:flutter/material.dart';

class SkillCard extends StatefulWidget {
  const SkillCard({
    super.key,
    required this.skills,
  });

  final List<SkillModel> skills;

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  int _selectedSkill = 0;

  void _onSkillButtonTap(int i) {
    setState(() {
      _selectedSkill = i;
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
              left: Sizes.size10,
              right: Sizes.size10,
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
                        Icons.sports_gymnastics_rounded,
                        color: Colors.yellow.shade700,
                        size: Sizes.size20,
                      ),
                      Gaps.h5,
                      const Text(
                        "스킬",
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
                    for (int i = 0; i < widget.skills.length; i++)
                      SelectButton(
                        index: i,
                        onTap: _onSkillButtonTap,
                        title: '${i + 1}',
                        isEnd: widget.skills.length - 1 == i,
                        isSelected: _selectedSkill == i,
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
                CardTitle(title: widget.skills[_selectedSkill].name),
                Row(
                  children: [
                    for (var type
                        in widget.skills[_selectedSkill].type.split('/'))
                      SkillType(type: type),
                  ],
                ),
                Gaps.v5,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SkillSP(sp: widget.skills[_selectedSkill].sp),
                    Gaps.h14,
                    SkillDuration(
                        duration: widget.skills[_selectedSkill].duration),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: Sizes.size10,
                    right: Sizes.size10,
                    top: Sizes.size10,
                  ),
                  child: Text(
                    widget.skills[_selectedSkill].info,
                    style: const TextStyle(
                      fontSize: Sizes.size14,
                      fontFamily: FontFamily.nanumGothic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
