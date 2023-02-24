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
        Gaps.v5,
        for (var talent in talents)
          OperatorTalentWidget(
            talent: talent,
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

  final OperatorTalentsModel talent;
  final int pot, elite, level;

  @override
  Widget build(BuildContext context) {
    var currTalent =
        reqPotEliteSelector(candidates: talent.candidates, currPot: pot)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonSubTitleWidget(text: currTalent.name!),
        Gaps.v3,
        FormattedTextWidget(
          text: currTalent.description!,
          variables: blackboardListToMap(blackboards: currTalent.blackboard),
          center: false,
        ),
        Gaps.v10,
      ],
    );
  }
}
