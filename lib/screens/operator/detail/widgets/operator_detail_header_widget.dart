import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/detail/widgets/elite_select_button_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_level_slider_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/potential_select_button_widget.dart';
import 'package:arkhive/tools/diagonal_clipper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OperatorDetailHeader extends StatefulWidget {
  const OperatorDetailHeader({
    super.key,
    this.image,
    required this.operator_,
    required this.onPotSelected,
    required this.onEliteSelected,
    required this.onLevelChange,
  });

  final Uint8List? image;
  final OperatorModel operator_;
  final Function(int) onPotSelected;
  final Function(int) onEliteSelected;
  final Function(int) onLevelChange;

  @override
  State<OperatorDetailHeader> createState() => _OperatorDetailHeaderState();
}

class _OperatorDetailHeaderState extends State<OperatorDetailHeader> {
  int _elite = 0;
  int _level = 1;

  void _onEliteChange(int elite) {
    _onLevelChange(1);
    widget.onEliteSelected(elite);
    _level = 1;
    _elite = elite;
  }

  void _onLevelChange(int level) {
    widget.onLevelChange(level);
    _level = level;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ClipPath(
          clipper: DiagonalClipper(),
          child: Container(
            height: Sizes.size96,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.operator_.phases.first.characterPrefabKey!,
              child: Transform.translate(
                offset: const Offset(Sizes.size10, Sizes.size7),
                child: Transform.scale(
                  scale: 0.65,
                  child: Transform.rotate(
                    angle: 45 * math.pi / 180,
                    child: Container(
                      width: Sizes.size96,
                      height: Sizes.size96,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        border: Border.all(
                          width: Sizes.size7,
                          color: Colors.black.withOpacity(0.3),
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      child: Transform.scale(
                        scale: 1.4,
                        child: Transform.rotate(
                          angle: -45 * math.pi / 180,
                          child: widget.image != null
                              ? Image.memory(
                                  widget.image!,
                                  width: Sizes.size96,
                                  height: Sizes.size96,
                                  gaplessPlayback: true,
                                )
                              : Image.asset(
                                  'assets/images/prts.png',
                                  width: Sizes.size96,
                                  height: Sizes.size96,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Gaps.h20,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    PotentialSelectButton(
                      onSelected: widget.onPotSelected,
                      length: widget.operator_.maxPotentialLevel!,
                    ),
                    Gaps.h10,
                    EliteSelectButton(
                      onSelected: _onEliteChange,
                      length: widget.operator_.phases.length,
                    ),
                  ],
                ),
                Transform.translate(
                  offset: const Offset(Sizes.size5, 0),
                  child: SizedBox(
                    width: Sizes.size72 * 2,
                    child: OperatorLevelSlider(
                      minValue: 1,
                      maxValue: widget.operator_.phases[_elite].maxLevel!,
                      currValue: _level,
                      onChange: _onLevelChange,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
