import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/operator/operator_screen.dart';
import 'package:flutter/material.dart';

class ProfessionButton extends StatelessWidget {
  const ProfessionButton({
    super.key,
    required this.onTap,
    required this.profession,
    required this.isSelected,
  });

  final Function() onTap;
  final Professions profession;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: Sizes.size48,
        height: Sizes.size48,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            if (isSelected)
              IgnorePointer(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: Sizes.size48,
                      height: Sizes.size48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [
                            0,
                            0.2,
                          ],
                          colors: [
                            Colors.yellow.shade800,
                            Colors.blueGrey.shade700,
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -Sizes.size12),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.yellow.shade800,
                        size: Sizes.size32,
                      ),
                    ),
                    Container(
                      width: Sizes.size48,
                      height: Sizes.size3,
                      color: Colors.yellow.shade800,
                    ),
                  ],
                ),
              ),
            if (profession == Professions.all)
              Center(
                child: Text(
                  "전체",
                  style: TextStyle(
                    color: isSelected ? Colors.yellow.shade800 : Colors.white,
                    fontFamily: FontFamily.nanumGothic,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            else if (profession == Professions.perparation)
              Center(
                child: Text(
                  "예비",
                  style: TextStyle(
                    color: isSelected ? Colors.yellow.shade800 : Colors.white,
                    fontFamily: FontFamily.nanumGothic,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            else
              Center(
                child: Transform.translate(
                  offset: Offset(
                    profession == Professions.sniper ? -Sizes.size3 : 0,
                    0,
                  ),
                  child: Image.asset(
                    profession == Professions.vanguard
                        ? 'assets/images/class_vanguard.png'
                        : profession == Professions.guard
                            ? 'assets/images/class_guard.png'
                            : profession == Professions.defender
                                ? 'assets/images/class_defender.png'
                                : profession == Professions.sniper
                                    ? 'assets/images/class_sniper.png'
                                    : profession == Professions.caster
                                        ? 'assets/images/class_caster.png'
                                        : profession == Professions.medic
                                            ? 'assets/images/class_medic.png'
                                            : profession ==
                                                    Professions.supporter
                                                ? 'assets/images/class_supporter.png'
                                                : 'assets/images/class_specialist.png',
                    width: Sizes.size32,
                    height: Sizes.size32,
                    color: isSelected ? Colors.yellow.shade800 : Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
