import 'package:arkhive/bloc/operator/operator_list/operator_list_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/operator/widgets/operator_profession_button.dart';
import 'package:flutter/material.dart';

class OperatorBottomAppBar extends StatelessWidget {
  const OperatorBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blueGrey.shade700,
      padding: EdgeInsets.zero,
      height: Sizes.size48,
      child: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size10),
          child: Row(
            children: [
              ProfessionButton(profession: Professions.all),
              ProfessionButton(profession: Professions.vanguard),
              ProfessionButton(profession: Professions.guard),
              ProfessionButton(profession: Professions.defender),
              ProfessionButton(profession: Professions.sniper),
              ProfessionButton(profession: Professions.caster),
              ProfessionButton(profession: Professions.medic),
              ProfessionButton(profession: Professions.supporter),
              ProfessionButton(profession: Professions.specialist),
              ProfessionButton(profession: Professions.perparation),
            ],
          ),
        ),
      ),
    );
  }
}
