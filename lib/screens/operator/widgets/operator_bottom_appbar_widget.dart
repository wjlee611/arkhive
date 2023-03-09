import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/operator/widgets/operator_profession_button.dart';
import 'package:flutter/material.dart';

import '../operator_screen.dart';

class OperatorBottomAppBar extends StatefulWidget {
  const OperatorBottomAppBar({
    super.key,
    required this.onProfessionTap,
    required this.selectedProfession,
    required this.searchKeyword,
  });

  final Function(Professions) onProfessionTap;
  final Professions selectedProfession;
  final String searchKeyword;

  @override
  State<OperatorBottomAppBar> createState() => _OperatorBottomAppBarState();
}

class _OperatorBottomAppBarState extends State<OperatorBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blueGrey.shade700,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
          child: Row(
            children: [
              ProfessionButton(
                onTap: () => widget.onProfessionTap(Professions.all),
                profession: Professions.all,
                isSelected: widget.searchKeyword.isEmpty &&
                    widget.selectedProfession == Professions.all,
              ),
              ProfessionButton(
                onTap: () => widget.onProfessionTap(Professions.vanguard),
                profession: Professions.vanguard,
                isSelected: widget.searchKeyword.isEmpty &&
                    widget.selectedProfession == Professions.vanguard,
              ),
              ProfessionButton(
                onTap: () => widget.onProfessionTap(Professions.guard),
                profession: Professions.guard,
                isSelected: widget.searchKeyword.isEmpty &&
                    widget.selectedProfession == Professions.guard,
              ),
              ProfessionButton(
                onTap: () => widget.onProfessionTap(Professions.defender),
                profession: Professions.defender,
                isSelected: widget.searchKeyword.isEmpty &&
                    widget.selectedProfession == Professions.defender,
              ),
              ProfessionButton(
                onTap: () => widget.onProfessionTap(Professions.sniper),
                profession: Professions.sniper,
                isSelected: widget.searchKeyword.isEmpty &&
                    widget.selectedProfession == Professions.sniper,
              ),
              ProfessionButton(
                onTap: () => widget.onProfessionTap(Professions.caster),
                profession: Professions.caster,
                isSelected: widget.searchKeyword.isEmpty &&
                    widget.selectedProfession == Professions.caster,
              ),
              ProfessionButton(
                onTap: () => widget.onProfessionTap(Professions.medic),
                profession: Professions.medic,
                isSelected: widget.searchKeyword.isEmpty &&
                    widget.selectedProfession == Professions.medic,
              ),
              ProfessionButton(
                onTap: () => widget.onProfessionTap(Professions.supporter),
                profession: Professions.supporter,
                isSelected: widget.searchKeyword.isEmpty &&
                    widget.selectedProfession == Professions.supporter,
              ),
              ProfessionButton(
                onTap: () => widget.onProfessionTap(Professions.specialist),
                profession: Professions.specialist,
                isSelected: widget.searchKeyword.isEmpty &&
                    widget.selectedProfession == Professions.specialist,
              ),
              ProfessionButton(
                onTap: () => widget.onProfessionTap(Professions.perparation),
                profession: Professions.perparation,
                isSelected: widget.searchKeyword.isEmpty &&
                    widget.selectedProfession == Professions.perparation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
