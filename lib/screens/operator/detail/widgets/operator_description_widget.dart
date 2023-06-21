import 'package:arkhive/bloc/operator/operator_data/operator_data_bloc.dart';
import 'package:arkhive/bloc/operator/operator_data/operator_data_state.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_bloc.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/tools/required_pot_elite_selector.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorDescriptionWidget extends StatelessWidget {
  const OperatorDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperatorDataBloc, OperatorDataState>(
        builder: (context, dataState) {
      return BlocBuilder<OperatorStatusBloc, OperatorStatusState>(
        builder: (context, statState) {
          if (dataState is! OperatorDataLoadedState) return Container();

          var description = dataState.operator_.description!;
          var candidate = dataState.operator_.traitCandidate.isNotEmpty
              ? reqPotEliteSelector(
                  candidates: dataState.operator_.traitCandidate,
                  currPot: statState.potential,
                  currElite: statState.elite,
                  currLevel: statState.level,
                )
              : null;
          return Column(
            children: [
              const CommonTitleWidget(text: '특성'),
              Gaps.v5,
              FormattedTextWidget(
                text: candidate?.overrideDescripton != null
                    ? candidate!.overrideDescripton!
                    : description,
                variables: candidate?.blackboard != null
                    ? boardListAndDurationToMap(
                        blackboards: candidate!.blackboard)
                    : {},
              ),
              Gaps.v16,
            ],
          );
        },
      );
    });
  }
}
