import 'package:arkhive/bloc/item/stage_penguin/stage_penguin_bloc.dart';
import 'package:arkhive/bloc/stage/stage_data/stage_data_bloc.dart';
import 'package:arkhive/bloc/stage/stage_data/stage_data_event.dart';
import 'package:arkhive/bloc/stage/stage_data/stage_data_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/favorite_model.dart';
import 'package:arkhive/models/stage_model.dart';
import 'package:arkhive/screens/stage/detail/widgets/stage_item_list_widget.dart';
import 'package:arkhive/screens/stage/detail/widgets/stage_sanity_tag_widget.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_diffgroup_widget.dart';
import 'package:arkhive/widgets/common_favorite_widget.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:arkhive/widgets/penguin_server_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageDetailScreen extends StatelessWidget {
  const StageDetailScreen({
    super.key,
    required this.stageKey,
    required this.stageCode,
    required this.diffGroup,
    required this.difficulty,
  });

  final String stageKey;
  final String stageCode;
  final String diffGroup;
  final String difficulty;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StageDataBloc(),
      child: BlocBuilder<StageDataBloc, StageDataState>(
        builder: (context, state) {
          if (state is StageDataInitState) {
            context
                .read<StageDataBloc>()
                .add(StageDataLoadEvent(stageKey: stageKey));
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppFont(
                    stageCode,
                    color: difficulty == 'FOUR_STAR'
                        ? Colors.redAccent
                        : Colors.white,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w700,
                  ),
                  CommonDiffGroupWidget(diffGroup: diffGroup),
                ],
              ),
              backgroundColor: Colors.blueGrey.shade700,
              actions: [
                const PenguinServerSelector(),
                CommonFavoriteWidget(
                  keyId: stageKey,
                  name: stageCode,
                  diffGroup: diffGroup,
                  difficulty: difficulty,
                  category: FavorCategory.stage,
                ),
              ],
            ),
            body: (state is StageDataErrorState)
                ? Center(
                    child: AppFont(
                      '${(state).message} 데이터를 불러오는데 실패했습니다.',
                    ),
                  )
                : (state is! StageDataLoadedState)
                    ? const CommonLoadingWidget()
                    : _buildBody(state.stage),
          );
        },
      ),
    );
  }

  Widget _buildBody(StageModel stage) {
    return BlocProvider(
      create: (context) => StagePenguinBloc(
        stage,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              CommonTitleWidget(
                text: stage.name ?? '???',
                color: Colors.yellow.shade800,
              ),
              if (stage.description != null)
                Column(
                  children: [
                    Gaps.v10,
                    FormattedTextWidget(
                      text: stage.description!,
                      center: false,
                    ),
                  ],
                ),
              Gaps.v10,
              SanityInfoTag(
                title: '소모 이성',
                value: stage.apCost ?? -1,
              ),
              Gaps.v5,
              SanityInfoTag(
                title: '반환 이성',
                value: stage.apFailReturn ?? -1,
              ),
              Gaps.v20,
              if (stage.stageDropInfo != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonTitleWidget(text: '드랍 아이템'),
                    StageItemListWidget(stageId: stage.stageId ?? ''),
                  ],
                ),
              Gaps.v130,
            ],
          ),
        ),
      ),
    );
  }
}
