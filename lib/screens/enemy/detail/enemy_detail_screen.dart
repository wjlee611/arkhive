import 'package:arkhive/bloc/enemy/enemy_data/enemy_data_bloc.dart';
import 'package:arkhive/bloc/enemy/enemy_data/enemy_data_event.dart';
import 'package:arkhive/bloc/enemy/enemy_data/enemy_data_state.dart';
import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_bloc.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy/enemy_model.dart';
import 'package:arkhive/models/favorite_model.dart';
import 'package:arkhive/screens/enemy/detail/widgets/enemy_combat_info_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/enemy_header_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/enemy_hidden_info_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/enemy_tag_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/level_select_button_widget.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_favorite_widget.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyDetailScreen extends StatelessWidget {
  const EnemyDetailScreen({
    super.key,
    required this.enemyKey,
    this.initLevel = 0,
    required this.name,
    this.code,
  });

  final String enemyKey;
  final int initLevel;
  final String name;
  final String? code;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EnemyDataBloc(
            dbRegion: getRegion(context),
          ),
        ),
        BlocProvider(
          create: (context) => EnemyLevelBloc(level: initLevel),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const AppFont(
            "적 유닛 파일",
            color: Colors.white,
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w700,
          ),
          backgroundColor: Colors.blueGrey.shade700,
          actions: [
            CommonFavoriteWidget(
              keyId: enemyKey,
              iconId: enemyKey,
              name: name,
              category: FavorCategory.enemy,
            ),
          ],
        ),
        body: Stack(
          children: [
            BlocBuilder<EnemyDataBloc, EnemyDataState>(
              builder: (context, state) {
                if (state is EnemyDataInitState) {
                  context
                      .read<EnemyDataBloc>()
                      .add(EnemyDataLoadEvent(enemyKey: enemyKey));
                }
                if (state is EnemyDataLoadingState) {
                  return const CommonLoadingWidget();
                }
                if (state is EnemyDataLoadedState) {
                  return _buildBody(
                    context: context,
                    enemy: state.enemy,
                    enemyData: state.enemyData,
                  );
                }
                if (state is EnemyDataErrorState) {
                  return Center(
                    child: AppFont('${state.message} 데이터를 불러오는데 실패했습니다.'),
                  );
                }
                return const CommonLoadingWidget();
              },
            ),
            EnemyHeader(
              enemyKey: enemyKey,
              code: code,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required EnemyModel enemy,
    required EnemyDataModel enemyData,
  }) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        child: Column(
          children: [
            Gaps.v130,
            if ((enemyData.values?.length ?? 0) > 1)
              LevelSelectButton(levelLength: (enemyData.values?.length ?? 0)),
            (enemyData.values?.length ?? 0) > 1 ? Gaps.v16 : Container(),
            CommonTitleWidget(
              text: enemy.name!,
              color: Colors.yellow.shade800,
            ),
            Gaps.v5,
            Wrap(
              direction: Axis.horizontal,
              spacing: Sizes.size4,
              runSpacing: Sizes.size4,
              children: [
                if (enemy.enemyLevel != null)
                  EnemyLevelTagWidget(tag: enemy.enemyLevel!),
                if (enemy.enemyRace != null)
                  EnemyTagWidget(tag: enemy.enemyRace!),
              ],
            ),
            Gaps.v32,
            EnemyCombatInfo(
              enemy: enemy,
              enemyDataValues: enemyData.values ?? [],
            ),
            if (enemy.ability != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v16,
                  const CommonTitleWidget(text: '특수 능력'),
                  Gaps.v5,
                  FormattedTextWidget(text: enemy.ability!),
                  Gaps.v20,
                ],
              ),
            if (enemyData.values?[0].talentBlackboard?.isNotEmpty == true)
              EnemyHiddenInfoWidget(enemyDataValues: enemyData.values ?? []),
            Gaps.v80,
          ],
        ),
      ),
    );
  }
}
