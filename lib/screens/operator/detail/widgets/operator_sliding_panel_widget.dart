import 'package:arkhive/bloc/operator/operator_data/operator_data_bloc.dart';
import 'package:arkhive/bloc/operator/operator_data/operator_data_state.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_bloc.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_event.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/operator/detail/widgets/elite_select_button_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_slider_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/potential_select_button_widget.dart';
import 'package:arkhive/widgets/asset_image_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OperatorSlidingPanel extends StatefulWidget {
  const OperatorSlidingPanel({
    super.key,
    required this.operatorKey,
    required this.controller,
  });

  final String operatorKey;
  final PanelController controller;

  @override
  State<OperatorSlidingPanel> createState() => _OperatorSlidingPanelState();
}

class _OperatorSlidingPanelState extends State<OperatorSlidingPanel> {
  void _onPotentialChange(int potential) {
    context
        .read<OperatorStatusBloc>()
        .add(OperatorStatusPotentialChangeEvent(potential: potential));
  }

  void _onEliteChange(int elite) {
    context
        .read<OperatorStatusBloc>()
        .add(OperatorStatusEliteChangeEvent(elite: elite));
  }

  void _onLevelChange(int level) {
    context
        .read<OperatorStatusBloc>()
        .add(OperatorStatusLevelChangeEvent(level: level));
  }

  void _onFavorChange(int favor) {
    context
        .read<OperatorStatusBloc>()
        .add(OperatorStatusFavorChangeEvent(favor: favor));
  }

  void _onToggleBtnTap() {
    if (context.read<OperatorDataBloc>().state is! OperatorDataLoadedState) {
      return;
    }

    if (widget.controller.isPanelOpen) {
      widget.controller.close();
    } else {
      widget.controller.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<OperatorDataBloc, OperatorDataState>(
          builder: (context, dataState) {
            if (dataState is! OperatorDataLoadedState) {
              return Container();
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        PotentialSelectButton(
                          onSelected: _onPotentialChange,
                          length: dataState.operator_.potentialRanks.length,
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
                          length: dataState.operator_.phases.length,
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
                      child:
                          BlocBuilder<OperatorStatusBloc, OperatorStatusState>(
                        buildWhen: (previous, current) {
                          return (previous.level != current.level) ||
                              (previous.maxLevel != current.maxLevel);
                        },
                        builder: (context, statState) => OperatorSlider(
                          minValue: 1,
                          maxValue: statState.maxLevel,
                          currValue: statState.level,
                          onChange: _onLevelChange,
                          tag: '',
                        ),
                      ),
                    )
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
                      child:
                          BlocBuilder<OperatorStatusBloc, OperatorStatusState>(
                        buildWhen: (previous, current) {
                          return previous.favor != current.favor;
                        },
                        builder: (context, statState) => OperatorSlider(
                          minValue: 0,
                          maxValue: 110,
                          currValue: statState.favor,
                          onChange: _onFavorChange,
                          tag: '',
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
        const Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Hero(
                    tag: widget.operatorKey,
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
                      child: AssetImageWidget(
                        path:
                            'assets/images/operator/${widget.operatorKey}.png',
                      ),
                    ),
                  ),
                  BlocBuilder<OperatorStatusBloc, OperatorStatusState>(
                    buildWhen: (previous, current) {
                      return previous.potential != current.potential;
                    },
                    builder: (context, state) => Container(
                      color: Colors.black.withOpacity(0.4),
                      width: Sizes.size32,
                      height: Sizes.size32,
                      child: Center(
                        child: Image.asset(
                            'assets/images/p${state.potential + 1}.png'),
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.h14,
              Column(
                children: [
                  BlocBuilder<OperatorStatusBloc, OperatorStatusState>(
                    buildWhen: (previous, current) {
                      return previous.elite != current.elite;
                    },
                    builder: (context, state) => SizedBox(
                      width: Sizes.size32,
                      height: Sizes.size32,
                      child: Center(
                        child: Image.asset('assets/images/e${state.elite}.png'),
                      ),
                    ),
                  ),
                  BlocBuilder<OperatorStatusBloc, OperatorStatusState>(
                    buildWhen: (previous, current) {
                      return previous.level != current.level;
                    },
                    builder: (context, state) => Container(
                      width: Sizes.size32,
                      height: Sizes.size32,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade700,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: Sizes.size28,
                          height: Sizes.size28,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade700,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              state.level.toString(),
                              style: const TextStyle(
                                fontFamily: FontFamily.nanumGothic,
                                fontWeight: FontWeight.w700,
                                fontSize: Sizes.size12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.h10,
              const Icon(
                Icons.favorite_rounded,
                color: Colors.redAccent,
              ),
              BlocBuilder<OperatorStatusBloc, OperatorStatusState>(
                buildWhen: (previous, current) {
                  return previous.favor != current.favor;
                },
                builder: (context, state) => Text(
                  state.favor > 100
                      ? (100 + (state.favor - 100) * 10).toString()
                      : state.favor.toString(),
                  style: const TextStyle(
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                    fontSize: Sizes.size14,
                    color: Colors.white,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                onPressed: _onToggleBtnTap,
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Gaps.v10,
      ],
    );
  }
}
