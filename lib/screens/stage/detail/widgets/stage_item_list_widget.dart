import 'package:arkhive/bloc/item/stage_penguin/stage_penguin_bloc.dart';
import 'package:arkhive/bloc/item/stage_penguin/stage_penguin_event.dart';
import 'package:arkhive/bloc/item/stage_penguin/stage_penguin_state.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/screens/stage/detail/widgets/stage_penguin_item_widget.dart';
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
            Text('팽귄 보고서 수: ${state.times}'),
            for (var penguin in state.sortedPenguin!)
              StagePenguinItemWidget(penguin: penguin),
          ],
        );
      },
    );
  }
}
