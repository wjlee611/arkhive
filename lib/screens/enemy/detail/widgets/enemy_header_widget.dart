import 'package:arkhive/bloc/enemy/enemy_data/enemy_data_bloc.dart';
import 'package:arkhive/bloc/enemy/enemy_data/enemy_data_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/tools/diagonal_clipper.dart';
import 'package:arkhive/widgets/asset_image_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyHeader extends StatelessWidget {
  const EnemyHeader({
    super.key,
    required this.enemyKey,
  });

  final String enemyKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnemyDataBloc, EnemyDataState>(
      builder: (context, state) => Stack(
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
          Transform.translate(
            offset: const Offset(
              0,
              Sizes.size10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: Sizes.size5,
                        spreadRadius: Sizes.size1,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: enemyKey,
                    child: AssetImageWidget(
                      path: 'assets/images/enemy/$enemyKey.png',
                      width: Sizes.size96,
                      height: Sizes.size96,
                    ),
                  ),
                ),
                Gaps.h28,
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Transform.rotate(
                      angle: 45 * math.pi / 180,
                      child: Container(
                        width: Sizes.size52,
                        height: Sizes.size52,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          border: Border.all(
                            color: Colors.white,
                            width: Sizes.size4,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: Sizes.size5,
                              blurStyle: BlurStyle.outer,
                            ),
                          ],
                        ),
                        child: Container(),
                      ),
                    ),
                    Text(
                      state is EnemyDataLoadedState
                          ? state.enemy.enemyIndex!
                          : '/**/',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          const Shadow(
                            blurRadius: Sizes.size16,
                          ),
                          Shadow(
                            blurRadius: Sizes.size10,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
