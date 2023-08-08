import 'package:arkhive/bloc/item/stage_penguin/stage_penguin_bloc.dart';
import 'package:arkhive/bloc/item/stage_penguin/stage_penguin_event.dart';
import 'package:arkhive/bloc/item/stage_penguin/stage_penguin_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/screens/stage/detail/widgets/stage_penguin_item_widget.dart';
import 'package:arkhive/screens/stage/detail/widgets/stage_sanity_tag_widget.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageItemListWidget extends StatelessWidget {
  const StageItemListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StagePenguinBloc, StagePenguinState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == CommonLoadState.init) {
          context.read<StagePenguinBloc>().add(StagePenguinInitEvent());
        }
        if (state.status == CommonLoadState.error) {
          return const Text('데이터를 불러오는데 실패했습니다.');
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
                  child: SanityInfoTag(
                    title: '팽귄 물류 분석 보고서',
                    value: state.times ?? 0,
                    isFormatting: true,
                    unit: '개',
                  ),
                ),
              ],
            ),
            for (var penguin in state.sortedPenguin!)
              StagePenguinItemWidget(penguin: penguin),
          ],
        );
      },
    );
  }
}
