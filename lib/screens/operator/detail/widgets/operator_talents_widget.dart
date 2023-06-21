import 'package:arkhive/bloc/operator/operator_data/operator_data_bloc.dart';
import 'package:arkhive/bloc/operator/operator_data/operator_data_state.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_bloc.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/tools/required_pot_elite_selector.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorTalentsWidget extends StatelessWidget {
  const OperatorTalentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperatorDataBloc, OperatorDataState>(
      builder: (context, dataState) {
        return BlocBuilder<OperatorStatusBloc, OperatorStatusState>(
          buildWhen: (previous, current) {
            if (previous.potential != current.potential ||
                previous.elite != current.elite) return true;
            return false;
          },
          builder: (context, statState) {
            if (dataState is! OperatorDataLoadedState) return Container();
            if (reqPotEliteSelector(
                  candidates: dataState.operator_.talents.first.candidates,
                  currPot: statState.potential,
                  currElite: statState.elite,
                  // currLevel: statState.level,
                ) ==
                null) return Container();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonTitleWidget(text: '재능'),
                Gaps.v7,
                for (var talent in dataState.operator_.talents)
                  _talentWidget(
                    context,
                    reqPotEliteSelector(
                      candidates: talent.candidates,
                      currPot: statState.potential,
                      currElite: statState.elite,
                      // currLevel: statState.level,
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _talentWidget(
      BuildContext context, OperatorTalentsCandidatesModel? talent) {
    if (talent == null) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonSubTitleWidget(text: talent.name!),
        Gaps.v3,
        FormattedTextWidget(
          text: talent.description!,
          variables: boardListAndDurationToMap(blackboards: talent.blackboard),
          center: false,
        ),
        Gaps.v10,
      ],
    );
  }
}
