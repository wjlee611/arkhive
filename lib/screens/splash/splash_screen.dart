import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/penguin_cubit.dart';
import 'package:arkhive/cubit/range_cubit.dart';
import 'package:arkhive/cubit/splash_cubit.dart';
import 'package:arkhive/cubit/tags_cubit.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:square_percent_indicater/square_percent_indicater.dart';
import 'dart:math' as math;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  int progress(SplashState state) {
    switch (state) {
      case SplashState.tags:
        return 1;
      case SplashState.range:
        return 2;
      case SplashState.penguin:
        return 3;
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
              print('tags');
              context.read<TagsCubit>().loadTags();
            }
            if (state == SplashState.range) {
              print('range');
              context.read<RangeCubit>().loadRange();
            }
            if (state == SplashState.penguin) {
              print('penguin');
              context.read<PenguinCubit>().loadPenguin();
            }
            if (state == SplashState.complete) {
              print('complete');
              context.replace('/route');
            }
          },
        ),
        BlocListener<TagsCubit, TagsState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == CommonLoadState.loaded) {
              context.read<SplashCubit>().changeLoadStatus(SplashState.range);
            }
          },
        ),
        BlocListener<RangeCubit, RangeState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == CommonLoadState.loaded) {
              context.read<SplashCubit>().changeLoadStatus(SplashState.penguin);
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
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: BlocBuilder<SplashCubit, SplashState>(
            builder: (context, state) {
              if (state == SplashState.init) {
                context.read<SplashCubit>().changeLoadStatus(SplashState.tags);
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
                      progress: progress(context.read<SplashCubit>().state) / 3,
                      child: Transform.rotate(
                        angle: -math.pi / 4,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${progress(context.read<SplashCubit>().state)}',
                                style: TextStyle(
                                  color: Colors.yellow.shade800,
                                  fontSize: Sizes.size20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
                              ),
                              Text(
                                '/3',
                                style: TextStyle(
                                  color: Colors.yellow.shade700,
                                  fontSize: Sizes.size14,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
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
                      Gaps.h5,
                      Text(
                        context.read<SplashCubit>().state.message,
                        style: const TextStyle(
                          fontSize: Sizes.size10,
                          fontFamily: FontFamily.nanumGothic,
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
