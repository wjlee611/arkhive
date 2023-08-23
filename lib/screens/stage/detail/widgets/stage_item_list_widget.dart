import 'package:arkhive/bloc/item/stage_penguin/stage_penguin_bloc.dart';
import 'package:arkhive/bloc/item/stage_penguin/stage_penguin_event.dart';
import 'package:arkhive/bloc/item/stage_penguin/stage_penguin_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/penguin_cubit.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/screens/stage/detail/widgets/stage_penguin_item_widget.dart';
import 'package:arkhive/screens/stage/detail/widgets/stage_sanity_tag_widget.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageItemListWidget extends StatelessWidget {
  final String stageId;

  const StageItemListWidget({
    super.key,
    required this.stageId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<PenguinCubit, PenguinState>(
      listenWhen: (previous, current) => previous.server != current.server,
      listener: (context, state) {
        context.read<StagePenguinBloc>().add(StagePenguinInitEvent(
              penguinSrc:
                  context.read<PenguinCubit>().state.stages!.withId![stageId] ??
                      [],
            ));
      },
      child: BlocBuilder<StagePenguinBloc, StagePenguinState>(
        builder: (context, state) {
          if (state.status == CommonLoadState.init) {
            context.read<StagePenguinBloc>().add(StagePenguinInitEvent(
                  penguinSrc: context
                          .read<PenguinCubit>()
                          .state
                          .stages!
                          .withId![stageId] ??
                      [],
                ));
          }
          if (state.status == CommonLoadState.error) {
            return const Center(
              child: AppFont('데이터를 불러오는데 실패했습니다.'),
            );
          }
          if (state.sortedPenguin == null) {
            return const CommonLoadingWidget();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Sizes.size5),
                    child: BlocBuilder<PenguinCubit, PenguinState>(
                        builder: (context, state_) {
                      return SanityInfoTag(
                        title: '팽귄 물류 분석 보고서 (${state_.server?.region ?? '-'})',
                        value: state.times ?? 0,
                        isFormatting: true,
                        unit: '개',
                      );
                    }),
                  ),
                ],
              ),
              for (var penguin in state.sortedPenguin!)
                StagePenguinItemWidget(penguin: penguin),
            ],
          );
        },
      ),
    );
  }
}
