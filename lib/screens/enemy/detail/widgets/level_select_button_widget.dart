import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_bloc.dart';
import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_event.dart';
import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';

class LevelSelectButton extends StatelessWidget {
  const LevelSelectButton({
    super.key,
    required this.levelLength,
  });

  final int levelLength;

  void _onChange(
    BuildContext context, {
    required int level,
  }) {
    context.read<EnemyLevelBloc>().add(EnemyLevelSetEvent(level: level));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnemyLevelBloc, EnemyLevelState>(
      builder: (context, state) => Center(
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
                current: state.level,
                values: [for (int i = 0; i < levelLength; i++) i],
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
                onChanged: (i) => _onChange(
                  context,
                  level: i,
                ),
              ),
            ),
            Icon(
              Icons.arrow_right_rounded,
              color: Colors.yellow.shade700,
              size: Sizes.size32,
            ),
          ],
        ),
      ),
    );
  }
}
