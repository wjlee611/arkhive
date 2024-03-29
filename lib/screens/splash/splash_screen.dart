import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/enemy_class_level_cubit.dart';
import 'package:arkhive/cubit/penguin_cubit.dart';
import 'package:arkhive/cubit/range_cubit.dart';
import 'package:arkhive/cubit/setting_cubit.dart';
import 'package:arkhive/cubit/splash_cubit.dart';
import 'package:arkhive/cubit/tags_cubit.dart';
import 'package:arkhive/enums/common_load_state.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:square_percent_indicater/square_percent_indicater.dart';
import 'dart:math' as math;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const int _maxProgress = 4;

  int progress(SplashState state) {
    switch (state) {
      case SplashState.tags:
        return 1;
      case SplashState.range:
        return 2;
      case SplashState.enemyClassLevel:
        return 3;
      case SplashState.penguin:
        return _maxProgress;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state == SplashState.tags) {
              context.read<TagsCubit>().loadTags(
                    dbRegion: getRegion(context),
                  );
            }
            if (state == SplashState.range) {
              context.read<RangeCubit>().loadRange(
                    dbRegion: getRegion(context),
                  );
            }
            if (state == SplashState.enemyClassLevel) {
              context.read<EnemyClassLevelCubit>().loadEnemyClassLevel(
                    dbRegion: getRegion(context),
                  );
            }
            if (state == SplashState.penguin) {
              context.read<PenguinCubit>().loadPenguin();
            }
            if (state == SplashState.complete) {
              if (context.read<SettingCubit>().state.settings.isFirst ?? true) {
                context.replace('/tutorial');
              } else {
                context.replace('/route');
              }
            }
          },
        ),
        BlocListener<TagsCubit, TagsState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == CommonLoadState.loaded) {
              context.read<SplashCubit>().changeLoadStatus(SplashState.range);
            }
            if (state.status == CommonLoadState.error) {
              context
                  .read<SplashCubit>()
                  .changeLoadStatus(SplashState.errorTags);
            }
          },
        ),
        BlocListener<RangeCubit, RangeState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == CommonLoadState.loaded) {
              context
                  .read<SplashCubit>()
                  .changeLoadStatus(SplashState.enemyClassLevel);
            }
            if (state.status == CommonLoadState.error) {
              context
                  .read<SplashCubit>()
                  .changeLoadStatus(SplashState.errorRange);
            }
          },
        ),
        BlocListener<EnemyClassLevelCubit, EnemyClassLevelState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == CommonLoadState.loaded) {
              context.read<SplashCubit>().changeLoadStatus(SplashState.penguin);
            }
            if (state.status == CommonLoadState.error) {
              context
                  .read<SplashCubit>()
                  .changeLoadStatus(SplashState.errorEnemyClassLevel);
            }
          },
        ),
        BlocListener<PenguinCubit, PenguinState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == CommonLoadState.loaded) {
              context
                  .read<SplashCubit>()
                  .changeLoadStatus(SplashState.complete);
            }
            if (state.status == CommonLoadState.error) {
              context
                  .read<SplashCubit>()
                  .changeLoadStatus(SplashState.errorPenguin);
            }
          },
        ),
      ],
      child: Scaffold(
        body: Center(
          child: BlocBuilder<SplashCubit, SplashState>(
            builder: (context, state) {
              if (state == SplashState.init) {
                context.read<SplashCubit>().changeLoadStatus(SplashState.tags);
              }
              if (state == SplashState.errorTags ||
                  state == SplashState.errorRange ||
                  state == SplashState.errorEnemyClassLevel ||
                  state == SplashState.errorPenguin) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppFont(state.message),
                      Gaps.v5,
                      const AppFont('신고 부탁드립니다.')
                    ],
                  ),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: math.pi / 4,
                    child: SquarePercentIndicator(
                      width: Sizes.size40,
                      height: Sizes.size40,
                      borderRadius: 0,
                      shadowWidth: Sizes.size1,
                      progressWidth: Sizes.size3,
                      progressColor: Colors.yellow.shade700,
                      shadowColor: Colors.yellow.shade600,
                      progress: progress(context.read<SplashCubit>().state) /
                          _maxProgress,
                      child: Transform.rotate(
                        angle: -math.pi / 4,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppFont(
                                '${progress(context.read<SplashCubit>().state)}',
                                color: Colors.yellow.shade800,
                                fontSize: Sizes.size20,
                                fontWeight: FontWeight.w700,
                              ),
                              AppFont(
                                '/$_maxProgress',
                                color: Colors.yellow.shade700,
                                fontSize: Sizes.size14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.v20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Sizes.size12,
                        height: Sizes.size12,
                        child: CircularProgressIndicator(
                          color: Colors.yellow.shade700,
                          strokeWidth: Sizes.size2,
                        ),
                      ),
                      Gaps.h10,
                      SizedBox(
                        width: Sizes.size48 * 2,
                        child: AppFont(
                          context.read<SplashCubit>().state.message,
                          fontSize: Sizes.size10,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
