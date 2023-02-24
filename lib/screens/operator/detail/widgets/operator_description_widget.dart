import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';

class OperatorDescriptionWidget extends StatelessWidget {
  const OperatorDescriptionWidget({
    super.key,
    required this.description,
    this.candidate,
  });

  final String description;
  final OperatorTalentsCandidatesModel? candidate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CommonTitleWidget(text: '특성'),
        Gaps.v5,
        FormattedTextWidget(
          text: candidate?.overrideDescripton != null
              ? candidate!.overrideDescripton!
              : description,
          variables: candidate?.blackboard != null
              ? blackboardListToMap(blackboards: candidate!.blackboard)
              : {},
        ),
      ],
    );
  }
}
