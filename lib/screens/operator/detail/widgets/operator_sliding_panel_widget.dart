import 'dart:typed_data';

import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/detail/widgets/elite_select_button_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_slider_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/potential_select_button_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';

class OperatorSlidingPanel extends StatefulWidget {
  const OperatorSlidingPanel({
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
  State<OperatorSlidingPanel> createState() => _OperatorSlidingPanelState();
}

class _OperatorSlidingPanelState extends State<OperatorSlidingPanel> {
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                PotentialSelectButton(
                  onSelected: widget.onPotSelected,
                  length: widget.operator_.maxPotentialLevel!,
                ),
                Gaps.v5,
                const CommonSubTitleWidget(text: '잠재능력'),
              ],
            ),
            Gaps.h20,
            Column(
              children: [
                EliteSelectButton(
                  onSelected: _onEliteChange,
                  length: widget.operator_.phases.length,
                ),
                Gaps.v5,
                const CommonSubTitleWidget(text: '정예화 단계'),
              ],
            ),
          ],
        ),
        Gaps.v20,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: Sizes.size52,
              child: CommonSubTitleWidget(text: '레벨'),
            ),
            SizedBox(
              height: Sizes.size44,
              child: OperatorSlider(
                minValue: 1,
                maxValue: widget.operator_.phases[_elite].maxLevel!,
                currValue: _level,
                onChange: _onLevelChange,
                tag: '',
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: Sizes.size52,
              child: CommonSubTitleWidget(text: '신뢰도'),
            ),
            SizedBox(
              height: Sizes.size44,
              child: OperatorSlider(
                minValue: 0,
                maxValue: 110,
                currValue: _favor,
                onChange: _onFavorChange,
                tag: '',
              ),
            )
          ],
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(bottom: Sizes.size10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Hero(
                tag: widget.operator_.phases.first.characterPrefabKey!,
                child: Container(
                  width: Sizes.size72,
                  height: Sizes.size72,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    border: Border.all(
                      width: Sizes.size5,
                      color: Colors.black.withOpacity(0.2),
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
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
      ],
    );
  }
}
