import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/detail/widgets/elite_select_button_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_slider_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/potential_select_button_widget.dart';
import 'package:arkhive/tools/diagonal_clipper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OperatorDetailHeader extends StatefulWidget {
  const OperatorDetailHeader({
    super.key,
    this.image,
    required this.operator_,
    required this.onPotSelected,
    required this.onEliteSelected,
    required this.onLevelChange,
    required this.onFavorChange,
  });

  final Uint8List? image;
  final OperatorModel operator_;
  final Function(int) onPotSelected;
  final Function(int) onEliteSelected;
  final Function(int) onLevelChange;
  final Function(int) onFavorChange;

  @override
  State<OperatorDetailHeader> createState() => _OperatorDetailHeaderState();
}

class _OperatorDetailHeaderState extends State<OperatorDetailHeader> {
  int _elite = 0;
  int _level = 1;
  int _favor = 0;

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

  void _onFavorChange(int favor) {
    widget.onFavorChange(favor);
    _favor = favor;
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
        Gaps.h20,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PotentialSelectButton(
              onSelected: widget.onPotSelected,
              length: widget.operator_.maxPotentialLevel!,
            ),
            EliteSelectButton(
              onSelected: _onEliteChange,
              length: widget.operator_.phases.length,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: Sizes.size72 * 2,
                  height: Sizes.size44,
                  child: OperatorSlider(
                    minValue: 1,
                    maxValue: widget.operator_.phases[_elite].maxLevel!,
                    currValue: _level,
                    onChange: _onLevelChange,
                    tag: 'Lv',
                  ),
                ),
                SizedBox(
                  width: Sizes.size72 * 2,
                  height: Sizes.size44,
                  child: OperatorSlider(
                    minValue: 0,
                    maxValue: 110,
                    currValue: _favor,
                    onChange: _onFavorChange,
                    tag: '신뢰도',
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
