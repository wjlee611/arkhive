import 'dart:convert';
import 'dart:typed_data';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/enemy/detail/widgets/enemy_combat_info_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/enemy_header_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/enemy_hidden_info_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/enemy_tag_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/level_select_button_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EnemyDetailScreen extends StatefulWidget {
  final EnemyModel enemy;
  final Uint8List? enemyImage;
  final int initLevel;

  const EnemyDetailScreen({
    super.key,
    required this.enemy,
    required this.enemyImage,
    this.initLevel = 0,
  });

  @override
  State<EnemyDetailScreen> createState() => _EnemyDetailScreenState();
}

class _EnemyDetailScreenState extends State<EnemyDetailScreen> {
  late int _selectedLevel;

  @override
  void initState() {
    super.initState();
    _selectedLevel = widget.initLevel;
  }

  Future<EnemyDataModel?> _futureEnemyData() async {
    const storage = FlutterSecureStorage();

    String? enemyDataString =
        await storage.read(key: 'enemy_data/${widget.enemy.enemyId}');
    if (enemyDataString == null) return null;

    var enemyDataJson = await json.decode(enemyDataString);
    return EnemyDataModel.fromJson(enemyDataJson);
  }

  void _onTapLevel(int i) {
    setState(() {
      _selectedLevel = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "적 유닛 파일",
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
            onPressed: () {
              //TODO: 즐겨찾기 추가/삭제 알고리즘 추가
            },
            icon: Icon(
              Icons.star_border_outlined,
              color: Colors.yellow.shade700,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _futureEnemyData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size20),
                    child: Column(
                      children: [
                        Gaps.v130,
                        if (snapshot.data!.values.length > 1)
                          LevelSelectButton(
                            selectedLevel: _selectedLevel,
                            levelLength: snapshot.data!.values.length,
                            onTapLevel: _onTapLevel,
                          ),
                        snapshot.data!.values.length > 1
                            ? Gaps.v16
                            : Container(),
                        CommonTitleWidget(
                          text: widget.enemy.name!,
                          color: Colors.yellow.shade800,
                        ),
                        Gaps.v5,
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: Sizes.size4,
                          runSpacing: Sizes.size4,
                          children: [
                            if (widget.enemy.enemyLevel != null)
                              EnemyLevelTagWidget(
                                  tag: widget.enemy.enemyLevel!),
                            if (widget.enemy.enemyRace != null)
                              EnemyTagWidget(tag: widget.enemy.enemyRace!),
                          ],
                        ),
                        Gaps.v16,
                        EnemyCombatInfo(
                          enemy: widget.enemy,
                          enemyDatas: snapshot.data!.values,
                          level: _selectedLevel,
                        ),
                        if (widget.enemy.ability != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gaps.v16,
                              const CommonTitleWidget(text: '특수 능력'),
                              Gaps.v5,
                              FormattedTextWidget(text: widget.enemy.ability!),
                            ],
                          ),
                        if (snapshot
                            .data!.values[0].talentBlackboard.isNotEmpty)
                          EnemyHiddenInfoWidget(
                            enemyDatas: snapshot.data!.values,
                            level: _selectedLevel,
                          ),
                        Gaps.v130,
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.yellow.shade800,
                  ),
                );
              }
            },
          ),
          EnemyHeader(
            image: widget.enemyImage,
            tag: widget.enemy.enemyId!,
            code: widget.enemy.enemyIndex!,
          ),
        ],
      ),
    );
  }
}
