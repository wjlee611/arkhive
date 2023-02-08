import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class LevelSelectButton extends StatefulWidget {
  const LevelSelectButton({
    super.key,
    required this.selectedLevel,
    required this.levelLength,
    required this.onTapLevel,
  });

  final int selectedLevel, levelLength;
  final Function(int) onTapLevel;

  @override
  State<LevelSelectButton> createState() => _LevelSelectButtonState();
}

class _LevelSelectButtonState extends State<LevelSelectButton> {
  late int _selectedLevel;

  @override
  void initState() {
    super.initState();
    _selectedLevel = widget.selectedLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_left_rounded,
            color: Colors.yellow.shade700,
            size: Sizes.size32,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AnimatedToggleSwitch.size(
              current: _selectedLevel,
              values: [for (int i = 0; i < widget.levelLength; i++) i],
              boxShadow: [
                BoxShadow(
                  blurRadius: Sizes.size2,
                  spreadRadius: Sizes.size1 / 10,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
              borderWidth: 0,
              iconOpacity: 0.5,
              indicatorSize: const Size.fromWidth(Sizes.size48),
              iconBuilder: (value, size) => Center(
                child: Stack(
                  children: [
                    for (int i = 0; i < value + 1; i++)
                      Transform.translate(
                        offset: Offset(
                            i * Sizes.size5 - value * (Sizes.size5 / 2), 0),
                        child: Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: Colors.white,
                          size: math.min(size.width, size.height),
                        ),
                      )
                  ],
                ),
              ),
              iconSize: const Size(Sizes.size20, Sizes.size20),
              selectedIconSize: const Size(Sizes.size28, Sizes.size28),
              borderColor: Colors.transparent,
              indicatorColor: Colors.yellow.shade700,
              innerColor: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.zero,
              height: Sizes.size32,
              animationCurve: Curves.easeOutExpo,
              iconAnimationCurve: Curves.easeOutExpo,
              onChanged: (i) => {
                setState(
                  () => {
                    _selectedLevel = i,
                    widget.onTapLevel(i),
                  },
                ),
              },
            ),
          ),
          Icon(
            Icons.arrow_right_rounded,
            color: Colors.yellow.shade700,
            size: Sizes.size32,
          ),
        ],
      ),
    );
  }
}
