import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/tools/required_pot_elite_selector.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';

class OperatorTalentsWidget extends StatelessWidget {
  const OperatorTalentsWidget({
    super.key,
    required this.talents,
    required this.pot,
    required this.elite,
    required this.level,
  });

  final List<OperatorTalentsModel> talents;
  final int pot, elite, level;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonTitleWidget(text: '재능'),
        Gaps.v7,
        for (var talent in talents)
          if (reqPotEliteSelector(
                candidates: talent.candidates,
                currPot: pot,
                currElite: elite,
                currLevel: level,
              ) !=
              null)
            OperatorTalentWidget(
              talent: reqPotEliteSelector(
                candidates: talent.candidates,
                currPot: pot,
                currElite: elite,
                currLevel: level,
              )!,
              pot: pot,
              elite: elite,
              level: level,
            ),
      ],
    );
  }
}

class OperatorTalentWidget extends StatelessWidget {
  const OperatorTalentWidget({
    super.key,
    required this.talent,
    required this.pot,
    required this.elite,
    required this.level,
  });

  final OperatorTalentsCandidatesModel talent;
  final int pot, elite, level;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonSubTitleWidget(text: talent.name!),
        Gaps.v3,
        FormattedTextWidget(
          text: talent.description!,
          variables: blackboardListToMap(blackboards: talent.blackboard),
          center: false,
        ),
        Gaps.v10,
      ],
    );
  }
}
